// Copyright (c) 2023 Beihang University, Huawei Technologies Co.,Ltd. All rights reserved.
// Rust-Shyper is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//          http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

use alloc::slice::{Iter, IterMut};

use crate::arch::ContextFrame;
use crate::arch::vcpu::Vcpu;

pub struct VcpuArray {
    array: [Option<Vcpu>; VM_NUM_MAX],
    len: usize,
}
// Mutex<VecDeque<usize>>??
impl VcpuArray {
    pub const fn new() -> Self {
        Self {
            array: [const { None }; VM_NUM_MAX],
            len: 0,
        }
    }

    #[deprecated]
    pub const fn capacity(&self) -> usize {
        self.array.len()
    }

    #[inline]
    pub fn pop_vcpu_through_vmid(&self, vm_id: usize) -> Option<Vcpu> {
        self.array[vm_id].clone()
    }

    #[inline]
    pub fn vcpu_num(&self) -> usize {
        self.len
    }

    pub fn append_vcpu(&mut self, vcpu: Vcpu) {
        // There is only 1 VCPU from a VM in a PCPU
        let vm_id = vcpu.vm_id();
        if vm_id >= self.array.len() {
            panic!("vm_id > self.array.len()");
        }
        if self.array[vm_id].is_some() {
            panic!("self.array[vm_id].is_some()");
        }
        vcpu.set_phys_id(current_cpu().id);
        info!(
            "append_vcpu: append VM[{}] vcpu {} on core {}",
            vm_id,
            vcpu.id(),
            current_cpu().id
        );
        self.array[vm_id] = Some(vcpu);
        self.len += 1;
    }

    pub fn remove_vcpu(&mut self, vm_id: usize) -> Option<Vcpu> {
        if vm_id >= self.array.len() {
            panic!("vm_id > self.array.len()");
        }
        match self.array[vm_id].clone() {
            Some(vcpu) => {
                self.len -= 1;
                self.array[vm_id] = None;
                if self.len == 0 {
                    // hard code: remove el1 timer interrupt 27
                    interrupt_cpu_enable(27, false);
                }
                Some(vcpu)
            }
            None => panic!(
                "no vcpu from vm[{}] exist in Core[{}] vcpu_pool",
                vm_id,
                current_cpu().id
            ),
        }
    }

    pub fn iter(&self) -> Iter<'_, Option<Vcpu>> {
        self.array.iter()
    }

    pub fn iter_mut(&mut self) -> IterMut<'_, Option<Vcpu>> {
        self.array.iter_mut()
    }
}

// Todo: add config for base slice
pub fn cpu_sched_init() {
    match PLAT_DESC.cpu_desc.core_list[current_cpu().id].sched {
        SchedRule::RoundRobin => {
            info!("cpu[{}] init Round Robin Scheduler", current_cpu().id);
            current_cpu().sched = SchedType::SchedRR(SchedulerRR::new(1));
        }
        _ => {
            todo!();
        }
    }
}


