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
use page_table::PagingIf;
use core::mem::size_of;
use spin::Mutex;

// type ContextFrame = crate::arch::contextFrame::Aarch64ContextFrame;
use cortex_a::registers::*;
use tock_registers::interfaces::*;
 

use crate::arch::{ContextFrame, memcpy_safe, current_cpu, active_vm_id, active_vcpu_id};
use crate::arch::contextFrame::VmContext;
use crate::traits::ContextFrameTrait;
use crate::arch::vm::{Vm, VmState, vm_interface_set_state};
use crate::arch::gic::{GICD, GICC, GICH};
use crate::arch::interrupt::{interrupt_vm_inject, cpu_interrupt_unmask};
use crate::arch::cpu::CpuState;

#[derive(Clone, Copy, Debug)]
pub enum VcpuState {
    VcpuInv = 0,
    VcpuPend = 1,
    VcpuAct = 2,
}

#[derive(Clone)]
pub struct Vcpu {
    pub inner: Arc<Mutex<VcpuInner>>,
}

impl Vcpu {
    pub fn new(id:usize, phys_id: usize) -> Vcpu {
        Vcpu {
            inner: Arc::new(Mutex::new(VcpuInner::new(id, phys_id))),
        }
    }

    pub fn init(&self, vm: Vm<dyn PagingIf>) {
        let mut inner = self.inner.lock();
        inner.vm = Some(vm.clone());
        drop(inner);
        vcpu_arch_init(vm, self.clone());
        self.reset_context();
    }

    pub fn context_vm_store(&self) {
        self.save_cpu_ctx();

        let mut inner = self.inner.lock();
        inner.vm_ctx.ext_regs_store();
        inner.vm_ctx.fpsimd_save_context();
        inner.vm_ctx.gic_save_state();
    }

    pub fn context_vm_restore(&self) {
        // info!("context_vm_restore");
        self.restore_cpu_ctx();

        let inner = self.inner.lock();
        // restore vm's VFP and SIMD
        inner.vm_ctx.fpsimd_restore_context();
        inner.vm_ctx.gic_restore_state();
        inner.vm_ctx.ext_regs_restore();
        drop(inner);

        self.inject_int_inlist();
    }

    pub fn gic_restore_context(&self) {
        let inner = self.inner.lock();
        inner.vm_ctx.gic_restore_state();
    }

    pub fn gic_save_context(&self) {
        let mut inner = self.inner.lock();
        inner.vm_ctx.gic_save_state();
    }

    pub fn save_cpu_ctx(&self) {
        let inner = self.inner.lock();
        match current_cpu().context_addr {
            None => {
                info!("save_cpu_ctx: cpu{} ctx is NULL", current_cpu().cpu_id);
            }
            Some(ctx) => {
                memcpy_safe(
                    &(inner.vcpu_ctx) as *const _ as *const u8,
                    ctx as *const u8,
                    size_of::<ContextFrame>(),
                );
            }
        }
    }

