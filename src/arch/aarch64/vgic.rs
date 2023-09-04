// Copyright (c) 2023 Beihang University, Huawei Technologies Co.,Ltd. All rights reserved.
// Rust-Shyper is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//          http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

use alloc::collections::{BTreeMap, VecDeque};
use alloc::sync::Arc;
use alloc::vec::Vec;

use spin::Mutex;

use crate::{arch::GICH, kernel::IpiInitcMessage};
use crate::board::{PLATFORM_CPU_NUM_MAX, Platform, PlatOperation};
use crate::device::EmuContext;
use crate::device::EmuDevs;
use crate::kernel::{
    active_vcpu_id, current_cpu, restore_vcpu_gic, save_vcpu_gic, VgicCpuPrivData, VgicIntData, VgicMigData,
};
use crate::kernel::{active_vm, active_vm_id, active_vm_ncpu};
use crate::kernel::{ipi_intra_broadcast_msg, ipi_send_msg, IpiInnerMsg, IpiMessage, IpiType};
use crate::kernel::{InitcEvent, Vcpu, Vm, vm};
use crate::lib::{bit_extract, bit_get, bit_set, bitmap_find_nth, ptr_read_write};

use super::gic::*;

#[derive(Clone)]
struct VgicInt {
    inner: Arc<Mutex<VgicIntInner>>,
    pub lock: Arc<Mutex<()>>,
}

impl VgicInt {
    fn update(&self) -> Self {
        let new_this = Self::new(self.id() as usize);
        match self.owner() {
            Some(vcpu) => {
                let vm = vcpu.vm().unwrap();
                new_this.set_owner(vm.vcpu(vcpu.id()).unwrap());
            }
            None => {}
        };
        let mut inner = new_this.inner.lock();
        inner.id = self.id();
        inner.hw = self.hw();
        inner.in_lr = self.in_lr();
        inner.lr = self.lr();
        inner.enabled = self.enabled();
        inner.state = self.state();
        inner.prio = self.prio();
        inner.targets = self.targets();
        inner.cfg = self.cfg();
        inner.in_pend = self.in_pend();
        inner.in_act = self.in_act();
        drop(inner);
        new_this
    }

    fn new(id: usize) -> VgicInt {
        VgicInt {
            inner: Arc::new(Mutex::new(VgicIntInner::new(id))),
            lock: Arc::new(Mutex::new(())),
        }
    }

    pub fn restore_migrate_data(
        &self,
        int_data: &VgicIntData,
        vcpu_list: &Vec<Vcpu>,
        vcpuid_map: &BTreeMap<usize, usize>,
    ) {
        let mut inner = self.inner.lock();
        inner.owner = match int_data.owner {
            None => None,
            Some(id) => Some(vcpu_list[id].clone()),
        };
        inner.id = int_data.id;
        inner.hw = int_data.hw;
        inner.in_lr = int_data.in_lr;
        inner.enabled = int_data.enabled;
        inner.state = int_data.state;
        inner.prio = int_data.prio;
        inner.targets = {
            let mut pcpu_targets = 0;
            // println!(
            //     "restore vgic int {} migrate target data {:x}",
            //     int_data.id, int_data.targets
            // );
            for vcpuid in 0..PLATFORM_CPU_NUM_MAX {
                if (1 << vcpuid) & int_data.targets != 0 {
                    pcpu_targets |= (1 << vcpuid_map[&vcpuid]) as u8;
                }
            }
            pcpu_targets
        };
        inner.cfg = int_data.cfg;
        inner.in_pend = int_data.in_pend;
        inner.in_act = int_data.in_act;

        // TODO: rude
        // if inner.enabled {
        //     let int_id = inner.id as usize;
        //     GICD.set_enable(int_id, true);
        //     GICD.set_prio(int_id, inner.prio);
        //     GICD.set_trgt(int_id, 1 << platform_cpuid_to_cpuif(current_cpu().id));
        // GICD.set_icfgr(int_id, inner.cfg);
        // println!(
        //     "cpuid {} cpuif {:x}",
        //     current_cpu().id,
        //     platform_cpuid_to_cpuif(current_cpu().id)
        // );

        // if int_id > 16 {
        //     println!(
        //         "restore_migrate_data after: int {} ISENABLER {:x}, ISACTIVER {:x}, IPRIORITY {:x}, ITARGETSR {:x}, ICFGR {:x}",
        //         int_id,
        //         GICD.is_enabler(int_id / 32),
        //         GICD.is_activer(int_id / 32),
        //         GICD.ipriorityr(int_id / 4),
        //         GICD.itargetsr(int_id / 4),
        //         GICD.icfgr(int_id / 2)
        //     );
        // }
        // }
    }

    pub fn save_migrate_data(&self, int_data: &mut VgicIntData, cpuid_map: &BTreeMap<usize, usize>) {
        let inner = self.inner.lock();
        int_data.owner = match &inner.owner {
            None => None,
            Some(vcpu) => Some(vcpu.id()),
        };
        int_data.id = inner.id;
        int_data.hw = inner.hw;
        int_data.in_lr = inner.in_lr;
        int_data.lr = inner.lr;
        int_data.enabled = inner.enabled;
        int_data.state = inner.state;
        int_data.prio = inner.prio;
        int_data.targets = {
            let mut vcpu_targets = 0;
            for pcpuid in 0..PLATFORM_CPU_NUM_MAX {
                if (1 << pcpuid) & inner.targets != 0 {
                    vcpu_targets |= (1 << cpuid_map[&pcpuid]) as u8;
                }
            }
            vcpu_targets
        };
        int_data.cfg = inner.cfg;
        int_data.in_pend = inner.in_pend;
        int_data.in_act = inner.in_act;
        // if inner.enabled {
        // println!(
        //     "int {} is enable, state {:#?}, prio {:x}, targets {:x}, in pend {}, int act {}, int cfg {}",
        //     inner.id, inner.state, inner.prio, inner.targets, inner.in_pend, inner.in_act, inner.cfg
        // );

        // let int_id = inner.id as usize;
        // if int_id > 16 {
        //     println!(
        //         "int {} ISENABLER {:x}, ISACTIVER {:x}, IPRIORITY {:x}, ITARGETSR {:x}, ICFGR {:x}",
        //         int_id,
        //         GICD.is_enabler(int_id / 32),
        //         GICD.is_activer(int_id / 32),
        //         GICD.ipriorityr(int_id / 4),
        //         GICD.itargetsr(int_id / 4),
        //         GICD.icfgr(int_id / 2)
        //     );
        // }
        // }
    }

    // back up for hyper fresh
    pub fn fresh_back_up(&self) -> VgicInt {
        let inner = self.inner.lock();
        let owner = {
            match &inner.owner {
                None => None,
                Some(vcpu) => {
                    let vm_id = vcpu.vm_id();
                    let vm = vm(vm_id).unwrap();
                    vm.vcpu(vcpu.id())
                }
            }
        };
        VgicInt {
            inner: Arc::new(Mutex::new(VgicIntInner {
                owner,
                id: inner.id,
                hw: inner.hw,
                in_lr: inner.in_lr,
                lr: inner.lr,
                enabled: inner.enabled,
                state: inner.state,
                prio: inner.prio,
                targets: inner.targets,
                cfg: inner.cfg,
                in_pend: inner.in_pend,
                in_act: inner.in_act,
            })),
            lock: Arc::new(Mutex::new(())),
        }
    }

    fn priv_new(id: usize, owner: Vcpu, targets: usize, enabled: bool) -> VgicInt {
        VgicInt {
            inner: Arc::new(Mutex::new(VgicIntInner::priv_new(id, owner, targets, enabled))),
            lock: Arc::new(Mutex::new(())),
        }
    }

    fn set_in_pend_state(&self, is_pend: bool) {
        let mut vgic_int = self.inner.lock();
        vgic_int.in_pend = is_pend;
    }

    fn set_in_act_state(&self, is_act: bool) {
        let mut vgic_int = self.inner.lock();
        vgic_int.in_act = is_act;
    }

    pub fn in_pend(&self) -> bool {
        let vgic_int = self.inner.lock();
        vgic_int.in_pend
    }

    pub fn in_act(&self) -> bool {
        let vgic_int = self.inner.lock();
        vgic_int.in_act
    }

    fn set_enabled(&self, enabled: bool) {
        let mut vgic_int = self.inner.lock();
        vgic_int.enabled = enabled;
    }

    fn set_lr(&self, lr: u16) {
        let mut vgic_int = self.inner.lock();
        vgic_int.lr = lr;
    }

    fn set_targets(&self, targets: u8) {
        let mut vgic_int = self.inner.lock();
        // if vgic_int.targets == 1 && vgic_int.id == 48 {
        //     panic!("set targets to {}", targets);
        // }
        vgic_int.targets = targets;
    }

    fn set_prio(&self, prio: u8) {
        let mut vgic_int = self.inner.lock();
        vgic_int.prio = prio;
    }

    fn set_in_lr(&self, in_lr: bool) {
        let mut vgic_int = self.inner.lock();
        vgic_int.in_lr = in_lr;
    }

    fn set_state(&self, state: IrqState) {
        let mut vgic_int = self.inner.lock();
        vgic_int.state = state;
    }

    fn set_owner(&self, owner: Vcpu) {
        let mut vgic_int = self.inner.lock();
        vgic_int.owner = Some(owner);
    }

    fn clear_owner(&self) {
        let mut vgic_int = self.inner.lock();
        // println!("clear owner get lock");
        vgic_int.owner = None;
    }

    fn set_hw(&self, hw: bool) {
        let mut vgic_int = self.inner.lock();
        vgic_int.hw = hw;
    }

    fn set_cfg(&self, cfg: u8) {
        let mut vgic_int = self.inner.lock();
        vgic_int.cfg = cfg;
    }

    fn lr(&self) -> u16 {
        let vgic_int = self.inner.lock();
        vgic_int.lr
    }

    fn in_lr(&self) -> bool {
        let vgic_int = self.inner.lock();
        vgic_int.in_lr
    }

    fn id(&self) -> u16 {
        let vgic_int = self.inner.lock();
        vgic_int.id
    }

    fn enabled(&self) -> bool {
        let vgic_int = self.inner.lock();
        vgic_int.enabled
    }

    fn prio(&self) -> u8 {
        let vgic_int = self.inner.lock();
        vgic_int.prio
    }

    fn targets(&self) -> u8 {
        let vgic_int = self.inner.lock();
        vgic_int.targets
    }

    fn hw(&self) -> bool {
        let vgic_int = self.inner.lock();
        vgic_int.hw
    }

    pub fn state(&self) -> IrqState {
        let vgic_int = self.inner.lock();
        vgic_int.state
    }

    fn cfg(&self) -> u8 {
        let vgic_int = self.inner.lock();
        vgic_int.cfg
    }

    fn owner(&self) -> Option<Vcpu> {
        let vgic_int = self.inner.lock();
        match &vgic_int.owner {
            Some(vcpu) => {
                return Some(vcpu.clone());
            }
            None => {
                // println!("vgic_int {} owner vcpu is none", vgic_int.id);
                return None;
            }
        }
    }

