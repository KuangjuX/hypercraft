use super::{
    devices::plic::{PlicState, MAX_CONTEXTS},
    regs::GeneralPurposeRegisters,
    traps,
    vcpu::{self, VmCpuRegisters},
    vm_pages::VmPages,
    HyperCallMsg, RiscvCsrTrait, CSR,
};
use crate::{
    vcpus::VM_CPUS_MAX, GprIndex, GuestPageTableTrait, GuestPhysAddr, GuestVirtAddr, HyperCraftHal,
    HyperError, HyperResult, VCpu, VmCpus, VmExitInfo,
};
use riscv_decode::Instruction;

/// A VM that is being run.
pub struct VM<H: HyperCraftHal, G: GuestPageTableTrait> {
    vcpus: VmCpus<H>,
    gpt: G,
    vm_pages: VmPages,
    plic: PlicState,
}

impl<H: HyperCraftHal, G: GuestPageTableTrait> VM<H, G> {
    #[allow(clippy::default_constructed_unit_structs)]
    pub fn new(vcpus: VmCpus<H>, gpt: G) -> HyperResult<Self> {
        Ok(Self {
            vcpus,
            gpt,
            vm_pages: VmPages::default(),
            plic: PlicState::new(0x0c00_0000),
        })
    }

    pub fn init_vcpus(&mut self) {
        for vcpu_id in 0..VM_CPUS_MAX {
            let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
            vcpu.init_page_map(self.gpt.token());
        }
    }

    #[allow(unused_variables, deprecated)]
    /// Run the host VM's vCPU with ID `vcpu_id`. Does not return.
    pub fn run(&mut self, vcpu_id: usize) {
        let mut vm_exit_info: VmExitInfo;
        let mut gprs = GeneralPurposeRegisters::default();
        loop {
            let mut advance_pc = false;
            {
                let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
                vm_exit_info = vcpu.run();
                vcpu.save_gprs(&mut gprs);
            }

            match vm_exit_info {
                VmExitInfo::Ecall(sbi_msg) => {
                    if let Some(sbi_msg) = sbi_msg {
                        match sbi_msg {
                            HyperCallMsg::PutChar(c) => {
                                sbi_rt::legacy::console_putchar(c);
                            }
                            HyperCallMsg::SetTimer(timer) => {
                                sbi_rt::set_timer(timer as u64);
                                // Clear guest timer interrupt
                                CSR.hvip.read_and_clear_bits(
                                    traps::interrupt::VIRTUAL_SUPERVISOR_TIMER,
                                );
                                //  Enable host timer interrupt
                                CSR.sie
                                    .read_and_set_bits(traps::interrupt::SUPERVISOR_TIMER);
                            }
                            HyperCallMsg::Reset(_) => {
                                sbi_rt::system_reset(sbi_rt::Shutdown, sbi_rt::SystemFailure);
                            }
                            _ => todo!(),
                        }
                        // vcpu.advance_pc(4);
                        advance_pc = true;
                    } else {
                        panic!()
                    }
                }
                VmExitInfo::PageFault {
                    fault_addr,
                    falut_pc,
                    inst,
                    priv_level,
                } => match priv_level {
                    super::vmexit::PrivilegeLevel::Supervisor => {
                        let _ = self
                            .handle_page_fault(falut_pc, inst, fault_addr, &mut gprs)
                            .map_err(|err| {
                                panic!("Page fault at {:x} with error {:?}", falut_pc, err)
                            });
                        advance_pc = true;
                    }
                    super::vmexit::PrivilegeLevel::User => {}
                },
                _ => {}
            }

            {
                let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
                vcpu.restore_gprs(&gprs);
                if advance_pc {
                    vcpu.advance_pc(4);
                }
            }
        }
    }
}

// Privaie methods implementation
impl<H: HyperCraftHal, G: GuestPageTableTrait> VM<H, G> {
    fn handle_page_fault(
        &mut self,
        inst_addr: GuestVirtAddr,
        inst: u32,
        fault_addr: GuestPhysAddr,
        gprs: &mut GeneralPurposeRegisters,
    ) -> HyperResult<()> {
        //  plic
        if fault_addr >= self.plic.base() && fault_addr < self.plic.base() + 0x0400_0000 {
            self.handle_plic(inst_addr, inst, fault_addr, gprs)
        } else {
            Err(HyperError::PageFault)
        }
    }

    #[allow(clippy::needless_late_init)]
    fn handle_plic(
        &mut self,
        inst_addr: GuestVirtAddr,
        inst: u32,
        fault_addr: GuestPhysAddr,
        gprs: &mut GeneralPurposeRegisters,
    ) -> HyperResult<()> {
        let decode_inst: Instruction;
        if inst == 0 {
            // If hinst does not provide information about trap,
            // we must read the instruction from guest's memory maunally.
            decode_inst = self.vm_pages.fetch_guest_instruction(inst_addr)?;
        } else {
            decode_inst = riscv_decode::decode(inst).map_err(|_| HyperError::DecodeError)?;
        }
        match decode_inst {
            Instruction::Sw(i) => {
                let val = gprs.reg(GprIndex::from_raw(i.rs2()).unwrap()) as u32;
                self.plic.write_u32(fault_addr, val)
            }
            Instruction::Lw(i) => {
                let val = self.plic.read_u32(fault_addr);
                gprs.set_reg(GprIndex::from_raw(i.rd()).unwrap(), val as usize)
            }
            _ => return Err(HyperError::InvalidInstruction),
        }
        Ok(())
    }
}
