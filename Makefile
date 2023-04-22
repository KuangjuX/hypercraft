TARGET		:= riscv64gc-unknown-none-elf
MODE		:= debug

APP			?= hello_world
APP_ELF		:= target/$(TARGET)/$(MODE)/$(APP)
APP_BIN		:= target/$(TARGET)/$(MODE)/$(APP).bin
CPUS		:= 1

OBJDUMP     := rust-objdump --arch-name=riscv64
OBJCOPY     := rust-objcopy --binary-architecture=riscv64

QEMUPATH	?= ~/software/qemu/qemu-7.1.0/build/
QEMU 		:= $(QEMUPATH)qemu-system-riscv64
BOOTLOADER	:= bootloader/rustsbi-qemu.bin


APP_ENTRY_PA := 0x80200000

QEMUOPTS	= --machine virt -m 3G -bios $(BOOTLOADER) -nographic
QEMUOPTS	+=-device loader,file=$(APP_BIN),addr=$(APP_ENTRY_PA)

$(APP_BIN):
	cargo build --manifest-path=apps/$(APP)/Cargo.toml
	$(OBJCOPY) $(APP_ELF) --strip-all -O binary $@

qemu: $(APP_BIN)
	$(QEMU) $(QEMUOPTS)
