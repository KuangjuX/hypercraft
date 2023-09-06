use crate::arch::vcpu::{Vcpu, VcpuState, vcpu_arch_init};
use crate::arch::cpu::CpuState;
use crate::arch::smc::smc_call;
use crate::arch::ipi::{
    ipi_register, IpiType, IpiPowerMessage, PowerEvent, ipi_intra_broadcast_msg,
    IpiInnerMsg, IpiMessage, ipi_send_msg
};
use crate::arch::manageVm::vmm_reboot;
use crate::arch::vm::Vm;
use crate::arch::{current_cpu, active_vm};

pub const PSCI_VERSION: usize = 0x84000000;
pub const PSCI_MIG_INFO_TYPE: usize = 0x84000006;
pub const PSCI_FEATURES: usize = 0x8400000A;
// pub const PSCI_CPU_SUSPEND_AARCH64: usize = 0xc4000001;
// pub const PSCI_CPU_OFF: usize = 0xc4000002;
pub const PSCI_CPU_ON_AARCH64: usize = 0xc4000003;
pub const PSCI_AFFINITY_INFO_AARCH64: usize = 0xc4000004;
pub const PSCI_SYSTEM_OFF: usize = 0x84000008;
pub const PSCI_SYSTEM_RESET: usize = 0x84000009;

pub const PSCI_E_SUCCESS: usize = 0;
pub const PSCI_E_NOT_SUPPORTED: usize = usize::MAX;

#[cfg(feature = "tx2")]
const TEGRA_SIP_GET_ACTMON_CLK_COUNTERS: usize = 0xC2FFFE02;

pub const PSCI_TOS_NOT_PRESENT_MP: usize = 2;

pub fn power_arch_init() {
    if !ipi_register(IpiType::IpiTPower, psci_ipi_handler) {
        panic!("power_arch_init: failed to register ipi IpiTPower");
    }
}

pub fn power_arch_vm_shutdown_secondary_cores(vm: Vm) {
    let m = IpiPowerMessage {
        src: vm.id(),
        event: PowerEvent::PsciIpiCpuReset,
        entry: 0,
        context: 0,
    };

    if !ipi_intra_broadcast_msg(vm, IpiType::IpiTPower, IpiInnerMsg::Power(m)) {
        warn!("power_arch_vm_shutdown_secondary_cores: fail to ipi_intra_broadcast_msg");
    }
}

pub fn power_arch_cpu_on(mpidr: usize, entry: usize, ctx: usize) -> usize {
    // println!("power_arch_cpu_on, {:x}, {:x}, {:x}", PSCI_CPU_ON_AARCH64, mpidr, entry);
    let r = smc_call(PSCI_CPU_ON_AARCH64, mpidr, entry, ctx).0;
    // println!("smc return val is {}", r);
    r
}

pub fn power_arch_cpu_shutdown() {
    // gic_cpu_init();
    // gicc_clear_current_irq(true);
    // timer_enable(false);
    // cpu_idle();
}

pub fn power_arch_sys_reset() {
    smc_call(PSCI_SYSTEM_RESET, 0, 0, 0);
}

pub fn power_arch_sys_shutdown() {
    smc_call(PSCI_SYSTEM_OFF, 0, 0, 0);
}

fn psci_guest_sys_reset() {
    vmm_reboot();
}

#[inline(never)]
pub fn smc_guest_handler(fid: usize, x1: usize, x2: usize, x3: usize) -> bool {
    debug!(
        "smc_guest_handler: fid 0x{:x}, x1 0x{:x}, x2 0x{:x}, x3 0x{:x}",
        fid, x1, x2, x3
    );
    let r;
    match fid {
        PSCI_VERSION => {
            r = smc_call(PSCI_VERSION, 0, 0, 0).0;
        }
        PSCI_MIG_INFO_TYPE => {
            r = PSCI_TOS_NOT_PRESENT_MP;
        }
        PSCI_CPU_ON_AARCH64 => {
            r = psci_guest_cpu_on(x1, x2, x3);
        }
        PSCI_AFFINITY_INFO_AARCH64 => {
            r = 0;
        }
        PSCI_SYSTEM_RESET => {
            psci_guest_sys_reset();
            r = 0;
        }
        ATURES => match x1 {
            PSCI_VERSION | PSCI_CPU_ON_AARCH64 | PSCI_FEATURES => {
                r = PSCI_E_SUCCESS;
            }
            _ => {
                r = PSCI_E_NOT_SUPPORTED;
            }
        },
        _ => {
            // unimplemented!();
            return false;
        }
    }

    let idx = 0;
    let val = r;
    current_cpu().set_gpr(idx, val);

    true
}

