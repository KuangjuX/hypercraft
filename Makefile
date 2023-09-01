TARGET		:= riscv64gc-unknown-none-elf
MODE		:= release

# ARCH 		?= riscv64
ARCH 		?= aarch64

APP			?= hv
APP_ELF		:= target/$(TARGET)/$(MODE)/$(APP)
APP_BIN		:= target/$(TARGET)/$(MODE)/$(APP).bin
CPUS		?= 1
LOG			?= debug

OBJDUMP     := rust-objdump --arch-name=riscv64
OBJCOPY     := rust-objcopy --binary-architecture=riscv64

GDB			:= riscv64-unknown-elf-gdb

QEMUPATH	?= ~/software/qemu/qemu-7.1.0/build/
QEMU 		:= $(QEMUPATH)qemu-system-riscv64
BOOTLOADER	:= bootloader/rustsbi-qemu.bin

ROOTFS		?= guest/linux/rootfs.img

GUEST 		?= linux
GUEST_ELF	?= guest/$(GUEST)/$(GUEST)
GUEST_BIN	?= $(GUEST_ELF).bin
GUEST_DTB	?= $(GUEST_ELF).dtb

PLATFORM 	?= qemu-virt-riscv

ifeq ($(APP), hello_world)
	features-y  := 
else ifeq ($(APP), hv)
	features-y  := libax/platform-$(PLATFORM)
	features-y  += libax/log-level-$(LOG)
	features-y  += libax/alloc
	features-y  += libax/hv
	features-y  += libax/paging
	features-y  += libax/irq
endif


APP_ENTRY_PA := 0x80200000

QEMUOPTS	= --machine virt -m 3G -bios $(BOOTLOADER) -nographic
QEMUOPTS	+=-kernel $(APP_BIN)

ifeq ($(GUEST), rCore-Tutorial-v3)
	QEMUOPTS	+=-drive file=guest/rCore-Tutorial-v3/fs.img,if=none,format=raw,id=x0
	QEMUOPTS	+=-device virtio-blk-device,drive=x0
	QEMUOPTS	+=-device virtio-gpu-device
	QEMUOPTS	+=-device virtio-keyboard-device
	QEMUOPTS	+=-device virtio-mouse-device
	QEMUOPTS 	+=-device virtio-net-device,netdev=net0
	QEMUOPTS	+=-netdev user,id=net0,hostfwd=udp::6200-:2000
else ifeq ($(GUEST), rtthread)
	QEMUOPTS    +=-drive if=none,file=guest/rtthread/sd.bin,format=raw,id=blk0 -device virtio-blk-device,drive=blk0,bus=virtio-mmio-bus.0
	QEMUOPTS 	+=-netdev user,id=tap0 -device virtio-net-device,netdev=tap0,bus=virtio-mmio-bus.1
	QEMUOPTS 	+=-device virtio-serial-device -chardev socket,host=127.0.0.1,port=4321,server=on,wait=off,telnet=on,id=console0 -device virtserialport,chardev=console0
else ifeq ($(GUEST), linux)
	QEMUOPTS	+=-drive file=$(ROOTFS),format=raw,id=hd0
	QEMUOPTS 	+=-device virtio-blk-device,drive=hd0
	QEMUOPTS	+=-append "root=/dev/vda rw console=ttyS0"
endif

ifeq ($(APP), hv)
	QEMUOPTS 	+=-device loader,file=$(GUEST_DTB),addr=0x90000000,force-raw=on
	QEMUOPTS	+=-device loader,file=$(GUEST_BIN),addr=0x90200000,force-raw=on
endif

LD_SCRIPTS	:= hvruntime/src/linker.ld

ARGS		:= -- -Clink-arg=-T$(LD_SCRIPTS) -Cforce-frame-pointers=yes 

$(APP_BIN):
	LOG=$(LOG) cargo rustc --release --features "$(features-y)" --manifest-path=$(APP)/Cargo.toml $(ARGS)
	$(OBJCOPY) $(APP_ELF) --strip-all -O binary $@

$(GUEST_BIN):
	cargo rustc --manifest-path=guest/$(GUEST)/Cargo.toml -- -Clink-arg=-Tguest/$(GUEST)/src/linker.ld -Cforce-frame-pointers=yes
	$(OBJCOPY) $(GUEST_ELF) --strip-all -O binary $@

qemu: $(APP_BIN) $(GUEST_BIN)
	$(QEMU) $(QEMUOPTS)

clean:
	rm $(APP_BIN) $(APP_ELF)

debug: $(APP_BIN)
	@tmux new-session -d \
		"$(QEMU) $(QEMUOPTS) -s -S" && \
		tmux split-window -h "$(GDB) -ex 'file $(APP_ELF)' -ex 'set arch riscv:rv64' -ex 'target remote localhost:1234'" && \
		tmux -2 attach-session -d

qemu-gdb: $(APP_ELF)
	$(QEMU) $(QEMUOPTS) -S -gdb tcp::1234

gdb: $(APP_ELF)
	$(GDB) $(APP_ELF)