    fn owner_phys_id(&self) -> Option<usize> {
        let vgic_int = self.inner.lock();
        match &vgic_int.owner {
            Some(owner) => {
                return Some(owner.phys_id());
            }
            None => {
                return None;
            }
        }
    }

    fn owner_id(&self) -> Option<usize> {
        let vgic_int = self.inner.lock();
        match &vgic_int.owner {
            Some(owner) => {
                return Some(owner.id());
            }
            None => {
                println!("owner_id is None");
                return None;
            }
        }
    }

    fn owner_vm_id(&self) -> Option<usize> {
        let vgic_int = self.inner.lock();
        match &vgic_int.owner {
            Some(owner) => {
                return Some(owner.vm_id());
            }
            None => {
                return None;
            }
        }
    }

    fn owner_vm(&self) -> Vm {
        let vgic_int = self.inner.lock();
        vgic_int.owner_vm()
    }
}

struct VgicIntInner {
    owner: Option<Vcpu>,
    id: u16,
    hw: bool,
    in_lr: bool,
    lr: u16,
    enabled: bool,
    state: IrqState,
    prio: u8,
    targets: u8,
    cfg: u8,

    in_pend: bool,
    in_act: bool,
}

impl VgicIntInner {
    fn new(id: usize) -> VgicIntInner {
        VgicIntInner {
            owner: None,
            id: (id + GIC_PRIVINT_NUM) as u16,
            hw: false,
            in_lr: false,
            lr: 0,
            enabled: false,
            state: IrqState::IrqSInactive,
            prio: 0xff,
            targets: 0,
            cfg: 0,
            in_pend: false,
            in_act: false,
        }
    }

    fn priv_new(id: usize, owner: Vcpu, targets: usize, enabled: bool) -> VgicIntInner {
        VgicIntInner {
            owner: Some(owner),
            id: id as u16,
            hw: false,
            in_lr: false,
            lr: 0,
            enabled,
            state: IrqState::IrqSInactive,
            prio: 0xff,
            targets: targets as u8,
            cfg: 0,
            in_pend: false,
            in_act: false,
        }
    }

    fn owner_vm(&self) -> Vm {
        let owner = self.owner.as_ref().unwrap();
        owner.vm().unwrap()
    }
}

struct Vgicd {
    ctlr: u32,
    typer: u32,
    iidr: u32,
    interrupts: Vec<VgicInt>,
}

impl Vgicd {
    fn default() -> Vgicd {
        Vgicd {
            ctlr: 0,
            typer: 0,
            iidr: 0,
            interrupts: Vec::new(),
        }
    }
}

#[derive(Clone, Copy)]
pub struct Sgis {
    pub pend: u8,
    pub act: u8,
}

impl Sgis {
    fn default() -> Sgis {
        Sgis { pend: 0, act: 0 }
    }
}

struct VgicCpuPriv {
    // gich: GicHypervisorInterfaceBlock,
    curr_lrs: [u16; GIC_LIST_REGS_NUM],
    sgis: [Sgis; GIC_SGIS_NUM],
    interrupts: Vec<VgicInt>,

    pend_list: VecDeque<VgicInt>,
    act_list: VecDeque<VgicInt>,
}

impl VgicCpuPriv {
    fn default() -> VgicCpuPriv {
        VgicCpuPriv {
            curr_lrs: [0; GIC_LIST_REGS_NUM],
            sgis: [Sgis::default(); GIC_SGIS_NUM],
            interrupts: Vec::new(),
            pend_list: VecDeque::new(),
            act_list: VecDeque::new(),
        }
    }

    // use for migration
    pub fn restore_migrate_data(
        &mut self,
        cpu_priv_data: &VgicCpuPrivData,
        vcpu_list: &Vec<Vcpu>,
        vcpuid_map: &BTreeMap<usize, usize>,
    ) {
        self.sgis = cpu_priv_data.sgis;
        self.curr_lrs = cpu_priv_data.curr_lrs;
        for (idx, int) in self.interrupts.iter_mut().enumerate() {
            int.restore_migrate_data(&cpu_priv_data.interrupts[idx], vcpu_list, vcpuid_map);
        }
        assert_eq!(self.interrupts.len(), cpu_priv_data.interrupts.len());
    }

    // use for migration
    pub fn save_migrate_data(&self, cpu_priv_data: &mut VgicCpuPrivData, cpuid_map: &BTreeMap<usize, usize>) {
        cpu_priv_data.sgis = self.sgis;
        cpu_priv_data.curr_lrs = self.curr_lrs;
        for (idx, int) in self.interrupts.iter().enumerate() {
            int.save_migrate_data(&mut cpu_priv_data.interrupts[idx], cpuid_map);
        }
        cpu_priv_data.act_num = self.act_list.len();
        for (idx, int) in self.act_list.iter().enumerate() {
            cpu_priv_data.act_list[idx] = int.id() as usize;
        }
        cpu_priv_data.act_num = self.pend_list.len();
        for (idx, int) in self.pend_list.iter().enumerate() {
            cpu_priv_data.pend_list[idx] = int.id() as usize;
        }
    }
}

pub struct Vgic {
    vgicd: Mutex<Vgicd>,
    cpu_priv: Mutex<Vec<VgicCpuPriv>>,
}

impl Vgic {
    pub fn default() -> Vgic {
        Vgic {
            vgicd: Mutex::new(Vgicd::default()),
            cpu_priv: Mutex::new(Vec::new()),
        }
    }

    pub fn restore_vgic_data(
        &self,
        vgic_data: &VgicMigData,
        vcpu_list: &Vec<Vcpu>,
        vcpuid_map: &BTreeMap<usize, usize>,
    ) {
        let mut vgicd = self.vgicd.lock();
        vgicd.ctlr = vgic_data.vgicd.ctlr;
        vgicd.typer = vgic_data.vgicd.typer;
        vgicd.iidr = vgic_data.vgicd.iidr;
        for (idx, int) in vgicd.interrupts.iter().enumerate() {
            int.restore_migrate_data(&vgic_data.vgicd.interrupts[idx], vcpu_list, vcpuid_map);
        }
        let mut cpu_priv_list = self.cpu_priv.lock();
        for idx in 0..vgic_data.cpu_priv_num {
            cpu_priv_list[idx].restore_migrate_data(&vgic_data.cpu_priv[idx], vcpu_list, vcpuid_map);
            assert_eq!(cpu_priv_list[idx].act_list.len(), 0);
            assert_eq!(cpu_priv_list[idx].pend_list.len(), 0);
            // act list
            for act_idx in 0..vgic_data.cpu_priv[idx].act_num {
                let id = vgic_data.cpu_priv[idx].act_list[act_idx];
                let interrupt = if id >= GIC_SPI_MAX {
                    cpu_priv_list[idx].interrupts[id - GIC_SPI_MAX].clone()
                } else {
                    vgicd.interrupts[id].clone()
                };
                cpu_priv_list[idx].act_list.push_back(interrupt);
            }
            // pend list
            for pend_idx in 0..vgic_data.cpu_priv[idx].pend_num {
                let id = vgic_data.cpu_priv[idx].pend_list[pend_idx];
                let interrupt = if id >= GIC_SPI_MAX {
                    cpu_priv_list[idx].interrupts[id - GIC_SPI_MAX].clone()
                } else {
                    vgicd.interrupts[id].clone()
                };
                cpu_priv_list[idx].pend_list.push_back(interrupt);
            }
        }
    }

    pub fn save_vgic_data(&self, vgic_data: &mut VgicMigData, cpuid_map: &BTreeMap<usize, usize>) {
        let vgicd = self.vgicd.lock();
        vgic_data.vgicd.iidr = vgicd.iidr;
        vgic_data.vgicd.typer = vgicd.typer;
        vgic_data.vgicd.ctlr = vgicd.ctlr;
        for (idx, int) in vgicd.interrupts.iter().enumerate() {
            int.save_migrate_data(&mut vgic_data.vgicd.interrupts[idx], cpuid_map);
        }

        let cpu_priv_list = self.cpu_priv.lock();
        vgic_data.cpu_priv_num = cpu_priv_list.len();
        for (idx, cpu_priv) in cpu_priv_list.iter().enumerate() {
            cpu_priv.save_migrate_data(&mut vgic_data.cpu_priv[idx], cpuid_map);
        }
    }

    // reset vcpu in save vgic, use for hypervisor fresh
    pub fn save_vgic(&self, src_vgic: Arc<Vgic>) {
        // let time0 = time_current_us();
        let src_vgicd = src_vgic.vgicd.lock();
        let mut cur_vgicd = self.vgicd.lock();
        cur_vgicd.ctlr = src_vgicd.ctlr;
        cur_vgicd.iidr = src_vgicd.iidr;
        cur_vgicd.typer = src_vgicd.typer;
        for interrupt in src_vgicd.interrupts.iter() {
            cur_vgicd.interrupts.push(interrupt.update());
        }
        // cur_vgicd.interrupts.append(&mut src_vgicd.interrupts);
        println!(
            "src vgicd interrupts len {}, cur interrupts len {}",
            src_vgicd.interrupts.len(),
            cur_vgicd.interrupts.len()
        );
        // let time1 = time_current_us();
        // let mut num = 0;

        // cur_vgicd.interrupts.push(interrupt.fresh_back_up());
        // let time2 = time_current_us();

        let mut src_cpu_priv = src_vgic.cpu_priv.lock();
        let mut cur_cpu_priv = self.cpu_priv.lock();
        // let mut num1 = 0;
        for cpu_priv in src_cpu_priv.iter_mut() {
            let vgic_cpu_priv = VgicCpuPriv {
                curr_lrs: cpu_priv.curr_lrs,
                sgis: cpu_priv.sgis,
                interrupts: {
                    let mut interrupts = vec![];
                    // interrupts.append(&mut cpu_priv.interrupts);
                    for interrupt in cpu_priv.interrupts.iter_mut() {
                        interrupts.push(interrupt.clone());
                    }
                    for interrupt in cpu_priv.interrupts.iter_mut() {
                        match interrupt.owner() {
                            None => {}
                            Some(vcpu) => {
                                let vm_id = vcpu.vm_id();
                                let vm = vm(vm_id).unwrap();
                                let int_id = interrupt.id() as usize;
                                let phys_id = vcpu.phys_id();
                                interrupts.push(VgicInt::priv_new(
                                    int_id,
                                    vm.vcpu(vcpu.id()).unwrap(),
                                    1 << phys_id,
                                    int_id < GIC_SGIS_NUM,
                                ));
                                // num1 += 1;
                            }
                        }
                        // interrupts.push(interrupt.fresh_back_up());
                    }
                    println!(
                        "src vgicd cpu_priv interrupts len {}, cur interrupts cpu_priv len {}",
                        cpu_priv.interrupts.len(),
                        interrupts.len()
                    );
                    interrupts
                },
                pend_list: {
                    let mut pend_list = VecDeque::new();
                    for pend_int in cpu_priv.pend_list.iter() {
                        pend_list.push_back(pend_int.fresh_back_up());
                    }
                    pend_list
                },
                act_list: {
                    let mut act_list = VecDeque::new();
                    for act_int in cpu_priv.act_list.iter() {
                        act_list.push_back(act_int.fresh_back_up());
                    }
                    act_list
                },
            };
            cur_cpu_priv.push(vgic_cpu_priv);
        }
        // let time3 = time_current_us();
        // println!(
        //     "save vgic: vgicd len {} append {} us, EN_SET size {}, set owner {} {} us, cpu_priv {} change owner {} {} us",
        //     cur_vgicd.interrupts.len(),
        //     time1 - time0,
        //     INTERRUPT_EN_SET.lock().len(),
        //     num,
        //     time2 - time1,
        //     cur_cpu_priv.len(),
        //     num1,
        //     time3 - time2
        // );
    }