fn psci_vcpu_on(vcpu: Vcpu, entry: usize, ctx: usize) {
    // println!("psci vcpu on， entry {:x}, ctx {:x}", entry, ctx);
    if vcpu.phys_id() != current_cpu().cpu_id {
        panic!(
            "cannot psci on vcpu on cpu {} by cpu {}",
            vcpu.phys_id(),
            current_cpu().cpu_id
        );
    }
    current_cpu().cpu_state = CpuState::CpuRun;
    vcpu.reset_context();
    vcpu.set_gpr(0, ctx);
    vcpu.set_elr(entry);
    // Just wake up the vcpu and
    // invoke current_cpu().sched.schedule()
    // let the scheduler enable or disable timer
    // current_cpu().scheduler().wakeup(vcpu);
    // current_cpu().scheduler().do_schedule(); todo()
}

// Todo: need to support more vcpu in one Core
pub fn psci_ipi_handler(msg: &IpiMessage) {
    match msg.ipi_message {
        IpiInnerMsg::Power(power_msg) => {
            let trgt_vcpu = match current_cpu().vcpu_array.pop_vcpu_through_vmid(power_msg.src) {
                None => {
                    warn!(
                        "Core {} failed to find target vcpu, source vmid {}",
                        current_cpu().cpu_id,
                        power_msg.src
                    );
                    return;
                }
                Some(vcpu) => vcpu,
            };
            match power_msg.event {
                PowerEvent::PsciIpiCpuOn => {
                    if trgt_vcpu.state() as usize != VcpuState::VcpuInv as usize {
                        warn!(
                            "psci_ipi_handler: target VCPU {} in VM {} is already running",
                            trgt_vcpu.id(),
                            trgt_vcpu.vm().unwrap().id()
                        );
                        return;
                    }
                    info!(
                        "Core {} (vm {}, vcpu {}) is woke up",
                        current_cpu().cpu_id,
                        trgt_vcpu.vm().unwrap().id(),
                        trgt_vcpu.id()
                    );
                    psci_vcpu_on(trgt_vcpu, power_msg.entry, power_msg.context);
                }
                PowerEvent::PsciIpiCpuOff => {
                    // TODO: 为什么ipi cpu off是当前vcpu shutdown，而vcpu shutdown 最后是把平台的物理核心shutdown
                    // 没有用到。不用管
                    // current_cpu().active_vcpu.clone().unwrap().shutdown();
                    unimplemented!("PowerEvent::PsciIpiCpuOff")
                }
                PowerEvent::PsciIpiCpuReset => {
                    vcpu_arch_init(active_vm().unwrap(), current_cpu().active_vcpu.clone().unwrap());
                }
            }
        }
        _ => {
            panic!(
                "psci_ipi_handler: cpu{} receive illegal psci ipi type",
                current_cpu().cpu_id
            );
        }
    }
}

pub fn psci_guest_cpu_on(mpidr: usize, entry: usize, ctx: usize) -> usize {
    let vcpu_id = mpidr & 0xff;
    let vm = active_vm().unwrap();
    let physical_linear_id = vm.vcpuid_to_pcpuid(vcpu_id);

    if vcpu_id >= vm.cpu_num() || physical_linear_id.is_err() {
        warn!("psci_guest_cpu_on: target vcpu {} not exist", vcpu_id);
        return usize::MAX - 1;
    }
    #[cfg(feature = "tx2")]
    {
        let cluster = (mpidr >> 8) & 0xff;
        if vm.id() == 0 && cluster != 1 {
            warn!("psci_guest_cpu_on: L4T only support cluster #1");
            return usize::MAX - 1;
        }
    }

    let m = IpiPowerMessage {
        src: vm.id(),
        event: PowerEvent::PsciIpiCpuOn,
        entry,
        context: ctx,
    };

    if !ipi_send_msg(physical_linear_id.unwrap(), IpiType::IpiTPower, IpiInnerMsg::Power(m)) {
        warn!("psci_guest_cpu_on: fail to send msg");
        return usize::MAX - 1;
    }

    0
}
