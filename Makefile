TARGET		:= riscv64gc-unknown-none-elf
MODE		:= release

ARCH 		?= riscv64

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

GUEST 		?= rCore-Tutorial-v3
GUEST_ELF	?= guest/rCore-Tutorial-v3/rCore-Tutorial-v3
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

QEMUOPTS	= --machine virt -m 3G -bios $(BOOTLOADER) -nographic -smp $(CPUS)
QEMUOPTS	+=-device loader,file=$(APP_BIN),addr=$(APP_ENTRY_PA)
ifeq ($(GUEST), rCore-Tutorial-v3)
	QEMUOPTS	+=-drive file=guest/rCore-Tutorial-v3/fs.img,if=none,format=raw,id=x0
	QEMUOPTS	+=-device virtio-blk-device,drive=x0
	QEMUOPTS	+=-device virtio-gpu-device
	QEMUOPTS	+=-device virtio-keyboard-device
	QEMUOPTS	+=-device virtio-mouse-device
	QEMUOPTS 	+=-device virtio-net-device,netdev=net0
	QEMUOPTS	+=-netdev user,id=net0,hostfwd=udp::6200-:2000
endif
ifeq ($(APP), hv)
	QEMUOPTS 	+=-device loader,file=$(GUEST_DTB),addr=0x90000000
	QEMUOPTS	+=-device loader,file=$(GUEST_BIN),addr=0x90200000
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