    fn remove_int_list(&self, vcpu: Vcpu, interrupt: VgicInt, is_pend: bool) {
        let mut cpu_priv = self.cpu_priv.lock();
        let vcpu_id = vcpu.id();
        let int_id = interrupt.id();
        if is_pend {
            if !interrupt.in_pend() {
                // println!("why int {} in pend is false but in pend list", int_id);
                return;
            }
            for i in 0..cpu_priv[vcpu_id].pend_list.len() {
                if cpu_priv[vcpu_id].pend_list[i].id() == int_id {
                    // if int_id == 297 {
                    //     println!("remove int {} in pend list[{}]", int_id, i);
                    // }
                    cpu_priv[vcpu_id].pend_list.remove(i);
                    break;
                }
            }
            interrupt.set_in_pend_state(false);
        } else {
            if !interrupt.in_act() {
                return;
            }
            for i in 0..cpu_priv[vcpu_id].act_list.len() {
                if cpu_priv[vcpu_id].act_list[i].id() == int_id {
                    cpu_priv[vcpu_id].act_list.remove(i);
                    break;
                }
            }
            interrupt.set_in_act_state(false);
        };
    }

    fn add_int_list(&self, vcpu: Vcpu, interrupt: VgicInt, is_pend: bool) {
        let mut cpu_priv = self.cpu_priv.lock();
        let vcpu_id = vcpu.id();
        if is_pend {
            interrupt.set_in_pend_state(true);
            cpu_priv[vcpu_id].pend_list.push_back(interrupt);
        } else {
            interrupt.set_in_act_state(true);
            cpu_priv[vcpu_id].act_list.push_back(interrupt);
        }
    }

    fn update_int_list(&self, vcpu: Vcpu, interrupt: VgicInt) {
        let state = interrupt.state().to_num();

        if state & 1 != 0 && !interrupt.in_pend() {
            self.add_int_list(vcpu.clone(), interrupt.clone(), true);
        } else if state & 1 == 0 {
            self.remove_int_list(vcpu.clone(), interrupt.clone(), true);
        }

        if state & 2 != 0 && !interrupt.in_act() {
            self.add_int_list(vcpu.clone(), interrupt.clone(), false);
        } else if state & 2 == 0 {
            self.remove_int_list(vcpu.clone(), interrupt.clone(), false);
        }

        if interrupt.id() < GIC_SGIS_NUM as u16 {
            if self.cpu_priv_sgis_pend(vcpu.id(), interrupt.id() as usize) != 0 && !interrupt.in_pend() {
                self.add_int_list(vcpu, interrupt, true);
            }
        }
    }

    fn int_list_head(&self, vcpu: Vcpu, is_pend: bool) -> Option<VgicInt> {
        let cpu_priv = self.cpu_priv.lock();
        let vcpu_id = vcpu.id();
        if is_pend {
            if cpu_priv[vcpu_id].pend_list.is_empty() {
                None
            } else {
                Some(cpu_priv[vcpu_id].pend_list[0].clone())
            }
        } else {
            if cpu_priv[vcpu_id].act_list.is_empty() {
                None
            } else {
                Some(cpu_priv[vcpu_id].act_list[0].clone())
            }
        }
    }

    fn set_vgicd_ctlr(&self, ctlr: u32) {
        let mut vgicd = self.vgicd.lock();
        vgicd.ctlr = ctlr;
    }

    pub fn vgicd_ctlr(&self) -> u32 {
        let vgicd = self.vgicd.lock();
        vgicd.ctlr
    }

    pub fn vgicd_typer(&self) -> u32 {
        let vgicd = self.vgicd.lock();
        vgicd.typer
    }

    pub fn vgicd_iidr(&self) -> u32 {
        let vgicd = self.vgicd.lock();
        vgicd.iidr
    }

    fn cpu_priv_interrupt(&self, cpu_id: usize, idx: usize) -> VgicInt {
        let cpu_priv = self.cpu_priv.lock();
        cpu_priv[cpu_id].interrupts[idx].clone()
    }

    fn cpu_priv_curr_lrs(&self, cpu_id: usize, idx: usize) -> u16 {
        let cpu_priv = self.cpu_priv.lock();
        cpu_priv[cpu_id].curr_lrs[idx]
    }

    fn cpu_priv_sgis_pend(&self, cpu_id: usize, idx: usize) -> u8 {
        let cpu_priv = self.cpu_priv.lock();
        cpu_priv[cpu_id].sgis[idx].pend
    }

    fn cpu_priv_sgis_act(&self, cpu_id: usize, idx: usize) -> u8 {
        let cpu_priv = self.cpu_priv.lock();
        cpu_priv[cpu_id].sgis[idx].act
    }

    fn set_cpu_priv_curr_lrs(&self, cpu_id: usize, idx: usize, val: u16) {
        let mut cpu_priv = self.cpu_priv.lock();
        cpu_priv[cpu_id].curr_lrs[idx] = val;
    }

    fn set_cpu_priv_sgis_pend(&self, cpu_id: usize, idx: usize, pend: u8) {
        let mut cpu_priv = self.cpu_priv.lock();
        cpu_priv[cpu_id].sgis[idx].pend = pend;
    }

    fn set_cpu_priv_sgis_act(&self, cpu_id: usize, idx: usize, act: u8) {
        let mut cpu_priv = self.cpu_priv.lock();
        cpu_priv[cpu_id].sgis[idx].act = act;
    }

    fn vgicd_interrupt(&self, idx: usize) -> VgicInt {
        let vgicd = self.vgicd.lock();
        vgicd.interrupts[idx].clone()
    }

    fn get_int(&self, vcpu: Vcpu, int_id: usize) -> Option<VgicInt> {
        if int_id < GIC_PRIVINT_NUM {
            let vcpu_id = vcpu.id();
            return Some(self.cpu_priv_interrupt(vcpu_id, int_id));
        } else if int_id >= GIC_PRIVINT_NUM && int_id < GIC_INTS_MAX {
            return Some(self.vgicd_interrupt(int_id - GIC_PRIVINT_NUM));
        }
        return None;
    }

    fn remove_lr(&self, vcpu: Vcpu, interrupt: VgicInt) -> bool {
        if !vgic_owns(vcpu.clone(), interrupt.clone()) {
            return false;
        }
        let int_lr = interrupt.lr();
        let int_id = interrupt.id() as usize;
        let vcpu_id = vcpu.id();

        if !interrupt.in_lr() {
            return false;
        }

        let mut lr_val = 0;
        if let Some(lr) = gich_get_lr(interrupt.clone()) {
            GICH.set_lr(int_lr as usize, 0);
            lr_val = lr;
        }

        interrupt.set_in_lr(false);

        let lr_state = (lr_val >> 28) & 0b11;
        if lr_state != 0 {
            interrupt.set_state(IrqState::num_to_state(lr_state as usize));
            if int_id < GIC_SGIS_NUM {
                if interrupt.state().to_num() & 2 != 0 {
                    self.set_cpu_priv_sgis_act(vcpu_id, int_id, ((lr_val >> 10) & 0b111) as u8);
                } else if interrupt.state().to_num() & 1 != 0 {
                    let pend = self.cpu_priv_sgis_pend(vcpu_id, int_id);
                    self.set_cpu_priv_sgis_pend(vcpu_id, int_id, pend | (1 << ((lr_val >> 10) & 0b111) as u8));
                }
            }

            self.update_int_list(vcpu, interrupt.clone());

            if (interrupt.state().to_num() & 1 != 0) && interrupt.enabled() {
                // println!("remove_lr: interrupt_state {}", interrupt.state().to_num());
                let hcr = GICH.hcr();
                GICH.set_hcr(hcr | (1 << 3));
            }
            return true;
        }
        false
    }

    fn add_lr(&self, vcpu: Vcpu, interrupt: VgicInt) -> bool {
        if !interrupt.enabled() || interrupt.in_lr() {
            return false;
        }

        let gic_lrs = gic_lrs();
        let mut lr_ind = None;

        for i in 0..gic_lrs {
            if (GICH.elrsr(i / 32) & (1 << (i % 32))) != 0 {
                lr_ind = Some(i);
                break;
            }
        }

        if lr_ind.is_none() {
            let mut pend_found = 0;
            let mut act_found = 0;
            let mut min_prio_act = 0;
            let mut min_prio_pend = 0;
            let mut act_ind = None;
            let mut pend_ind = None;

            for i in 0..gic_lrs {
                let lr = GICH.lr(i);
                let lr_prio = (lr >> 23) & 0b11111;
                let lr_state = (lr >> 28) & 0b11;

                if lr_state & 2 != 0 {
                    if lr_prio > min_prio_act {
                        min_prio_act = lr_prio;
                        act_ind = Some(i);
                    }
                    act_found += 1;
                } else if lr_state & 1 != 0 {
                    if lr_prio > min_prio_pend {
                        min_prio_pend = lr_prio;
                        pend_ind = Some(i);
                    }
                    pend_found += 1;
                }
            }

            if pend_found > 1 {
                lr_ind = pend_ind;
            } else if act_found > 1 {
                lr_ind = act_ind;
            }

            if let Some(idx) = lr_ind {
                let spilled_int = self
                    .get_int(vcpu.clone(), GICH.lr(idx) as usize & 0b1111111111)
                    .unwrap();
                let spilled_int_lock;
                if spilled_int.id() != interrupt.id() {
                    spilled_int_lock = spilled_int.lock.lock();
                }
                self.remove_lr(vcpu.clone(), spilled_int.clone());
                vgic_int_yield_owner(vcpu.clone(), spilled_int.clone());
                // if spilled_int.id() != interrupt.id() {
                //     drop(spilled_int_lock);
                // }
            }
        }

        match lr_ind {
            Some(idx) => {
                self.write_lr(vcpu, interrupt, idx);
                return true;
            }
            None => {
                // turn on maintenance interrupts
                if vgic_get_state(interrupt) & 1 != 0 {
                    let hcr = GICH.hcr();
                    GICH.set_hcr(hcr | (1 << 3));
                }
            }
        }

        false
    }

