// Copyright (c) 2023 Beihang University, Huawei Technologies Co.,Ltd. All rights reserved.
// Rust-Shyper is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//          http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

use alloc::sync::Arc;
use alloc::vec::Vec;
use core::mem::size_of;
use core::arch::global_asm;
use spin::Mutex;
use core::marker::PhantomData;

// type ContextFrame = crate::arch::contextFrame::Aarch64ContextFrame;
use cortex_a::registers::*;
use tock_registers::interfaces::*;
 
use crate::arch::ContextFrame;
use crate::arch::contextFrame::VmContext;
use crate::traits::ContextFrameTrait;
use crate::HyperCraftHal;

global_asm!(include_str!("guest.S"));
extern "C" {
    fn context_vm_entry(ctx: usize) -> !;
}

#[repr(C)]
#[derive(Clone, Debug)]
pub struct VmCpuRegisters {
    pub trap_context_regs: ContextFrame,
    pub vm_system_regs: VmContext,
}

impl VmCpuRegisters {
    pub fn default() -> VmCpuRegisters {
        VmCpuRegisters {
            trap_context_regs: ContextFrame::default(),
            vm_system_regs: VmContext::default(),
        }
    }
}

#[derive(Clone)]
pub struct VCpu<H:HyperCraftHal> {
    pub vcpu_id: usize,
    pub regs: VmCpuRegisters,
    // pub vcpu_ctx: ContextFrame,
    // pub vm_ctx: VmContext,
    // pub vm: Option<Vm>,
    // pub int_list: Vec<usize>,
    marker: PhantomData<H>,
}

impl <H:HyperCraftHal> VCpu<H> {
    pub fn new(id: usize) -> Self {
        Self {
            vcpu_id: id,
            regs: VmCpuRegisters::default(),
            // vcpu_ctx: ContextFrame::default(),
            // vm_ctx: VmContext::default(),
            // vm: None,
            // int_list: vec![],
            marker: PhantomData,
        }
    }

    pub fn init(&self, kernel_entry_point: usize, device_tree_ipa: usize) {
        self.vcpu_arch_init(kernel_entry_point, device_tree_ipa);
        self.init_vm_context();
    }


    pub fn vcpu_id(&self) -> usize {
        self.vcpu_id
    }

    pub fn run(&self) -> ! {
        unsafe {
            context_vm_entry(self.vcpu_ctx_addr());
        }
    }

    /* 
    pub fn restore_cpu_ctx(&self) {
        let inner = self.inner.lock();

        match current_cpu().ctx {
            None => {
                println!("restore_cpu_ctx: cpu{} ctx is NULL", current_cpu().id);
            }
            Some(ctx) => {
                memcpy_safe(
                    ctx as *const u8,
                    &(inner.vcpu_ctx) as *const _ as *const u8,
                    size_of::<ContextFrame>(),
                );
            }
        }
    }
    */

    pub fn vcpu_ctx_addr(&self) -> usize {
        &(self.regs.trap_context_regs) as *const _ as usize
    }

    pub fn set_elr(&mut self, elr: usize) {
        self.regs.trap_context_regs.set_exception_pc(elr);
    }

    pub fn set_gpr(&mut self, idx: usize, val: usize) {
        self.regs.trap_context_regs.set_gpr(idx, val);
    }

    fn init_vm_context(&mut self) {
        self.regs.vm_system_regs.cntvoff_el2 = 0;
        self.regs.vm_system_regs.sctlr_el1 = 0x30C50830;
        self.regs.vm_system_regs.cntkctl_el1 = 0;
        self.regs.vm_system_regs.pmcr_el0 = 0;
        self.regs.vm_system_regs.vtcr_el2 = 0x8001355c;
        let mut vmpidr = 0;
        vmpidr |= 1 << 31;
        vmpidr |= self.vcpu_id;
        self.regs.vm_system_regs.vmpidr_el2 = vmpidr as u64;
        
        // self.gic_ctx_reset(); // because of passthrough gic, do not need gic context anymore?
    }

