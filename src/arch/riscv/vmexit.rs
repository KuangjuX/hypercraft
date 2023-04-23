use riscv::register::mcause::Trap;

pub struct VmExitInfo {
    pub trap_cause: Trap,
}