    fn write_lr(&self, vcpu: Vcpu, interrupt: VgicInt, lr_ind: usize) {
        let vcpu_id = vcpu.id();
        let int_id = interrupt.id() as usize;
        let int_prio = interrupt.prio();

        let prev_int_id = self.cpu_priv_curr_lrs(vcpu_id, lr_ind) as usize;
        if prev_int_id != int_id {
            let prev_interrupt_option = self.get_int(vcpu.clone(), prev_int_id);
            if let Some(prev_interrupt) = prev_interrupt_option {
                let prev_interrupt_lock = prev_interrupt.lock.lock();
                // println!(
                //     "write_lr: Core {} get int {} lock",
                //     current_cpu().id,
                //     prev_interrupt.id()
                // );
                if vgic_owns(vcpu.clone(), prev_interrupt.clone()) {
                    if prev_interrupt.in_lr() && prev_interrupt.lr() == lr_ind as u16 {
                        prev_interrupt.set_in_lr(false);
                        let prev_id = prev_interrupt.id() as usize;
                        if !gic_is_priv(prev_id) {
                            vgic_int_yield_owner(vcpu.clone(), prev_interrupt.clone());
                        }
                    }
                }
                drop(prev_interrupt_lock);
            }
        }

        let state = vgic_get_state(interrupt.clone());
        let mut lr = (int_id & 0b1111111111) | (((int_prio as usize >> 3) & 0b11111) << 23);

        if vgic_int_is_hw(interrupt.clone()) {
            lr |= 1 << 31;
            lr |= (0b1111111111 & int_id) << 10;
            if state == 3 {
                lr |= (2 & 0b11) << 28;
            } else {
                lr |= (state & 0b11) << 28;
            }
            if GICD.state(int_id) != 2 {
                GICD.set_state(int_id, 2);
            }
        } else if int_id < GIC_SGIS_NUM {
            if (state & 2) != 0 {
                lr |= ((self.cpu_priv_sgis_act(vcpu_id, int_id) as usize) << 10) & (0b111 << 10);
                // lr |= ((cpu_priv[vcpu_id].sgis[int_id].act as usize) << 10) & (0b111 << 10);
                lr |= (2 & 0b11) << 28;
            } else {
                let mut idx = GIC_TARGETS_MAX - 1;
                while idx as isize >= 0 {
                    if (self.cpu_priv_sgis_pend(vcpu_id, int_id) & (1 << idx)) != 0 {
                        lr |= (idx & 0b111) << 10;
                        let pend = self.cpu_priv_sgis_pend(vcpu_id, int_id);
                        self.set_cpu_priv_sgis_pend(vcpu_id, int_id, pend & !(1 << idx));

                        lr |= (1 & 0b11) << 28;
                        break;
                    }
                    idx -= 1;
                }
            }

            if self.cpu_priv_sgis_pend(vcpu_id, int_id) != 0 {
                lr |= 1 << 19;
            }
        } else {
            if !gic_is_priv(int_id) && !vgic_int_is_hw(interrupt.clone()) {
                lr |= 1 << 19;
            }

            lr |= (state & 0b11) << 28;
        }

        interrupt.set_state(IrqState::IrqSInactive);
        interrupt.set_in_lr(true);
        interrupt.set_lr(lr_ind as u16);
        self.set_cpu_priv_curr_lrs(vcpu_id, lr_ind, int_id as u16);

        // if current_cpu().id == 1 {
        //     println!("Core1 write lr[{}] 0x{:x}", lr_ind, lr);
        // }
        GICH.set_lr(lr_ind, lr as u32);

        self.update_int_list(vcpu, interrupt);
    }

    fn route(&self, vcpu: Vcpu, interrupt: VgicInt) {
        let cpu_id = current_cpu().id;
        if let IrqState::IrqSInactive = interrupt.state() {
            return;
        }

        if !interrupt.enabled() {
            return;
        }

        let int_targets = interrupt.targets();
        if (int_targets & (1 << cpu_id)) != 0 {
            // println!("vm{} route addr lr for int {}", vcpu.vm_id(), interrupt.id());
            self.add_lr(vcpu.clone(), interrupt.clone());
        }

        if !interrupt.in_lr() && (int_targets & !(1 << cpu_id)) != 0 {
            let vcpu_vm_id = vcpu.vm_id();

            let ipi_msg = IpiInitcMessage {
                event: InitcEvent::VgicdRoute,
                vm_id: vcpu_vm_id,
                int_id: interrupt.id(),
                val: 0,
            };
            vgic_int_yield_owner(vcpu, interrupt);
            ipi_intra_broadcast_msg(active_vm().unwrap(), IpiType::IpiTIntc, IpiInnerMsg::Initc(ipi_msg));
        }
    }

    fn set_enable(&self, vcpu: Vcpu, int_id: usize, en: bool) {
        if int_id < GIC_SGIS_NUM {
            return;
        }
        match self.get_int(vcpu.clone(), int_id) {
            Some(interrupt) => {
                let interrupt_lock = interrupt.lock.lock();
                if vgic_int_get_owner(vcpu.clone(), interrupt.clone()) {
                    if interrupt.enabled() ^ en {
                        interrupt.set_enabled(en);
                        if !interrupt.enabled() {
                            self.remove_lr(vcpu.clone(), interrupt.clone());
                        } else {
                            self.route(vcpu.clone(), interrupt.clone());
                        }
                        if interrupt.hw() {
                            GICD.set_enable(interrupt.id() as usize, en);
                        }
                    }
                    vgic_int_yield_owner(vcpu, interrupt.clone());
                } else {
                    let int_phys_id = interrupt.owner_phys_id().unwrap();
                    let vcpu_vm_id = vcpu.vm_id();
                    let ipi_msg = IpiInitcMessage {
                        event: InitcEvent::VgicdSetEn,
                        vm_id: vcpu_vm_id,
                        int_id: interrupt.id(),
                        val: en as u8,
                    };
                    if !ipi_send_msg(int_phys_id, IpiType::IpiTIntc, IpiInnerMsg::Initc(ipi_msg)) {
                        println!(
                            "vgicd_set_enable: Failed to send ipi message, target {} type {}",
                            int_phys_id, 0
                        );
                    }
                }
                drop(interrupt_lock);
            }
            None => {
                println!("vgicd_set_enable: interrupt {} is illegal", int_id);
                return;
            }
        }
    }

    fn get_enable(&self, vcpu: Vcpu, int_id: usize) -> bool {
        self.get_int(vcpu, int_id).unwrap().enabled()
    }

    fn set_pend(&self, vcpu: Vcpu, int_id: usize, pend: bool) {
        // TODO: sgi_get_pend ?
        if bit_extract(int_id, 0, 10) < GIC_SGIS_NUM {
            self.sgi_set_pend(vcpu, int_id, pend);
            return;
        }

        let interrupt_option = self.get_int(vcpu.clone(), bit_extract(int_id, 0, 10));

        if let Some(interrupt) = interrupt_option {
            let interrupt_lock = interrupt.lock.lock();
            if vgic_int_get_owner(vcpu.clone(), interrupt.clone()) {
                self.remove_lr(vcpu.clone(), interrupt.clone());

                let state = interrupt.state().to_num();
                if pend && ((state & 1) == 0) {
                    interrupt.set_state(IrqState::num_to_state(state | 1));
                } else if !pend && (state & 1) != 0 {
                    interrupt.set_state(IrqState::num_to_state(state & !1));
                }
                self.update_int_list(vcpu.clone(), interrupt.clone());

                let state = interrupt.state().to_num();
                if interrupt.hw() {
                    let vgic_int_id = interrupt.id() as usize;
                    GICD.set_state(vgic_int_id, if state == 1 { 2 } else { state })
                }
                self.route(vcpu.clone(), interrupt.clone());
                vgic_int_yield_owner(vcpu, interrupt.clone());
                drop(interrupt_lock);
            } else {
                let vm_id = vcpu.vm_id();

                let m = IpiInitcMessage {
                    event: InitcEvent::VgicdSetPend,
                    vm_id,
                    int_id: interrupt.id(),
                    val: pend as u8,
                };
                match interrupt.owner() {
                    Some(owner) => {
                        let phys_id = owner.phys_id();

                        drop(interrupt_lock);
                        if !ipi_send_msg(phys_id, IpiType::IpiTIntc, IpiInnerMsg::Initc(m)) {
                            println!(
                                "vgicd_set_pend: Failed to send ipi message, target {} type {}",
                                phys_id, 0
                            );
                        }
                    }
                    None => {
                        panic!(
                            "set_pend: Core {} int {} has no owner",
                            current_cpu().id,
                            interrupt.id()
                        );
                    }
                }
            }
        }
    }

    fn set_active(&self, vcpu: Vcpu, int_id: usize, act: bool) {
        let interrupt_option = self.get_int(vcpu.clone(), bit_extract(int_id, 0, 10));
        if let Some(interrupt) = interrupt_option {
            let interrupt_lock = interrupt.lock.lock();
            if vgic_int_get_owner(vcpu.clone(), interrupt.clone()) {
                self.remove_lr(vcpu.clone(), interrupt.clone());
                let state = interrupt.state().to_num();
                if act && ((state & 2) == 0) {
                    interrupt.set_state(IrqState::num_to_state(state | 2));
                } else if !act && (state & 2) != 0 {
                    interrupt.set_state(IrqState::num_to_state(state & !2));
                }
                self.update_int_list(vcpu.clone(), interrupt.clone());

                let state = interrupt.state().to_num();
                if interrupt.hw() {
                    let vgic_int_id = interrupt.id() as usize;
                    GICD.set_state(vgic_int_id, if state == 1 { 2 } else { state })
                }
                self.route(vcpu.clone(), interrupt.clone());
                vgic_int_yield_owner(vcpu, interrupt.clone());
            } else {
                let vm_id = vcpu.vm_id();

                let m = IpiInitcMessage {
                    event: InitcEvent::VgicdSetPend,
                    vm_id,
                    int_id: interrupt.id(),
                    val: act as u8,
                };
                let phys_id = interrupt.owner_phys_id().unwrap();
                if !ipi_send_msg(phys_id, IpiType::IpiTIntc, IpiInnerMsg::Initc(m)) {
                    println!(
                        "vgicd_set_active: Failed to send ipi message, target {} type {}",
                        phys_id, 0
                    );
                }
            }
            drop(interrupt_lock);
        }
    }

    fn set_icfgr(&self, vcpu: Vcpu, int_id: usize, cfg: u8) {
        let interrupt_option = self.get_int(vcpu.clone(), int_id);
        if let Some(interrupt) = interrupt_option {
            let interrupt_lock = interrupt.lock.lock();
            if vgic_int_get_owner(vcpu.clone(), interrupt.clone()) {
                interrupt.set_cfg(cfg);
                if interrupt.hw() {
                    GICD.set_icfgr(interrupt.id() as usize, cfg);
                }
                vgic_int_yield_owner(vcpu, interrupt.clone());
            } else {
                let m = IpiInitcMessage {
                    event: InitcEvent::VgicdSetCfg,
                    vm_id: vcpu.vm_id(),
                    int_id: interrupt.id(),
                    val: cfg,
                };
                if !ipi_send_msg(
                    interrupt.owner_phys_id().unwrap(),
                    IpiType::IpiTIntc,
                    IpiInnerMsg::Initc(m),
                ) {
                    println!(
                        "set_icfgr: Failed to send ipi message, target {} type {}",
                        interrupt.owner_phys_id().unwrap(),
                        0
                    );
                }
            }
            drop(interrupt_lock);
        } else {
            unimplemented!();
        }
    }

    fn get_icfgr(&self, vcpu: Vcpu, int_id: usize) -> u8 {
        let interrupt_option = self.get_int(vcpu, int_id);
        if let Some(interrupt) = interrupt_option {
            return interrupt.cfg();
        } else {
            unimplemented!();
        }
    }