    fn vcpu_arch_init(&mut self, kernel_entry_point: usize, device_tree_ipa: usize) {
        self.set_gpr(0, device_tree_ipa);
        self.set_elr(kernel_entry_point);
        self.regs.trap_context_regs.spsr =( SPSR_EL1::M::EL1h + 
                                            SPSR_EL1::I::Masked + 
                                            SPSR_EL1::F::Masked + 
                                            SPSR_EL1::A::Masked + 
                                            SPSR_EL1::D::Masked )
                                            .value;
    }

/*
    fn arch_ctx_reset(&mut self) {
        // let migrate = self.vm.as_ref().unwrap().migration_state();
        // if !migrate {
        self.vm_ctx.cntvoff_el2 = 0;
        self.vm_ctx.sctlr_el1 = 0x30C50830;
        self.vm_ctx.cntkctl_el1 = 0;
        self.vm_ctx.pmcr_el0 = 0;
        self.vm_ctx.vtcr_el2 = 0x8001355c;
        // }
        // let mut vmpidr = 0;
        // vmpidr |= 1 << 31;

        // vmpidr |= self.id;
        // self.vm_ctx.vmpidr_el2 = vmpidr as u64;
    }

    fn reset_context(&mut self) {
        self.arch_ctx_reset();
        // self.gic_ctx_reset(); // because of passthrough gic, do not need gic context anymore?
    }

    fn gic_ctx_reset(&mut self) {
        if let Some(gich) = GICH {
            for i in 0..gich.get_lrs_num() {
            self.vm_ctx.gic_state.saved_lr[i] = 0;
            }
        } else {
            info!("No available gich in gic_ctx_reset")
        }
        self.vm_ctx.gic_state.saved_hcr |= 1 << 2;
    }
    
    */

}

// pub static VCPU_LIST: Mutex<Vec<Vcpu>> = Mutex::new(Vec::new());
/* 

pub fn restore_vcpu_gic(cur_vcpu: Option<Vcpu>, trgt_vcpu: Vcpu) {
    // println!("restore_vcpu_gic");
    match cur_vcpu {
        None => {
            // println!("None cur vmid trgt {}", trgt_vcpu.vm_id());
            trgt_vcpu.gic_restore_context();
        }
        Some(active_vcpu) => {
            if trgt_vcpu.vm_id() != active_vcpu.vm_id() {
                // println!("different vm_id cur {}, trgt {}", active_vcpu.vm_id(), trgt_vcpu.vm_id());
                active_vcpu.gic_save_context();
                trgt_vcpu.gic_restore_context();
            }
        }
    }
}

pub fn save_vcpu_gic(cur_vcpu: Option<Vcpu>, trgt_vcpu: Vcpu) {
    // println!("save_vcpu_gic");
    match cur_vcpu {
        None => {
            trgt_vcpu.gic_save_context();
        }
        Some(active_vcpu) => {
            if trgt_vcpu.vm_id() != active_vcpu.vm_id() {
                trgt_vcpu.gic_save_context();
                active_vcpu.gic_restore_context();
            }
        }
    }
}


pub fn vcpu_arch_init(vm: Vm, vcpu: Vcpu) {
    let config = vm.config();
    let mut vcpu_inner = vcpu.inner.lock();
    vcpu_inner.vcpu_ctx.set_argument(config.device_tree_load_ipa());
    vcpu_inner.vcpu_ctx.set_exception_pc(config.kernel_entry_point());
    vcpu_inner.vcpu_ctx.spsr =
        (SPSR_EL1::M::EL1h + SPSR_EL1::I::Masked + SPSR_EL1::F::Masked + SPSR_EL1::A::Masked + SPSR_EL1::D::Masked)
            .value;
}
 
pub fn vcpu_alloc() -> Option<Vcpu> {
    let mut vcpu_list = VCPU_LIST.lock();
    if vcpu_list.len() >= 8 {
        return None;
    }
    let val = Vcpu::default();
    vcpu_list.push(val.clone());
    Some(val)
}

pub fn vcpu_remove(vcpu: Vcpu) {
    let mut vcpu_list = VCPU_LIST.lock();
    for (idx, core) in vcpu_list.iter().enumerate() {
        if core.id() == vcpu.id() && core.vm_id() == vcpu.vm_id() {
            vcpu_list.remove(idx);
            return;
        }
    }
    panic!("illegal vm{} vcpu{}, not exist in vcpu_list", vcpu.vm_id(), vcpu.id());
}

// WARNING: No Auto `drop` in this function

pub fn vcpu_run(announce: bool) -> ! {
    {
        let vcpu = current_cpu().active_vcpu.clone().unwrap();
        let vm = vcpu.vm().unwrap();

        current_cpu().cpu_state = CpuState::CpuRun;
        vm_interface_set_state(active_vm_id(), VmState::VmActive);

        vcpu.context_vm_restore();
    }
    extern "C" {
        fn context_vm_entry(ctx: usize) -> !;
    }
    unsafe {
        context_vm_entry(current_cpu().context_addr.unwrap());
    }
}
*/