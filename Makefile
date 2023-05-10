TARGET		:= riscv64gc-unknown-none-elf
MODE		:= debug

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

PLATFORM 	?= qemu-virt-riscv

ifeq ($(APP), hello_world)
	features-y  := 
else ifeq ($(APP), hv)
	features-y  := libax/platform-$(PLATFORM)
	features-y  += libax/log-level-$(LOG)
	features-y  += libax/alloc
	features-y  += libax/hv
endif


APP_ENTRY_PA := 0x80200000

QEMUOPTS	= --machine virt -m 3G -bios $(BOOTLOADER) -nographic -smp $(CPUS)
QEMUOPTS	+=-device loader,file=$(APP_BIN),addr=$(APP_ENTRY_PA)

LD_SCRIPTS	:= hvruntime/src/linker.ld

ARGS		:= -- -C link-arg=-T$(LD_SCRIPTS) -C force-frame-pointers=yes

$(APP_BIN):
	LOG=$(LOG) cargo rustc --features "$(features-y)" --manifest-path=$(APP)/Cargo.toml $(ARGS)
	$(OBJCOPY) $(APP_ELF) --strip-all -O binary $@

qemu: $(APP_BIN)
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
