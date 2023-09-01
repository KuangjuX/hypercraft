#[derive(Copy, Clone)]
pub enum VmmEvent {
    VmmBoot,
    VmmReboot,
    VmmShutdown,
    VmmAssignCpu,
    VmmRemoveCpu,
}