    fn sgi_set_pend(&self, vcpu: Vcpu, int_id: usize, pend: bool) {
        // let begin = time_current_us();
        if bit_extract(int_id, 0, 10) > GIC_SGIS_NUM {
            return;
        }

        let interrupt_option = self.get_int(vcpu.clone(), bit_extract(int_id, 0, 10));
        let source = bit_extract(int_id, 10, 5);

        if let Some(interrupt) = interrupt_option {
            let interrupt_lock = interrupt.lock.lock();
            self.remove_lr(vcpu.clone(), interrupt.clone());
            let vcpu_id = vcpu.id();

            let vgic_int_id = interrupt.id() as usize;
            let pendstate = self.cpu_priv_sgis_pend(vcpu_id, vgic_int_id);
            // let pendstate = cpu_priv[vcpu_id].sgis[vgic_int_id].pend;
            let new_pendstate = if pend {
                pendstate | (1 << source) as u8
            } else {
                pendstate & !(1 << source) as u8
            };
            if (pendstate ^ new_pendstate) != 0 {
                // cpu_priv[vcpu_id].sgis[vgic_int_id].pend = new_pendstate;
                self.set_cpu_priv_sgis_pend(vcpu_id, vgic_int_id, new_pendstate);
                let state = interrupt.state().to_num();
                if new_pendstate != 0 {
                    interrupt.set_state(IrqState::num_to_state(state | 1));
                } else {
                    interrupt.set_state(IrqState::num_to_state(state & !1));
                }

                self.update_int_list(vcpu.clone(), interrupt.clone());

                // println!("state {}", interrupt.state().to_num());
                match interrupt.state() {
                    IrqState::IrqSInactive => {
                        println!("inactive");
                    }
                    _ => {
                        self.add_lr(vcpu, interrupt.clone());
                    }
                }
            }
            drop(interrupt_lock);
        } else {
            println!("sgi_set_pend: interrupt {} is None", bit_extract(int_id, 0, 10));
        }
        // let end = time_current_us();
        // println!("sgi_set_pend[{}]", end - begin);
    }

    fn set_prio(&self, vcpu: Vcpu, int_id: usize, mut prio: u8) {
        let interrupt_option = self.get_int(vcpu.clone(), int_id);
        prio &= 0xf0; // gic-400 only allows 4 priority bits in non-secure state

        if let Some(interrupt) = interrupt_option {
            let interrupt_lock = interrupt.lock.lock();
            if vgic_int_get_owner(vcpu.clone(), interrupt.clone()) {
                if interrupt.prio() != prio {
                    self.remove_lr(vcpu.clone(), interrupt.clone());
                    let prev_prio = interrupt.prio();
                    interrupt.set_prio(prio);
                    if prio <= prev_prio {
                        self.route(vcpu.clone(), interrupt.clone());
                    }
                    if interrupt.hw() {
                        GICD.set_prio(interrupt.id() as usize, prio);
                    }
                }
                vgic_int_yield_owner(vcpu, interrupt.clone());
            } else {
                let vm_id = vcpu.vm_id();

                let m = IpiInitcMessage {
                    event: InitcEvent::VgicdSetPrio,
                    vm_id,
                    int_id: interrupt.id(),
                    val: prio,
                };
                if !ipi_send_msg(
                    interrupt.owner_phys_id().unwrap(),
                    IpiType::IpiTIntc,
                    IpiInnerMsg::Initc(m),
                ) {
                    println!(
                        "set_prio: Failed to send ipi message, target {} type {}",
                        interrupt.owner_phys_id().unwrap(),
                        0
                    );
                }
            }
            drop(interrupt_lock);
        }
    }

    fn get_prio(&self, vcpu: Vcpu, int_id: usize) -> u8 {
        let interrupt_option = self.get_int(vcpu, int_id);
        return interrupt_option.unwrap().prio();
    }

    fn set_trgt(&self, vcpu: Vcpu, int_id: usize, trgt: u8) {
        let interrupt_option = self.get_int(vcpu.clone(), int_id);
        if let Some(interrupt) = interrupt_option {
            let interrupt_lock = interrupt.lock.lock();
            if vgic_int_get_owner(vcpu.clone(), interrupt.clone()) {
                if interrupt.targets() != trgt {
                    interrupt.set_targets(trgt);
                    let mut ptrgt = 0;
                    for cpuid in 0..8 {
                        if bit_get(trgt as usize, cpuid) != 0 {
                            ptrgt = bit_set(ptrgt, Platform::cpuid_to_cpuif(cpuid))
                        }
                    }
                    if interrupt.hw() {
                        GICD.set_trgt(interrupt.id() as usize, ptrgt as u8);
                    }
                    if vgic_get_state(interrupt.clone()) != 0 {
                        self.route(vcpu.clone(), interrupt.clone());
                    }
                }
                vgic_int_yield_owner(vcpu, interrupt.clone());
            } else {
                let vm_id = vcpu.vm_id();
                let m = IpiInitcMessage {
                    event: InitcEvent::VgicdSetTrgt,
                    vm_id,
                    int_id: interrupt.id(),
                    val: trgt,
                };
                if !ipi_send_msg(
                    interrupt.owner_phys_id().unwrap(),
                    IpiType::IpiTIntc,
                    IpiInnerMsg::Initc(m),
                ) {
                    println!(
                        "set_trgt: Failed to send ipi message, target {} type {}",
                        interrupt.owner_phys_id().unwrap(),
                        0
                    );
                }
            }
            drop(interrupt_lock);
        }
    }

    fn get_trgt(&self, vcpu: Vcpu, int_id: usize) -> u8 {
        let interrupt_option = self.get_int(vcpu, int_id);
        return interrupt_option.unwrap().targets();
    }

    pub fn inject(&self, vcpu: Vcpu, int_id: usize) {
        // println!("Core {} inject int {} to vm{}", current_cpu().id, int_id, vcpu.vm_id());
        let interrupt_option = self.get_int(vcpu.clone(), bit_extract(int_id, 0, 10));
        if let Some(interrupt) = interrupt_option {
            if interrupt.hw() {
                let interrupt_lock = interrupt.lock.lock();
                interrupt.set_owner(vcpu.clone());
                interrupt.set_state(IrqState::IrqSPend);
                self.update_int_list(vcpu.clone(), interrupt.clone());
                interrupt.set_in_lr(false);
                self.route(vcpu, interrupt.clone());
                drop(interrupt_lock);
            } else {
                self.set_pend(vcpu, int_id, true);
            }
        }
    }

    fn emu_ctrl_access(&self, emu_ctx: &EmuContext) {
        if emu_ctx.write {
            let prev_ctlr = self.vgicd_ctlr();
            let idx = emu_ctx.reg;
            self.set_vgicd_ctlr(current_cpu().get_gpr(idx) as u32 & 0x1);
            if prev_ctlr ^ self.vgicd_ctlr() != 0 {
                let enable = self.vgicd_ctlr() != 0;
                let hcr = GICH.hcr();
                if enable {
                    GICH.set_hcr(hcr | 1);
                } else {
                    GICH.set_hcr(hcr & !1);
                }

                let m = IpiInitcMessage {
                    event: InitcEvent::VgicdGichEn,
                    vm_id: active_vm_id(),
                    int_id: 0,
                    val: enable as u8,
                };
                ipi_intra_broadcast_msg(active_vm().unwrap(), IpiType::IpiTIntc, IpiInnerMsg::Initc(m));
            }
        } else {
            let idx = emu_ctx.reg;
            let val = self.vgicd_ctlr() as usize;
            current_cpu().set_gpr(idx, val);
        }
    }

    fn emu_typer_access(&self, emu_ctx: &EmuContext) {
        if !emu_ctx.write {
            let idx = emu_ctx.reg;
            let val = self.vgicd_typer() as usize;
            current_cpu().set_gpr(idx, val);
        } else {
            println!("emu_typer_access: can't write to RO reg");
        }
    }

    fn emu_iidr_access(&self, emu_ctx: &EmuContext) {
        if !emu_ctx.write {
            let idx = emu_ctx.reg;
            let val = self.vgicd_iidr() as usize;
            current_cpu().set_gpr(idx, val);
        } else {
            println!("emu_iidr_access: can't write to RO reg");
        }
    }

    fn emu_isenabler_access(&self, emu_ctx: &EmuContext) {
        // println!("DEBUG: in emu_isenabler_access");
        let reg_idx = (emu_ctx.address & 0b1111111) / 4;
        let idx = emu_ctx.reg;
        let mut val = if emu_ctx.write { current_cpu().get_gpr(idx) } else { 0 };
        let first_int = reg_idx * 32;
        let vm_id = active_vm_id();
        let vm = match active_vm() {
            Some(vm) => vm,
            None => {
                panic!("emu_isenabler_access: current vcpu.vm is none");
            }
        };
        let mut vm_has_interrupt_flag = false;

        for i in 0..32 {
            if vm.has_interrupt(first_int + i) || vm.emu_has_interrupt(first_int + i) {
                vm_has_interrupt_flag = true;
                break;
            }
        }
        if first_int >= 16 && !vm_has_interrupt_flag {
            println!(
                "emu_isenabler_access: vm[{}] does not have interrupt {}",
                vm_id, first_int
            );
            return;
        }

        if emu_ctx.write {
            for i in 0..32 {
                if bit_get(val, i) != 0 {
                    self.set_enable(current_cpu().active_vcpu.clone().unwrap(), first_int + i, true);
                }
            }
        } else {
            for i in 0..32 {
                if self.get_enable(current_cpu().active_vcpu.clone().unwrap(), first_int + i) {
                    val |= 1 << i;
                }
            }
            let idx = emu_ctx.reg;
            current_cpu().set_gpr(idx, val);
        }
    }

    fn emu_pendr_access(&self, emu_ctx: &EmuContext, set: bool) {
        println!("emu_pendr_access");
        let reg_idx = (emu_ctx.address & 0b1111111) / 4;
        let idx = emu_ctx.reg;
        let mut val = if emu_ctx.write { current_cpu().get_gpr(idx) } else { 0 };
        let first_int = reg_idx * 32;
        let vm_id = active_vm_id();
        let vm = match active_vm() {
            Some(vm) => vm,
            None => {
                panic!("emu_pendr_access: current vcpu.vm is none");
            }
        };
        let mut vm_has_interrupt_flag = false;

        for i in 0..emu_ctx.width {
            if vm.has_interrupt(first_int + i) || vm.emu_has_interrupt(first_int + i) {
                vm_has_interrupt_flag = true;
                break;
            }
        }
        if first_int >= 16 && !vm_has_interrupt_flag {
            println!("emu_pendr_access: vm[{}] does not have interrupt {}", vm_id, first_int);
            return;
        }

        if emu_ctx.write {
            for i in 0..32 {
                if bit_get(val, i) != 0 {
                    self.set_pend(current_cpu().active_vcpu.clone().unwrap(), first_int + i, set);
                }
            }
        } else {
            for i in 0..32 {
                match self.get_int(current_cpu().active_vcpu.clone().unwrap(), first_int + i) {
                    Some(interrupt) => {
                        if vgic_get_state(interrupt.clone()) & 1 != 0 {
                            val |= 1 << i;
                        }
                    }
                    None => {
                        unimplemented!();
                    }
                }
            }
            let idx = emu_ctx.reg;
            current_cpu().set_gpr(idx, val);
        }
    }

