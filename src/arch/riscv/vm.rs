use super::{csrs::Hvip, traps, HyperCallMsg, RiscvCsrTrait, Sie};
use crate::{GuestPageTableTrait, HyperCraftHal, HyperError, HyperResult, VmCpus, VmExitInfo};

/// A VM that is being run.
pub struct VM<H: HyperCraftHal, G: GuestPageTableTrait> {
    vcpus: VmCpus<H, G>,
}

impl<H: HyperCraftHal, G: GuestPageTableTrait> VM<H, G> {
    pub fn new(vcpus: VmCpus<H, G>) -> HyperResult<Self> {
        Ok(Self { vcpus })
    }

    /// Run the host VM's vCPU with ID `vcpu_id`. Does not return.
    pub fn run(&mut self, vcpu_id: usize) {
        let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();

        // Set htimedelta for ALL VCPU'f of the VM.
        loop {
            let vm_exit_info = vcpu.run();

            H::vmexit_handler(vcpu, vm_exit_info);

            if let VmExitInfo::Ecall(sbi_msg) = vm_exit_info {
                if let Some(info) = sbi_msg {
                    if let HyperCallMsg::SetTimer(_) = info {
                        // // Disable guest timer interrupt
                        // let hvip = Hvip::new();
                        // hvip.read_and_clear_bits(traps::interrupt::VIRTUAL_SUPERVISOR_TIMER);
                        // //  Enable host timer interrupt
                        // let sie = Sie::new();
                        // sie.read_and_set_bits(traps::interrupt::SUPERVISOR_TIMER);
                        unsafe {
                            riscv::register::hvip::clear_vstip();
                            riscv::register::sie::set_stimer();
                        }
                    }
                }
            }
        }
    }
}

// Privaie function
impl<H: HyperCraftHal, G: GuestPageTableTrait> VM<H, G> {}