    fn restore_cpu_ctx(&self) {
        let inner = self.inner.lock();
        match current_cpu().context_addr {
            None => {
                info!("restore_cpu_ctx: cpu{} ctx is NULL", current_cpu().cpu_id);
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

    pub fn set_phys_id(&self, phys_id: usize) {
        let mut inner = self.inner.lock();
        info!("set vcpu {} phys id {}", inner.id, phys_id);
        inner.phys_id = phys_id;
    }

    pub fn set_gich_ctlr(&self, ctlr: u32) {
        let mut inner = self.inner.lock();
        inner.vm_ctx.gic_state.saved_ctlr = ctlr;
    }

    pub fn set_hcr(&self, hcr: u64) {
        let mut inner = self.inner.lock();
        inner.vm_ctx.hcr_el2 = hcr;
    }

    pub fn state(&self) -> VcpuState {
        let inner = self.inner.lock();
        inner.state.clone()
    }

    pub fn set_state(&self, state: VcpuState) {
        let mut inner = self.inner.lock();
        inner.state = state;
    }

    pub fn id(&self) -> usize {
        let inner = self.inner.lock();
        inner.id
    }

    pub fn vm(&self) -> Option<Vm<dyn PagingIf>> {
        let inner = self.inner.lock();
        inner.vm.clone()
    }

    pub fn phys_id(&self) -> usize {
        let inner = self.inner.lock();
        inner.phys_id
    }

    pub fn vm_id(&self) -> usize {
        self.vm().unwrap().id()
    }

    pub fn vm_pt_dir(&self) -> usize {
        self.vm().unwrap().pt_dir()
    }

    pub fn reset_context(&self) {
        let mut inner = self.inner.lock();
        inner.reset_context();
    }

    pub fn context_ext_regs_store(&self) {
        let mut inner = self.inner.lock();
        inner.context_ext_regs_store();
    }

    pub fn vcpu_ctx_addr(&self) -> usize {
        let inner = self.inner.lock();
        inner.vcpu_ctx_addr()
    }

    pub fn set_elr(&self, elr: usize) {
        let mut inner = self.inner.lock();
        inner.set_elr(elr);
    }

    pub fn elr(&self) -> usize {
        let inner = self.inner.lock();
        inner.vcpu_ctx.exception_pc()
    }

    pub fn set_gpr(&self, idx: usize, val: usize) {
        let mut inner = self.inner.lock();
        inner.set_gpr(idx, val);
    }

    pub fn show_ctx(&self) {
        let inner = self.inner.lock();
        inner.show_ctx();
    }

    pub fn push_int(&self, int: usize) {
        let mut inner = self.inner.lock();
        if !inner.int_list.contains(&int) {
            inner.int_list.push(int);
        }
    }

    fn inject_int_inlist(&self) {
        match self.vm() {
            None => {}
            Some(vm) => {
                let mut inner = self.inner.lock();
                let int_list = inner.int_list.clone();
                inner.int_list.clear();
                drop(inner);
                for int in int_list {
                    // info!("schedule: inject int {} for vm {}", int, vm.id());
                    interrupt_vm_inject(vm.clone(), self.clone(), int);
                }
            }
        }
    }
}

pub struct VcpuInner {
    pub id: usize,
    pub phys_id: usize,
    pub state: VcpuState,
    pub vm: Option<Vm<dyn PagingIf>>,
    pub int_list: Vec<usize>,
    pub vcpu_ctx: ContextFrame,
    pub vm_ctx: VmContext,
}

impl VcpuInner {
    pub fn new(id: usize, phys_id: usize) -> VcpuInner {
        VcpuInner {
            id: id,
            phys_id: phys_id,
            state: VcpuState::VcpuInv,
            vm: None,
            int_list: vec![],
            vcpu_ctx: ContextFrame::default(),
            vm_ctx: VmContext::default(),
        }
    }

    fn vcpu_ctx_addr(&self) -> usize {
        &(self.vcpu_ctx) as *const _ as usize
    }

    fn vm_id(&self) -> usize {
        let vm = self.vm.as_ref().unwrap();
        vm.id()
    }

    fn arch_ctx_reset(&mut self) {
        // let migrate = self.vm.as_ref().unwrap().migration_state();
        // if !migrate {
        self.vm_ctx.cntvoff_el2 = 0;
        self.vm_ctx.sctlr_el1 = 0x30C50830;
        self.vm_ctx.cntkctl_el1 = 0;
        self.vm_ctx.pmcr_el0 = 0;
        self.vm_ctx.vtcr_el2 = 0x8001355c;
        // }
        let mut vmpidr = 0;
        vmpidr |= 1 << 31;

        vmpidr |= self.id;
        self.vm_ctx.vmpidr_el2 = vmpidr as u64;
    }
    fn reset_vtimer_offset(&mut self) {
        let curpct = cortex_a::registers::CNTPCT_EL0.get() as u64;
        self.vm_ctx.cntvoff_el2 = curpct - self.vm_ctx.cntvct_el0;
    }
    
    fn reset_context(&mut self) {
        self.arch_ctx_reset();
        self.gic_ctx_reset();
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

    fn context_ext_regs_store(&mut self) {
        self.vm_ctx.ext_regs_store();
    }

    fn reset_vm_ctx(&mut self) {
        self.vm_ctx.reset();
    }

    fn set_elr(&mut self, elr: usize) {
        self.vcpu_ctx.set_exception_pc(elr);
    }

    fn set_gpr(&mut self, idx: usize, val: usize) {
        self.vcpu_ctx.set_gpr(idx, val);
    }

    fn show_ctx(&self) {
        info!(
            "cntvoff_el2 {:x}, sctlr_el1 {:x}, cntkctl_el1 {:x}, pmcr_el0 {:x}, vtcr_el2 {:x} x0 {:x}",
            self.vm_ctx.cntvoff_el2,
            self.vm_ctx.sctlr_el1,
            self.vm_ctx.cntkctl_el1,
            self.vm_ctx.pmcr_el0,
            self.vm_ctx.vtcr_el2,
            self.vcpu_ctx.gpr(0)
        );
    }
}

pub static VCPU_LIST: Mutex<Vec<Vcpu>> = Mutex::new(Vec::new());

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

pub fn vcpu_arch_init(vm: Vm<dyn PagingIf>, vcpu: Vcpu) {
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

pub fn vcpu_idle(_vcpu: Vcpu) -> ! {
    // cpu_interrupt_unmask();
    cpu_interrupt_unmask();
    loop {
        // TODO: replace it with an Arch function `arch_idle`
        cortex_a::asm::wfi();
    }
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