    fn emu_ispendr_access(&self, emu_ctx: &EmuContext) {
        self.emu_pendr_access(emu_ctx, true);
    }

    fn emu_activer_access(&self, emu_ctx: &EmuContext, set: bool) {
        // println!("DEBUG: in emu_activer_access");
        let reg_idx = (emu_ctx.address & 0b1111111) / 4;
        let idx = emu_ctx.reg;
        let mut val = if emu_ctx.write { current_cpu().get_gpr(idx) } else { 0 };
        let first_int = reg_idx * 32;
        let vm_id = active_vm_id();
        let vm = match active_vm() {
            Some(vm) => vm,
            None => {
                panic!("emu_activer_access: current vcpu.vm is none");
            }
        };
        let mut vm_has_interrupt_flag = false;

        for i in 0..32 {
            if vm.has_interrupt(first_int + i) || vm.emu_has_interrupt(first_int + i) {
                vm_has_interrupt_flag = true;
                break;
            }
        }
        if first_int >= 16 && !vm_has_interrupt_flag {
            warn!(
                "emu_activer_access: vm[{}] does not have interrupt {}",
                vm_id, first_int
            );
            return;
        }

        if emu_ctx.write {
            for i in 0..32 {
                if bit_get(val, i) != 0 {
                    self.set_active(current_cpu().active_vcpu.clone().unwrap(), first_int + i, set);
                }
            }
        } else {
            for i in 0..32 {
                match self.get_int(current_cpu().active_vcpu.clone().unwrap(), first_int + i) {
                    Some(interrupt) => {
                        if vgic_get_state(interrupt.clone()) & 2 != 0 {
                            val |= 1 << i;
                        }
                    }
                    None => {
                        unimplemented!();
                    }
                }
            }
            let idx = emu_ctx.reg;
            current_cpu().set_gpr(idx, val);
        }
    }

    fn emu_isactiver_access(&self, emu_ctx: &EmuContext) {
        self.emu_activer_access(emu_ctx, true);
    }

    fn emu_icenabler_access(&self, emu_ctx: &EmuContext) {
        let reg_idx = (emu_ctx.address & 0b1111111) / 4;
        let idx = emu_ctx.reg;
        let mut val = if emu_ctx.write { current_cpu().get_gpr(idx) } else { 0 };
        let first_int = reg_idx * 32;
        let vm_id = active_vm_id();
        let vm = match active_vm() {
            Some(vm) => vm,
            None => {
                panic!("emu_activer_access: current vcpu.vm is none");
            }
        };
        let mut vm_has_interrupt_flag = false;

        if emu_ctx.write {
            for i in 0..32 {
                if vm.has_interrupt(first_int + i) || vm.emu_has_interrupt(first_int + i) {
                    vm_has_interrupt_flag = true;
                    break;
                }
            }
            if first_int >= 16 && !vm_has_interrupt_flag {
                warn!(
                    "emu_icenabler_access: vm[{}] does not have interrupt {}",
                    vm_id, first_int
                );
                return;
            }
        }

        if emu_ctx.write {
            for i in 0..32 {
                if bit_get(val, i) != 0 {
                    self.set_enable(current_cpu().active_vcpu.clone().unwrap(), first_int + i, false);
                }
            }
        } else {
            for i in 0..32 {
                if self.get_enable(current_cpu().active_vcpu.clone().unwrap(), first_int + i) {
                    val |= 1 << i;
                }
            }
            let idx = emu_ctx.reg;
            current_cpu().set_gpr(idx, val);
        }
    }

    fn emu_icpendr_access(&self, emu_ctx: &EmuContext) {
        self.emu_pendr_access(emu_ctx, false);
    }

    fn emu_icativer_access(&self, emu_ctx: &EmuContext) {
        self.emu_activer_access(emu_ctx, false);
    }

    fn emu_icfgr_access(&self, emu_ctx: &EmuContext) {
        let first_int = (32 / GIC_CONFIG_BITS) * bit_extract(emu_ctx.address, 0, 9) / 4;
        let vm_id = active_vm_id();
        let vm = match active_vm() {
            Some(vm) => vm,
            None => {
                panic!("emu_icfgr_access: current vcpu.vm is none");
            }
        };
        let mut vm_has_interrupt_flag = false;

        if emu_ctx.write {
            for i in 0..emu_ctx.width * 8 {
                if vm.has_interrupt(first_int + i) || vm.emu_has_interrupt(first_int + i) {
                    vm_has_interrupt_flag = true;
                    break;
                }
            }
            if first_int >= 16 && !vm_has_interrupt_flag {
                warn!("emu_icfgr_access: vm[{}] does not have interrupt {}", vm_id, first_int);
                return;
            }
        }

        if emu_ctx.write {
            let idx = emu_ctx.reg;
            let cfg = current_cpu().get_gpr(idx);
            let mut irq = first_int;
            let mut bit = 0;
            while bit < emu_ctx.width * 8 {
                self.set_icfgr(
                    current_cpu().active_vcpu.clone().unwrap(),
                    irq,
                    bit_extract(cfg as usize, bit, 2) as u8,
                );
                bit += 2;
                irq += 1;
            }
        } else {
            let mut cfg = 0;
            let mut irq = first_int;
            let mut bit = 0;
            while bit < emu_ctx.width * 8 {
                cfg |= (self.get_icfgr(current_cpu().active_vcpu.clone().unwrap(), irq) as usize) << bit;
                bit += 2;
                irq += 1;
            }
            let idx = emu_ctx.reg;
            let val = cfg;
            current_cpu().set_gpr(idx, val);
        }
    }

    fn emu_sgiregs_access(&self, emu_ctx: &EmuContext) {
        let idx = emu_ctx.reg;
        let val = if emu_ctx.write { current_cpu().get_gpr(idx) } else { 0 };
        let vm = match active_vm() {
            Some(vm) => vm,
            None => {
                panic!("emu_sgiregs_access: current vcpu.vm is none");
            }
        };

        if bit_extract(emu_ctx.address, 0, 12) == bit_extract(Platform::GICD_BASE + 0x0f00, 0, 12) {
            if emu_ctx.write {
                let sgir_trglstflt = bit_extract(val, 24, 2);
                let mut trgtlist = 0;
                // println!("addr {:x}, sgir trglst flt {}, vtrgt {}", emu_ctx.address, sgir_trglstflt, bit_extract(val, 16, 8));
                match sgir_trglstflt {
                    0 => {
                        trgtlist = vgic_target_translate(vm, bit_extract(val, 16, 8) as u32, true) as usize;
                    }
                    1 => {
                        trgtlist = active_vm_ncpu() & !(1 << current_cpu().id);
                    }
                    2 => {
                        trgtlist = 1 << current_cpu().id;
                    }
                    3 => {
                        return;
                    }
                    _ => {}
                }

                for i in 0..8 {
                    if trgtlist & (1 << i) != 0 {
                        let m = IpiInitcMessage {
                            event: InitcEvent::VgicdSetPend,
                            vm_id: active_vm_id(),
                            int_id: (bit_extract(val, 0, 8) | (active_vcpu_id() << 10)) as u16,
                            val: true as u8,
                        };
                        if !ipi_send_msg(i, IpiType::IpiTIntc, IpiInnerMsg::Initc(m)) {
                            println!(
                                "emu_sgiregs_access: Failed to send ipi message, target {} type {}",
                                i, 0
                            );
                        }
                    }
                }
            }
        } else {
            // TODO: CPENDSGIR and SPENDSGIR access
            warn!("unimplemented: CPENDSGIR and SPENDSGIR access");
        }
    }

    fn emu_ipriorityr_access(&self, emu_ctx: &EmuContext) {
        let idx = emu_ctx.reg;
        let mut val = if emu_ctx.write { current_cpu().get_gpr(idx) } else { 0 };
        let first_int = (8 / GIC_PRIO_BITS) * bit_extract(emu_ctx.address, 0, 9);
        let vm_id = active_vm_id();
        let vm = match active_vm() {
            Some(vm) => vm,
            None => {
                panic!("emu_ipriorityr_access: current vcpu.vm is none");
            }
        };
        let mut vm_has_interrupt_flag = false;

        if emu_ctx.write {
            for i in 0..emu_ctx.width {
                if vm.has_interrupt(first_int + i) || vm.emu_has_interrupt(first_int + i) {
                    vm_has_interrupt_flag = true;
                    break;
                }
            }
            if first_int >= 16 && !vm_has_interrupt_flag {
                warn!(
                    "emu_ipriorityr_access: vm[{}] does not have interrupt {}",
                    vm_id, first_int
                );
                return;
            }
        }

        if emu_ctx.write {
            for i in 0..emu_ctx.width {
                self.set_prio(
                    current_cpu().active_vcpu.clone().unwrap(),
                    first_int + i,
                    bit_extract(val, GIC_PRIO_BITS * i, GIC_PRIO_BITS) as u8,
                );
            }
        } else {
            for i in 0..emu_ctx.width {
                val |= (self.get_prio(current_cpu().active_vcpu.clone().unwrap(), first_int + i) as usize)
                    << (GIC_PRIO_BITS * i);
            }
            let idx = emu_ctx.reg;
            current_cpu().set_gpr(idx, val);
        }
    }

    fn emu_itargetr_access(&self, emu_ctx: &EmuContext) {
        let idx = emu_ctx.reg;
        let mut val = if emu_ctx.write { current_cpu().get_gpr(idx) } else { 0 };
        let first_int = (8 / GIC_TARGET_BITS) * bit_extract(emu_ctx.address, 0, 9);

        if emu_ctx.write {
            // println!("write");
            val = vgic_target_translate(active_vm().unwrap(), val as u32, true) as usize;
            for i in 0..emu_ctx.width {
                self.set_trgt(
                    current_cpu().active_vcpu.clone().unwrap(),
                    first_int + i,
                    bit_extract(val, GIC_TARGET_BITS * i, GIC_TARGET_BITS) as u8,
                );
            }
        } else {
            // println!("read, first_int {}, width {}", first_int, emu_ctx.width);
            for i in 0..emu_ctx.width {
                // println!("{}", self.get_trgt(active_vcpu().unwrap(), first_int + i));
                val |= (self.get_trgt(current_cpu().active_vcpu.clone().unwrap(), first_int + i) as usize)
                    << (GIC_TARGET_BITS * i);
            }
            // println!("after read val {}", val);
            val = vgic_target_translate(active_vm().unwrap(), val as u32, false) as usize;
            let idx = emu_ctx.reg;
            current_cpu().set_gpr(idx, val);
        }
    }

    fn handle_trapped_eoir(&self, vcpu: Vcpu) {
        // if current_cpu().id == 2 {
        //     for i in 0..4 {
        //         println!("gich.LR[{}] 0x{:x}", i, GICH.lr(i));
        //     }
        //     println!("elrsr[0] {:x}", GICH.elrsr(0));
        //     println!("eisr[0] {:x}", GICH.eisr(0));
        //     println!("hcr 0x{:x}", GICH.hcr());
        // }
        let gic_lrs = gic_lrs();
        let mut lr_idx_opt = bitmap_find_nth(
            GICH.eisr(0) as usize | ((GICH.eisr(1) as usize) << 32),
            0,
            gic_lrs,
            1,
            true,
        );

        while lr_idx_opt.is_some() {
            let lr_idx = lr_idx_opt.unwrap();
            let lr_val = GICH.lr(lr_idx) as usize;
            GICH.set_lr(lr_idx, 0);

            match self.get_int(vcpu.clone(), bit_extract(lr_val, 0, 10)) {
                Some(interrupt) => {
                    let interrupt_lock = interrupt.lock.lock();
                    // if current_cpu().id == 2 {
                    //     println!("handle_trapped_eoir interrupt {}", interrupt.id());
                    // }
                    // if current_cpu().id == 1 && interrupt.id() == 49 {
                    //     println!("handle_trapped_eoir interrupt 49");
                    // }
                    interrupt.set_in_lr(false);
                    if (interrupt.id() as usize) < GIC_SGIS_NUM {
                        self.add_lr(vcpu.clone(), interrupt.clone());
                    } else {
                        vgic_int_yield_owner(vcpu.clone(), interrupt.clone());
                    }
                    drop(interrupt_lock);
                    // println!("handle_trapped_eoir: Core {} finish", current_cpu().id);
                }
                None => {
                    unimplemented!();
                }
            }
            lr_idx_opt = bitmap_find_nth(
                GICH.eisr(0) as usize | ((GICH.eisr(1) as usize) << 32),
                0,
                gic_lrs,
                1,
                true,
            );
        }
    }

    fn refill_lrs(&self, vcpu: Vcpu) {
        // if current_cpu().id == 1 {
        //     println!("refill lrs");
        // }
        let gic_lrs = gic_lrs();
        let mut has_pending = false;

        for i in 0..gic_lrs {
            let lr = GICH.lr(i) as usize;
            if bit_extract(lr, 28, 2) & 1 != 0 {
                has_pending = true;
            }
        }

        let mut lr_idx_opt = bitmap_find_nth(
            GICH.elrsr(0) as usize | ((GICH.elrsr(1) as usize) << 32),
            0,
            gic_lrs,
            1,
            true,
        );

        while lr_idx_opt.is_some() {
            let mut interrupt_opt: Option<VgicInt> = None;
            let mut prev_pend = false;
            let act_head = self.int_list_head(vcpu.clone(), false);
            let pend_head = self.int_list_head(vcpu.clone(), true);
            if has_pending {
                match act_head {
                    Some(act_int) => {
                        if !act_int.in_lr() {
                            interrupt_opt = Some(act_int.clone());
                        }
                    }
                    None => {}
                }
            }
            if interrupt_opt.is_none() {
                if let Some(pend_int) = pend_head {
                    if !pend_int.in_lr() {
                        interrupt_opt = Some(pend_int.clone());
                        prev_pend = true;
                    }
                }
            }

            match interrupt_opt {
                Some(interrupt) => {
                    // println!("refill int {}", interrupt.id());
                    vgic_int_get_owner(vcpu.clone(), interrupt.clone());
                    self.write_lr(vcpu.clone(), interrupt.clone(), lr_idx_opt.unwrap());
                    has_pending = has_pending || prev_pend;
                }
                None => {
                    // println!("no int to refill");
                    let hcr = GICH.hcr();
                    GICH.set_hcr(hcr & !(1 << 3));
                    break;
                }
            }

            lr_idx_opt = bitmap_find_nth(
                GICH.elrsr(0) as usize | ((GICH.elrsr(1) as usize) << 32),
                0,
                gic_lrs,
                1,
                true,
            );
        }
        // println!("end refill lrs");
    }

    fn eoir_highest_spilled_active(&self, vcpu: Vcpu) {
        let interrupt = self.int_list_head(vcpu.clone(), false);
        match interrupt {
            Some(int) => {
                int.lock.lock();
                vgic_int_get_owner(vcpu.clone(), int.clone());

                let state = int.state().to_num();
                int.set_state(IrqState::num_to_state(state & !2));
                self.update_int_list(vcpu.clone(), int.clone());

                if vgic_int_is_hw(int.clone()) {
                    GICD.set_act(int.id() as usize, false);
                } else {
                    if int.state().to_num() & 1 != 0 {
                        self.add_lr(vcpu, int);
                    }
                }
            }
            None => {}
        }
    }
}

fn vgic_target_translate(vm: Vm, trgt: u32, v2p: bool) -> u32 {
    let from = trgt.to_le_bytes();

    let mut result = 0;
    for (idx, val) in from
        .map(|x| {
            if v2p {
                vm.vcpu_to_pcpu_mask(x as usize, 8) as u32
            } else {
                vm.pcpu_to_vcpu_mask(x as usize, 8) as u32
            }
        })
        .iter()
        .enumerate()
    {
        result |= (*val as u32) << (8 * idx);
        if idx >= 4 {
            panic!("illegal idx, from len {}", from.len());
        }
    }
    result
}

fn vgic_owns(vcpu: Vcpu, interrupt: VgicInt) -> bool {
    if gic_is_priv(interrupt.id() as usize) {
        return true;
    }
    // if interrupt.owner().is_none() {
    //     return false;
    // }

    let vcpu_id = vcpu.id();
    let pcpu_id = vcpu.phys_id();
    match interrupt.owner() {
        Some(owner) => {
            let owner_vcpu_id = owner.id();
            let owner_pcpu_id = owner.phys_id();
            // println!(
            //     "return {}, arc same {}",
            //     owner_vcpu_id == vcpu_id && owner_pcpu_id == pcpu_id,
            //     result
            // );
            return owner_vcpu_id == vcpu_id && owner_pcpu_id == pcpu_id;
        }
        None => return false,
    }

    // let tmp = interrupt.owner().unwrap();
    // let owner_vcpu_id = interrupt.owner_id();
    // let owner_pcpu_id = interrupt.owner_phys_id();
    // let owner_vm_id = interrupt.owner_vm_id();
    // println!("3: owner_vm_id {}", owner_vm_id);

    // let vcpu_vm_id = vcpu.vm_id();

    // println!("return vgic_owns: vcpu_vm_id {}", vcpu_vm_id);
    // return (owner_vcpu_id == vcpu_id && owner_vm_id == vcpu_vm_id);
}

fn vgic_get_state(interrupt: VgicInt) -> usize {
    let mut state = interrupt.state().to_num();

    if interrupt.in_lr() && interrupt.owner_phys_id().unwrap() == current_cpu().id {
        let lr_option = gich_get_lr(interrupt.clone());
        if let Some(lr_val) = lr_option {
            state = lr_val as usize;
        }
    }

    if interrupt.id() as usize >= GIC_SGIS_NUM {
        return state;
    }
    if interrupt.owner().is_none() {
        return state;
    }

    let vm = interrupt.owner_vm();
    let vgic = vm.vgic();
    let vcpu_id = interrupt.owner_id().unwrap();

    if vgic.cpu_priv_sgis_pend(vcpu_id, interrupt.id() as usize) != 0 {
        state |= 1;
    }

    state
}

fn vgic_int_yield_owner(vcpu: Vcpu, interrupt: VgicInt) {
    if !vgic_owns(vcpu, interrupt.clone()) {
        return;
    }
    if gic_is_priv(interrupt.id() as usize) || interrupt.in_lr() {
        return;
    }

    if vgic_get_state(interrupt.clone()) & 2 == 0 {
        interrupt.clear_owner();
    }
}

fn vgic_int_is_hw(interrupt: VgicInt) -> bool {
    interrupt.id() as usize >= GIC_SGIS_NUM && interrupt.hw()
}

fn gich_get_lr(interrupt: VgicInt) -> Option<u32> {
    let cpu_id = current_cpu().id;
    let phys_id = interrupt.owner_phys_id().unwrap();

    if !interrupt.in_lr() || phys_id != cpu_id {
        return None;
    }

    let lr_val = GICH.lr(interrupt.lr() as usize);
    if (lr_val & 0b1111111111 == interrupt.id() as u32) && (lr_val >> 28 & 0b11 != 0) {
        return Some(lr_val as u32);
    }
    return None;
}

fn vgic_int_get_owner(vcpu: Vcpu, interrupt: VgicInt) -> bool {
    // if interrupt.owner().is_none() {
    //     interrupt.set_owner(vcpu.clone());
    //     return true;
    // }
    let vcpu_id = vcpu.id();
    let vcpu_vm_id = vcpu.vm_id();

    match interrupt.owner() {
        Some(owner) => {
            let owner_vcpu_id = owner.id();
            let owner_vm_id = owner.vm_id();

            owner_vm_id == vcpu_vm_id && owner_vcpu_id == vcpu_id
        }
        None => {
            interrupt.set_owner(vcpu);
            true
        }
    }

    // let owner_vcpu_id = interrupt.owner_id().unwrap();
    // let owner_vm_id = interrupt.owner_vm_id().unwrap();

    // return false;
}

pub fn gic_maintenance_handler(_arg: usize) {
    let misr = GICH.misr();
    let vm = match active_vm() {
        Some(vm) => vm,
        None => {
            panic!("gic_maintenance_handler: current vcpu.vm is None");
        }
    };
    // if current_cpu().id == 2 {
    //     println!("gic_maintenance_handler, misr {:x}", misr);
    // }
    let vgic = vm.vgic();

    if misr & 1 != 0 {
        vgic.handle_trapped_eoir(current_cpu().active_vcpu.clone().unwrap());
    }

    if misr & (1 << 3) != 0 {
        vgic.refill_lrs(current_cpu().active_vcpu.clone().unwrap());
    }

    if misr & (1 << 2) != 0 {
        // println!("in gic_maintenance_handler eoir_highest_spilled_active");
        let mut hcr = GICH.hcr();
        while hcr & (0b11111 << 27) != 0 {
            vgic.eoir_highest_spilled_active(current_cpu().active_vcpu.clone().unwrap());
            hcr -= 1 << 27;
            GICH.set_hcr(hcr);
            hcr = GICH.hcr();
        }
        // println!("end gic_maintenance_handler eoir_highest_spilled_active");
    }
}

const VGICD_REG_OFFSET_PREFIX_CTLR: usize = 0x0;
// same as TYPER & IIDR
const VGICD_REG_OFFSET_PREFIX_ISENABLER: usize = 0x2;
const VGICD_REG_OFFSET_PREFIX_ICENABLER: usize = 0x3;
const VGICD_REG_OFFSET_PREFIX_ISPENDR: usize = 0x4;
const VGICD_REG_OFFSET_PREFIX_ICPENDR: usize = 0x5;
const VGICD_REG_OFFSET_PREFIX_ISACTIVER: usize = 0x6;
const VGICD_REG_OFFSET_PREFIX_ICACTIVER: usize = 0x7;
const VGICD_REG_OFFSET_PREFIX_ICFGR: usize = 0x18;
const VGICD_REG_OFFSET_PREFIX_SGIR: usize = 0x1e;

pub fn emu_intc_handler(_emu_dev_id: usize, emu_ctx: &EmuContext) -> bool {
    let offset = emu_ctx.address & 0xfff;
    if emu_ctx.width > 4 {
        return false;
    }

    let vm = match crate::kernel::active_vm() {
        None => {
            panic!("emu_intc_handler: vm is None");
        }
        Some(x) => x,
    };
    let vgic = vm.vgic();
    let vgicd_offset_prefix = (offset & 0xf80) >> 7;
    // if current_cpu().id == 2 {
    //     println!(
    //         "emu_intc_handler: vgicd_offset_prefix 0x{:x}, offset 0x{:x}",
    //         vgicd_offset_prefix, offset
    //     );
    // }
    if !vgicd_emu_access_is_vaild(emu_ctx) {
        return false;
    }

    match vgicd_offset_prefix {
        VGICD_REG_OFFSET_PREFIX_ISENABLER => {
            vgic.emu_isenabler_access(emu_ctx);
        }
        VGICD_REG_OFFSET_PREFIX_ISPENDR => {
            vgic.emu_ispendr_access(emu_ctx);
        }
        VGICD_REG_OFFSET_PREFIX_ISACTIVER => {
            vgic.emu_isactiver_access(emu_ctx);
        }
        VGICD_REG_OFFSET_PREFIX_ICENABLER => {
            vgic.emu_icenabler_access(emu_ctx);
        }
        VGICD_REG_OFFSET_PREFIX_ICPENDR => {
            vgic.emu_icpendr_access(emu_ctx);
        }
        VGICD_REG_OFFSET_PREFIX_ICACTIVER => {
            vgic.emu_icativer_access(emu_ctx);
        }
        VGICD_REG_OFFSET_PREFIX_ICFGR => {
            vgic.emu_icfgr_access(emu_ctx);
        }
        VGICD_REG_OFFSET_PREFIX_SGIR => {
            vgic.emu_sgiregs_access(emu_ctx);
        }
        _ => {
            match offset {
                // VGICD_REG_OFFSET(CTLR)
                0 => {
                    vgic.emu_ctrl_access(emu_ctx);
                }
                // VGICD_REG_OFFSET(TYPER)
                0x004 => {
                    vgic.emu_typer_access(emu_ctx);
                }
                // VGICD_REG_OFFSET(IIDR)
                0x008 => {
                    vgic.emu_iidr_access(emu_ctx);
                }
                _ => {
                    if !emu_ctx.write {
                        let idx = emu_ctx.reg;
                        let val = 0;
                        current_cpu().set_gpr(idx, val);
                    }
                }
            }
            if offset >= 0x400 && offset < 0x800 {
                vgic.emu_ipriorityr_access(emu_ctx);
            } else if offset >= 0x800 && offset < 0xc00 {
                vgic.emu_itargetr_access(emu_ctx);
            }
        }
    }
    // println!("finish emu_intc_handler");
    true
}

pub fn vgicd_emu_access_is_vaild(emu_ctx: &EmuContext) -> bool {
    let offset = emu_ctx.address & 0xfff;
    let offset_prefix = (offset & 0xf80) >> 7;
    match offset_prefix {
        VGICD_REG_OFFSET_PREFIX_CTLR
        | VGICD_REG_OFFSET_PREFIX_ISENABLER
        | VGICD_REG_OFFSET_PREFIX_ISPENDR
        | VGICD_REG_OFFSET_PREFIX_ISACTIVER
        | VGICD_REG_OFFSET_PREFIX_ICENABLER
        | VGICD_REG_OFFSET_PREFIX_ICPENDR
        | VGICD_REG_OFFSET_PREFIX_ICACTIVER
        | VGICD_REG_OFFSET_PREFIX_ICFGR => {
            if emu_ctx.width != 4 || emu_ctx.address & 0x3 != 0 {
                return false;
            }
        }
        VGICD_REG_OFFSET_PREFIX_SGIR => {
            if (emu_ctx.width == 4 && emu_ctx.address & 0x3 != 0) || (emu_ctx.width == 2 && emu_ctx.address & 0x1 != 0)
            {
                return false;
            }
        }
        _ => {
            // TODO: hard code to rebuild (gicd IPRIORITYR and ITARGETSR)
            if offset >= 0x400 && offset < 0xc00 {
                if (emu_ctx.width == 4 && emu_ctx.address & 0x3 != 0)
                    || (emu_ctx.width == 2 && emu_ctx.address & 0x1 != 0)
                {
                    return false;
                }
            }
        }
    }
    true
}

pub fn partial_passthrough_intc_handler(_emu_dev_id: usize, emu_ctx: &EmuContext) -> bool {
    if !vgicd_emu_access_is_vaild(emu_ctx) {
        return false;
    }
    let offset = emu_ctx.address & 0xfff;
    // println!(
    //     "partial_passthrough_intc_handler: {} offset_prefix 0x{:x}, offset 0x{:x}",
    //     if emu_ctx.write { "write" } else { "read" }, offset_prefix, offset
    // );
    if emu_ctx.write {
        // todo: add offset match
        let val = current_cpu().get_gpr(emu_ctx.reg);
        ptr_read_write(Platform::GICD_BASE + 0x8_0000_0000 + offset, emu_ctx.width, val, false);
    } else {
        let res = ptr_read_write(Platform::GICD_BASE + 0x8_0000_0000 + offset, emu_ctx.width, 0, true);
        current_cpu().set_gpr(emu_ctx.reg, res);
    }

    true
}

pub fn vgic_ipi_handler(msg: &IpiMessage) {
    let vm_id;
    let int_id;
    let val;
    match &msg.ipi_message {
        IpiInnerMsg::Initc(intc) => {
            vm_id = intc.vm_id;
            int_id = intc.int_id;
            val = intc.val;
        }
        _ => {
            println!("vgic_ipi_handler: illegal ipi");
            return;
        }
    }
    let trgt_vcpu = match current_cpu().vcpu_array.pop_vcpu_through_vmid(vm_id) {
        None => {
            println!("Core {} received vgic msg from unknown VM {}", current_cpu().id, vm_id);
            return;
        }
        Some(vcpu) => vcpu,
    };
    restore_vcpu_gic(current_cpu().active_vcpu.clone(), trgt_vcpu.clone());

    let vm = match trgt_vcpu.vm() {
        None => {
            panic!("vgic_ipi_handler: vm is None");
        }
        Some(x) => x,
    };
    let vgic = vm.vgic();

    if vm_id as usize != vm.id() {
        println!("VM {} received vgic msg from another vm {}", vm.id(), vm_id);
        return;
    }
    if let IpiInnerMsg::Initc(intc) = &msg.ipi_message {
        // println!(
        //     "vgic_ipi_handler: core {} receive vgic_ipi, event {:?}, vm_id {}, int_id {}, val 0x{:x}",
        //     current_cpu().id,
        //     intc.event,
        //     vm_id,
        //     int_id,
        //     val
        // );
        match intc.event {
            InitcEvent::VgicdGichEn => {
                let hcr = GICH.hcr();
                if val != 0 {
                    GICH.set_hcr(hcr | 0b1);
                } else {
                    GICH.set_hcr(hcr & !0b1);
                }
            }
            InitcEvent::VgicdSetEn => {
                vgic.set_enable(trgt_vcpu.clone(), int_id as usize, val != 0);
            }
            InitcEvent::VgicdSetPend => {
                vgic.set_pend(trgt_vcpu.clone(), int_id as usize, val != 0);
            }
            InitcEvent::VgicdSetPrio => {
                vgic.set_prio(trgt_vcpu.clone(), int_id as usize, val);
            }
            InitcEvent::VgicdSetTrgt => {
                vgic.set_trgt(trgt_vcpu.clone(), int_id as usize, val);
            }
            InitcEvent::VgicdRoute => {
                let interrupt_option = vgic.get_int(trgt_vcpu.clone(), bit_extract(int_id as usize, 0, 10));
                if let Some(interrupt) = interrupt_option {
                    let interrupt_lock = interrupt.lock.lock();
                    if vgic_int_get_owner(trgt_vcpu.clone(), interrupt.clone()) {
                        if (interrupt.targets() & (1 << current_cpu().id)) != 0 {
                            vgic.add_lr(trgt_vcpu.clone(), interrupt.clone());
                        }
                        vgic_int_yield_owner(trgt_vcpu.clone(), interrupt.clone());
                    }
                    drop(interrupt_lock);
                }
            }
            _ => {
                println!("vgic_ipi_handler: core {} received unknown event", current_cpu().id)
            }
        }
    }
    save_vcpu_gic(current_cpu().active_vcpu.clone(), trgt_vcpu);
}

pub fn emu_intc_init(vm: Vm, emu_dev_id: usize) {
    let vgic_cpu_num = vm.config().cpu_num();
    vm.init_intc_mode(true);

    let vgic = Arc::new(Vgic::default());

    let mut vgicd = vgic.vgicd.lock();
    vgicd.typer = (GICD.typer() & GICD_TYPER_CPUNUM_MSK as u32)
        | (((vm.cpu_num() - 1) << GICD_TYPER_CPUNUM_OFF) & GICD_TYPER_CPUNUM_MSK) as u32;
    vgicd.iidr = GICD.iidr();

    for i in 0..GIC_SPI_MAX {
        vgicd.interrupts.push(VgicInt::new(i));
    }
    drop(vgicd);

    for i in 0..vgic_cpu_num {
        let mut cpu_priv = VgicCpuPriv::default();
        for int_idx in 0..GIC_PRIVINT_NUM {
            let vcpu = vm.vcpu(i).unwrap();
            let phys_id = vcpu.phys_id();

            cpu_priv.interrupts.push(VgicInt::priv_new(
                int_idx,
                vcpu.clone(),
                1 << phys_id,
                int_idx < GIC_SGIS_NUM,
            ));
        }

        let mut vgic_cpu_priv = vgic.cpu_priv.lock();
        vgic_cpu_priv.push(cpu_priv);
    }

    vm.set_emu_devs(emu_dev_id, EmuDevs::Vgic(vgic.clone()));
}

pub fn partial_passthrough_intc_init(vm: Vm) {
    vm.init_intc_mode(false);
}

pub fn vgic_set_hw_int(vm: Vm, int_id: usize) {
    if int_id < GIC_SGIS_NUM {
        return;
    }

    if !vm.has_vgic() {
        return;
    }
    let vgic = vm.vgic();

    if int_id < GIC_PRIVINT_NUM {
        for i in 0..vm.cpu_num() {
            let interrupt_option = vgic.get_int(vm.vcpu(i).unwrap(), int_id);
            match interrupt_option {
                Some(interrupt) => {
                    let interrupt_lock = interrupt.lock.lock();
                    // println!(
                    //     "vgic_set_hw_int: Core {} get int {} lock",
                    //     cpu_id(),
                    //     interrupt.id()
                    // );
                    interrupt.set_hw(true);
                    drop(interrupt_lock);
                }
                None => {}
            }
        }
    } else {
        let interrupt_option = vgic.get_int(vm.vcpu(0).unwrap(), int_id);
        match interrupt_option {
            Some(interrupt) => {
                let interrupt_lock = interrupt.lock.lock();
                // println!(
                //     "vgic_set_hw_int: Core {} get int {} lock",
                //     cpu_id(),
                //     interrupt.id()
                // );
                interrupt.set_hw(true);
                drop(interrupt_lock);
            }
            None => {}
        }
    }
}
