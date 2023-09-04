// Copyright (c) 2023 Beihang University, Huawei Technologies Co.,Ltd. All rights reserved.
// Rust-Shyper is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//          http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

use alloc::string::{String, ToString};
use alloc::sync::Arc;
use alloc::vec::Vec;

use spin::Mutex;

// use crate::board::*;
use crate::device::{EmuDeviceType, mediated_blk_free, mediated_blk_request};
use crate::kernel::{active_vm, vm, Vm, vm_ipa2pa, VM_NUM_MAX, VmType};
use crate::lib::{BitAlloc, BitAlloc16, memcpy_safe};
use crate::vmm::vmm_init_gvm;

pub const NAME_MAX_LEN: usize = 32;
const CFG_MAX_NUM: usize = 0x10;
const IRQ_MAX_NUM: usize = 0x40;
const PASSTHROUGH_DEV_MAX_NUM: usize = 128;
const EMULATED_DEV_MAX_NUM: usize = 16;

#[derive(Clone, Copy, PartialEq)]
pub enum DtbDevType {
    DevSerial = 0,
    DevGicd = 1,
    DevGicc = 2,
}

impl DtbDevType {
    pub fn from_usize(value: usize) -> DtbDevType {
        match value {
            0 => DtbDevType::DevSerial,
            1 => DtbDevType::DevGicd,
            2 => DtbDevType::DevGicc,
            _ => panic!("Unknown DtbDevType value: {}", value),
        }
    }
}

#[derive(Clone)]
pub struct VmEmulatedDeviceConfig {
    pub name: Option<String>,
    pub base_ipa: usize,
    pub length: usize,
    pub irq_id: usize,
    pub cfg_list: Vec<usize>,
    pub emu_type: EmuDeviceType,
    pub mediated: bool,
}

pub struct VmEmulatedDeviceConfigList {
    pub emu_dev_list: Vec<VmEmulatedDeviceConfig>,
}

impl VmEmulatedDeviceConfigList {
    pub const fn default() -> VmEmulatedDeviceConfigList {
        VmEmulatedDeviceConfigList {
            emu_dev_list: Vec::new(),
        }
    }
}

#[derive(Default, Clone, Copy, Debug, Eq)]
pub struct PassthroughRegion {
    pub ipa: usize,
    pub pa: usize,
    pub length: usize,
    pub dev_property: bool,
}

impl PartialEq for PassthroughRegion {
    fn eq(&self, other: &Self) -> bool {
        self.ipa == other.ipa && self.pa == other.pa && self.length == other.length
    }
}

#[derive(Default, Clone)]
pub struct VmPassthroughDeviceConfig {
    pub regions: Vec<PassthroughRegion>,
    pub irqs: Vec<usize>,
    pub streams_ids: Vec<usize>,
}

impl VmPassthroughDeviceConfig {
    pub const fn default() -> VmPassthroughDeviceConfig {
        VmPassthroughDeviceConfig {
            regions: Vec::new(),
            irqs: Vec::new(),
            streams_ids: Vec::new(),
        }
    }
}

#[derive(Clone, Copy, Debug, Eq)]
pub struct VmRegion {
    pub ipa_start: usize,
    pub length: usize,
}

impl VmRegion {
    pub const fn default() -> VmRegion {
        VmRegion {
            ipa_start: 0,
            length: 0,
        }
    }
}

impl PartialEq for VmRegion {
    fn eq(&self, other: &Self) -> bool {
        self.ipa_start == other.ipa_start && self.length == other.length
    }
}

#[derive(Clone)]
pub struct VmMemoryConfig {
    pub region: Vec<VmRegion>,
}

impl VmMemoryConfig {
    pub const fn default() -> VmMemoryConfig {
        VmMemoryConfig { region: vec![] }
    }
}

#[derive(Clone, Copy)]
pub struct VmImageConfig {
    pub kernel_img_name: Option<&'static str>,
    pub kernel_load_ipa: usize,
    pub kernel_load_pa: usize,
    pub kernel_entry_point: usize,
    // pub device_tree_filename: Option<&'static str>,
    pub device_tree_load_ipa: usize,
    // pub ramdisk_filename: Option<&'static str>,
    pub ramdisk_load_ipa: usize,
    pub mediated_block_index: Option<usize>,
}

impl VmImageConfig {
    pub const fn default() -> VmImageConfig {
        VmImageConfig {
            kernel_img_name: None,
            kernel_load_ipa: 0,
            kernel_load_pa: 0,
            kernel_entry_point: 0,
            // device_tree_filename: None,
            device_tree_load_ipa: 0,
            // ramdisk_filename: None,
            ramdisk_load_ipa: 0,
            mediated_block_index: None,
        }
    }
    pub fn new(kernel_load_ipa: usize, device_tree_load_ipa: usize, ramdisk_load_ipa: usize) -> VmImageConfig {
        VmImageConfig {
            kernel_img_name: None,
            kernel_load_ipa,
            kernel_load_pa: 0,
            kernel_entry_point: kernel_load_ipa,
            // device_tree_filename: None,
            device_tree_load_ipa,
            // ramdisk_filename: None,
            ramdisk_load_ipa,
            mediated_block_index: None,
        }
    }
}

#[derive(Clone, Copy)]
pub struct VmCpuConfig {
    pub num: usize,
    pub allocate_bitmap: u32,
    pub master: i32,
}

impl VmCpuConfig {
    pub const fn default() -> VmCpuConfig {
        VmCpuConfig {
            num: 0,
            allocate_bitmap: 0,
            master: 0,
        }
    }
}

#[derive(Clone, Copy)]
pub struct AddrRegions {
    pub ipa: usize,
    pub length: usize,
}

#[derive(Clone)]
pub struct VmDtbDevConfig {
    pub name: String,
    pub dev_type: DtbDevType,
    pub irqs: Vec<usize>,
    pub addr_region: AddrRegions,
}

#[derive(Clone)]
pub struct VMDtbDevConfigList {
    pub dtb_device_list: Vec<VmDtbDevConfig>,
}

impl VMDtbDevConfigList {
    pub const fn default() -> VMDtbDevConfigList {
        VMDtbDevConfigList {
            dtb_device_list: Vec::new(),
        }
    }
}

#[derive(Clone)]
pub struct VmConfigEntry {
    // VM id, generate inside hypervisor.
    pub id: usize,
    // Following configs are not intended to be modified during configuration.
    pub name: Option<String>,
    pub os_type: VmType,
    pub cmdline: String,
    // Following config can be modified during configuration.
    pub image: Arc<Mutex<VmImageConfig>>,
    pub memory: Arc<Mutex<VmMemoryConfig>>,
    pub cpu: Arc<Mutex<VmCpuConfig>>,
    pub vm_emu_dev_confg: Arc<Mutex<VmEmulatedDeviceConfigList>>,
    pub vm_pt_dev_confg: Arc<Mutex<VmPassthroughDeviceConfig>>,
    pub vm_dtb_devs: Arc<Mutex<VMDtbDevConfigList>>,
}

impl VmConfigEntry {
    pub fn default() -> VmConfigEntry {
        VmConfigEntry {
            id: 0,
            name: Some(String::from("unknown")),
            os_type: VmType::VmTBma,

            cmdline: String::from("root=/dev/vda rw audit=0"),

            image: Arc::new(Mutex::new(VmImageConfig::default())),
            memory: Arc::new(Mutex::new(VmMemoryConfig::default())),
            cpu: Arc::new(Mutex::new(VmCpuConfig::default())),
            vm_emu_dev_confg: Arc::new(Mutex::new(VmEmulatedDeviceConfigList::default())),
            vm_pt_dev_confg: Arc::new(Mutex::new(VmPassthroughDeviceConfig::default())),
            vm_dtb_devs: Arc::new(Mutex::new(VMDtbDevConfigList::default())),
        }
    }

    pub fn new(
        name: String,
        cmdline: String,
        vm_type: usize,
        kernel_load_ipa: usize,
        device_tree_load_ipa: usize,
        ramdisk_load_ipa: usize,
    ) -> VmConfigEntry {
        VmConfigEntry {
            id: 0,
            name: Some(name),
            os_type: VmType::from_usize(vm_type),
            cmdline,
            image: Arc::new(Mutex::new(VmImageConfig::new(
                kernel_load_ipa,
                device_tree_load_ipa,
                ramdisk_load_ipa,
            ))),
            memory: Arc::new(Mutex::new(VmMemoryConfig::default())),
            cpu: Arc::new(Mutex::new(VmCpuConfig::default())),
            vm_emu_dev_confg: Arc::new(Mutex::new(VmEmulatedDeviceConfigList::default())),
            vm_pt_dev_confg: Arc::new(Mutex::new(VmPassthroughDeviceConfig::default())),
            vm_dtb_devs: Arc::new(Mutex::new(VMDtbDevConfigList::default())),
        }
    }

    pub fn id(&self) -> usize {
        self.id
    }

    pub fn set_id(&mut self, id: usize) {
        self.id = id;
    }

    pub fn vm_name(&self) -> String {
        match &self.name {
            Some(name) => name.to_string(),
            None => String::from("unknown"),
        }
    }

    pub fn mediated_block_index(&self) -> Option<usize> {
        let img_cfg = self.image.lock();
        img_cfg.mediated_block_index
    }

    pub fn set_mediated_block_index(&mut self, med_blk_id: usize) {
        let mut img_cfg = self.image.lock();
        // println!("set_mediated_block_index {}",med_blk_id);
        img_cfg.mediated_block_index = Some(med_blk_id);
        // println!("set_mediated_block_index {} self.med_blk_idx {:?}",med_blk_id, img_cfg.mediated_block_index);
    }

    pub fn kernel_img_name(&self) -> Option<&'static str> {
        let img_cfg = self.image.lock();
        img_cfg.kernel_img_name
    }

    pub fn kernel_load_ipa(&self) -> usize {
        let img_cfg = self.image.lock();
        img_cfg.kernel_load_ipa
    }

    pub fn set_kernel_load_pa(&mut self, kernel_load_pa: usize) {
        let mut img_cfg = self.image.lock();
        img_cfg.kernel_load_pa = kernel_load_pa
    }

    pub fn kernel_load_pa(&self) -> usize {
        let img_cfg = self.image.lock();
        img_cfg.kernel_load_pa
    }

    pub fn kernel_entry_point(&self) -> usize {
        let img_cfg = self.image.lock();
        img_cfg.kernel_entry_point
    }

    pub fn device_tree_load_ipa(&self) -> usize {
        let img_cfg = self.image.lock();
        img_cfg.device_tree_load_ipa
    }

    pub fn ramdisk_load_ipa(&self) -> usize {
        let img_cfg = self.image.lock();
        img_cfg.ramdisk_load_ipa
    }

    pub fn memory_region(&self) -> Vec<VmRegion> {
        let mem_cfg = self.memory.lock();
        mem_cfg.region.clone()
    }

    pub fn add_memory_cfg(&self, ipa_start: usize, length: usize) {
        let mut mem_cfg = self.memory.lock();
        mem_cfg.region.push(VmRegion { ipa_start, length });
    }

    pub fn cpu_num(&self) -> usize {
        let cpu_cfg = self.cpu.lock();
        cpu_cfg.num
    }

    pub fn cpu_allocated_bitmap(&self) -> u32 {
        let cpu_cfg = self.cpu.lock();
        cpu_cfg.allocate_bitmap
    }

    pub fn cpu_master(&self) -> usize {
        let cpu_cfg = self.cpu.lock();
        cpu_cfg.master as usize
    }

    pub fn set_cpu_cfg(&self, num: usize, allocate_bitmap: usize, master: usize) {
        let mut cpu_cfg = self.cpu.lock();
        cpu_cfg.num = usize::min(num, allocate_bitmap.count_ones() as usize);
        cpu_cfg.allocate_bitmap = allocate_bitmap as u32;
        cpu_cfg.master = master as i32;
    }

    pub fn emulated_device_list(&self) -> Vec<VmEmulatedDeviceConfig> {
        let emu_dev_cfg = self.vm_emu_dev_confg.lock();
        emu_dev_cfg.emu_dev_list.clone()
    }

    pub fn add_emulated_device_cfg(&self, cfg: VmEmulatedDeviceConfig) {
        let mut emu_dev_cfgs = self.vm_emu_dev_confg.lock();
        emu_dev_cfgs.emu_dev_list.push(cfg);
    }

    pub fn passthrough_device_regions(&self) -> Vec<PassthroughRegion> {
        let pt_dev_cfg = self.vm_pt_dev_confg.lock();
        pt_dev_cfg.regions.clone()
    }

    pub fn passthrough_device_irqs(&self) -> Vec<usize> {
        let pt_dev_cfg = self.vm_pt_dev_confg.lock();
        pt_dev_cfg.irqs.clone()
    }

    pub fn passthrough_device_stread_ids(&self) -> Vec<usize> {
        let pt_dev_cfg = self.vm_pt_dev_confg.lock();
        pt_dev_cfg.streams_ids.clone()
    }

    pub fn add_passthrough_device_region(&self, base_ipa: usize, base_pa: usize, length: usize) {
        let mut pt_dev_cfg = self.vm_pt_dev_confg.lock();
        let pt_region_cfg = PassthroughRegion {
            ipa: base_ipa,
            pa: base_pa,
            length,
            dev_property: true,
        };
        pt_dev_cfg.regions.push(pt_region_cfg)
    }

    pub fn add_passthrough_device_irqs(&self, irqs: &mut Vec<usize>) {
        let mut pt_dev_cfg = self.vm_pt_dev_confg.lock();
        pt_dev_cfg.irqs.append(irqs);
    }

    pub fn add_passthrough_device_streams_ids(&self, streams_ids: &mut Vec<usize>) {
        let mut pt_dev_cfg = self.vm_pt_dev_confg.lock();
        pt_dev_cfg.streams_ids.append(streams_ids);
    }

    pub fn dtb_device_list(&self) -> Vec<VmDtbDevConfig> {
        let dtb_dev_cfg = self.vm_dtb_devs.lock();
        dtb_dev_cfg.dtb_device_list.clone()
    }

    pub fn add_dtb_device(&self, cfg: VmDtbDevConfig) {
        let mut dtb_dev_cfg = self.vm_dtb_devs.lock();
        dtb_dev_cfg.dtb_device_list.push(cfg);
    }

    pub fn gicc_addr(&self) -> usize {
        let dtb_devs = self.vm_dtb_devs.lock();
        for dev in &dtb_devs.dtb_device_list {
            match dev.dev_type {
                DtbDevType::DevGicc => {
                    return dev.addr_region.ipa;
                }
                _ => {}
            }
        }
        0
    }

    pub fn gicd_addr(&self) -> usize {
        let dtb_devs = self.vm_dtb_devs.lock();
        for dev in &dtb_devs.dtb_device_list {
            match dev.dev_type {
                DtbDevType::DevGicd => {
                    return dev.addr_region.ipa;
                }
                _ => {}
            }
        }
        0
    }
}

#[derive(Clone)]
pub struct VmConfigTable {
    pub name: Option<&'static str>,
    pub vm_bitmap: BitAlloc16,
    pub vm_num: usize,
    pub entries: Vec<VmConfigEntry>,
}

impl VmConfigTable {
    pub const fn default() -> VmConfigTable {
        VmConfigTable {
            name: None,
            vm_bitmap: BitAlloc16::default(),
            vm_num: 0,
            entries: Vec::new(),
        }
    }

    pub fn generate_vm_id(&mut self) -> Result<usize, ()> {
        for i in 0..VM_NUM_MAX {
            if self.vm_bitmap.get(i) == 0 {
                self.vm_bitmap.set(i);
                return Ok(i);
            }
        }
        Err(())
    }

    pub fn remove_vm_id(&mut self, vm_id: usize) {
        if vm_id >= VM_NUM_MAX || self.vm_bitmap.get(vm_id) == 0 {
            println!("illegal vm id {}", vm_id);
        }
        self.vm_bitmap.clear(vm_id);
    }
}

// lazy_static! {
pub static DEF_VM_CONFIG_TABLE: Mutex<VmConfigTable> = Mutex::new(VmConfigTable::default());
// }

pub fn vm_cfg_set_config_name(name: &'static str) {
    let mut vm_config = DEF_VM_CONFIG_TABLE.lock();
    vm_config.name = Some(name);
}

pub fn vm_num() -> usize {
    let vm_config = DEF_VM_CONFIG_TABLE.lock();
    vm_config.entries.len()
}

pub fn vm_type(vmid: usize) -> VmType {
    let vm_config = DEF_VM_CONFIG_TABLE.lock();
    for vm_cfg_entry in vm_config.entries.iter() {
        if vm_cfg_entry.id == vmid {
            return vm_cfg_entry.os_type;
        }
    }
    println!("failed to find VM[{}] in vm cfg entry list", vmid);
    return VmType::VmTOs;
}

pub fn vm_id_list() -> Vec<usize> {
    let vm_config = DEF_VM_CONFIG_TABLE.lock();
    let mut id_list: Vec<usize> = Vec::new();
    for vm_cfg_entry in vm_config.entries.iter() {
        id_list.push(vm_cfg_entry.id)
    }
    id_list
}

pub fn vm_cfg_entry(vmid: usize) -> Option<VmConfigEntry> {
    let vm_config = DEF_VM_CONFIG_TABLE.lock();
    for vm_cfg_entry in vm_config.entries.iter() {
        if vm_cfg_entry.id == vmid {
            return Some(vm_cfg_entry.clone());
        }
    }
    println!("failed to find VM[{}] in vm cfg entry list", vmid);
    return None;
}

/* Add VM config entry to DEF_VM_CONFIG_TABLE */
pub fn vm_cfg_add_vm_entry(mut vm_cfg_entry: VmConfigEntry) -> Result<usize, ()> {
    let mut vm_config = DEF_VM_CONFIG_TABLE.lock();
    match vm_config.generate_vm_id() {
        Ok(vm_id) => {
            if vm_id == 0 && (vm_config.entries.len() > 0 || vm_config.vm_num > 0) {
                panic!("error in mvm config init, the def vm config table is not empty");
            }
            vm_cfg_entry.set_id(vm_id);
            vm_config.vm_num += 1;
            vm_config.entries.push(vm_cfg_entry.clone());
            println!(
                "\nSuccessfully add {}[{}] name {:?}, currently vm_num {}",
                if vm_id == 0 { "MVM" } else { "GVM" },
                vm_cfg_entry.id(),
                vm_cfg_entry.clone().name.unwrap(),
                vm_config.vm_num
            );

            Ok(vm_id)
        }
        Err(_) => {
            println!("vm_cfg_add_vm_entry, vm num reached max value");
            Err(())
        }
    }
}

pub fn vm_cfg_remove_vm_entry(vm_id: usize) {
    let mut vm_config = DEF_VM_CONFIG_TABLE.lock();
    for (idx, vm_cfg_entry) in vm_config.entries.iter().enumerate() {
        if vm_cfg_entry.id == vm_id {
            vm_config.vm_num -= 1;
            vm_config.remove_vm_id(vm_id);
            match vm_config.entries[idx].mediated_block_index() {
                None => {}
                Some(block_idx) => {
                    mediated_blk_free(block_idx);
                }
            }
            vm_config.entries.remove(idx);
            // println!("remove VM[{}] config from vm-config-table", vm_id);
            return;
        }
    }
    println!("VM[{}] config not found in vm-config-table", vm_id);
}

/* Generate a new VM Config Entry, set basic value */
pub fn vm_cfg_add_vm(config_ipa: usize) -> Result<usize, ()> {
    let config_pa = vm_ipa2pa(active_vm().unwrap(), config_ipa);
    let (
        vm_name_ipa,
        vm_name_length,
        vm_type,
        cmdline_ipa,
        cmdline_length,
        kernel_load_ipa,
        device_tree_load_ipa,
        ramdisk_load_ipa,
    ) = unsafe { *(config_pa as *const _) };
    println!("\n\nStart to prepare configuration for new VM");

    // Copy VM name from user ipa.
    let vm_name_pa = vm_ipa2pa(active_vm().unwrap(), vm_name_ipa);
    if vm_name_pa == 0 {
        println!("illegal vm_name_ipa {:x}", vm_name_ipa);
        return Err(());
    }
    let vm_name_u8 = vec![0 as u8; vm_name_length];
    if vm_name_length > 0 {
        memcpy_safe(
            &vm_name_u8[0] as *const _ as *const u8,
            vm_name_pa as *mut u8,
            vm_name_length,
        );
    }

    let vm_name_str = match String::from_utf8(vm_name_u8.clone()) {
        Ok(_str) => _str,
        Err(error) => {
            println!("error: {:?} in parsing the vm_name {:?}", error, vm_name_u8);
            String::from("unknown")
        }
    };

    // Copy VM cmdline from user ipa.
    let cmdline_pa = vm_ipa2pa(active_vm().unwrap(), cmdline_ipa);
    if cmdline_pa == 0 {
        println!("illegal cmdline_ipa {:x}", cmdline_ipa);
        return Err(());
    }
    let cmdline_u8 = vec![0 as u8; cmdline_length];
    if cmdline_length > 0 {
        memcpy_safe(
            &cmdline_u8[0] as *const _ as *const u8,
            cmdline_pa as *mut u8,
            cmdline_length,
        );
    }
    let cmdline_str = match String::from_utf8(cmdline_u8.clone()) {
        Ok(_str) => _str,
        Err(error) => {
            println!("error: {:?} in parsing the cmdline {:?}", error, cmdline_u8);
            String::from("unknown")
        }
    };

    // Generate a new VM config entry.
    let new_vm_cfg = VmConfigEntry::new(
        vm_name_str,
        cmdline_str,
        vm_type,
        kernel_load_ipa,
        device_tree_load_ipa,
        ramdisk_load_ipa,
    );

    println!("      VM name is [{:?}]", new_vm_cfg.name.clone().unwrap());
    println!("      cmdline is [{:?}]", new_vm_cfg.cmdline);
    println!("      ramdisk is [0x{:x}]", new_vm_cfg.ramdisk_load_ipa());
    vm_cfg_add_vm_entry(new_vm_cfg)
}

/* Delete a VM config entry */
pub fn vm_cfg_del_vm(vmid: usize) -> Result<usize, ()> {
    println!("VM[{}] delete config entry", vmid);
    vm_cfg_remove_vm_entry(vmid);
    Ok(0)
}

/* Add VM memory region according to VM id */
pub fn vm_cfg_add_mem_region(vmid: usize, ipa_start: usize, length: usize) -> Result<usize, ()> {
    let vm_cfg = match vm_cfg_entry(vmid) {
        Some(vm_cfg) => vm_cfg,
        None => return Err(()),
    };
    vm_cfg.add_memory_cfg(ipa_start, length);
    println!(
        "\nVM[{}] vm_cfg_add_mem_region: add region start_ipa {:x} length {:x}",
        vmid, ipa_start, length
    );
    Ok(0)
}

/* Set VM cpu config according to VM id */
pub fn vm_cfg_set_cpu(vmid: usize, num: usize, allocate_bitmap: usize, master: usize) -> Result<usize, ()> {
    let vm_cfg = match vm_cfg_entry(vmid) {
        Some(vm_cfg) => vm_cfg,
        None => return Err(()),
    };

    vm_cfg.set_cpu_cfg(num, allocate_bitmap, master);

    println!(
        "\nVM[{}] vm_cfg_set_cpu: num {} allocate_bitmap {} master {}",
        vmid,
        vm_cfg.cpu_num(),
        vm_cfg.cpu_allocated_bitmap(),
        vm_cfg.cpu_master()
    );

    Ok(0)
}

/* Add emulated device config for VM */
pub fn vm_cfg_add_emu_dev(
    vmid: usize,
    name_ipa: usize,
    base_ipa: usize,
    length: usize,
    irq_id: usize,
    cfg_list_ipa: usize,
    emu_type: usize,
) -> Result<usize, ()> {
    let mut vm_cfg = match vm_cfg_entry(vmid) {
        Some(vm_cfg) => vm_cfg,
        None => return Err(()),
    };
    let emu_cfg_list = vm_cfg.emulated_device_list();

    // Copy emu device name from user ipa.
    let name_pa = vm_ipa2pa(active_vm().unwrap(), name_ipa);
    if name_pa == 0 {
        println!("illegal emulated device name_ipa {:x}", name_ipa);
        return Err(());
    }
    let name_u8 = vec![0 as u8; NAME_MAX_LEN];
    memcpy_safe(&name_u8[0] as *const _ as *const u8, name_pa as *mut u8, NAME_MAX_LEN);
    let name_str = match String::from_utf8(name_u8.clone()) {
        Ok(str) => str,
        Err(error) => {
            println!("error: {:?} in parsing the emulated device name {:?}", error, name_u8);
            String::from("unknown")
        }
    };
    // Copy emu device cfg list from user ipa.
    let cfg_list_pa = vm_ipa2pa(active_vm().unwrap(), cfg_list_ipa);
    if cfg_list_pa == 0 {
        println!("illegal emulated device cfg_list_ipa {:x}", cfg_list_ipa);
        return Err(());
    }
    let cfg_list = vec![0 as usize; CFG_MAX_NUM];
    memcpy_safe(
        &cfg_list[0] as *const _ as *const u8,
        cfg_list_pa as *mut u8,
        CFG_MAX_NUM * 8, // sizeof(usize) / sizeof(u8)
    );

    println!(
        concat!(
            "\nVM[{}] vm_cfg_add_emu_dev: ori emu dev num {}\n",
            "    name {:?}\n",
            "     cfg_list {:?}\n",
            "     base ipa {:x} length {:x} irq_id {} emu_type {}"
        ),
        vmid,
        emu_cfg_list.len(),
        name_str.trim_end_matches(char::from(0)),
        cfg_list,
        base_ipa,
        length,
        irq_id,
        emu_type
    );

    let emu_dev_type = EmuDeviceType::from_usize(emu_type);
    let emu_dev_cfg = VmEmulatedDeviceConfig {
        name: Some(name_str.trim_end_matches(char::from(0)).to_string()),
        base_ipa,
        length,
        irq_id,
        cfg_list,
        emu_type: match emu_dev_type {
            EmuDeviceType::EmuDeviceTVirtioBlkMediated => EmuDeviceType::EmuDeviceTVirtioBlk,
            _ => emu_dev_type.clone(),
        },
        mediated: match EmuDeviceType::from_usize(emu_type) {
            EmuDeviceType::EmuDeviceTVirtioBlkMediated => true,
            _ => false,
        },
    };
    vm_cfg.add_emulated_device_cfg(emu_dev_cfg);

    // Set GVM Mediated Blk Index Here.
    if emu_dev_type == EmuDeviceType::EmuDeviceTVirtioBlkMediated {
        let med_blk_index = match mediated_blk_request() {
            Ok(idx) => idx,
            Err(_) => {
                println!("no more medaited blk for vm {}", vmid);
                return Err(());
            }
        };
        vm_cfg.set_mediated_block_index(med_blk_index);
    }

    Ok(0)
}

/* Add passthrough device config region for VM */
pub fn vm_cfg_add_passthrough_device_region(
    vmid: usize,
    base_ipa: usize,
    base_pa: usize,
    length: usize,
) -> Result<usize, ()> {
    // Get VM config entry.
    let vm_cfg = match vm_cfg_entry(vmid) {
        Some(vm_cfg) => vm_cfg,
        None => return Err(()),
    };
    // Get passthrough device config list.
    let pt_dev_regions = vm_cfg.passthrough_device_regions();

    println!(
        concat!(
            "\nVM[{}] vm_cfg_add_pt_dev: ori pt dev regions num {}\n",
            "     base_ipa {:x} base_pa {:x} length {:x}"
        ),
        vmid,
        pt_dev_regions.len(),
        base_ipa,
        base_pa,
        length
    );

    vm_cfg.add_passthrough_device_region(base_ipa, base_pa, length);
    Ok(0)
}

/* Add passthrough device config irqs for VM */
pub fn vm_cfg_add_passthrough_device_irqs(vmid: usize, irqs_base_ipa: usize, irqs_length: usize) -> Result<usize, ()> {
    println!(
        "\nVM[{}] vm_cfg_add_pt_dev irqs:\n     base_ipa {:x} length {:x}",
        vmid, irqs_base_ipa, irqs_length
    );

    // Copy passthrough device irqs from user ipa.
    let irqs_base_pa = vm_ipa2pa(active_vm().unwrap(), irqs_base_ipa);
    if irqs_base_pa == 0 {
        println!("illegal irqs_base_ipa {:x}", irqs_base_ipa);
        return Err(());
    }
    let mut irqs = vec![0 as usize, irqs_length];
    if irqs_length > 0 {
        memcpy_safe(
            &irqs[0] as *const _ as *const u8,
            irqs_base_pa as *mut u8,
            irqs_length * 8, // sizeof(usize) / sizeof(u8)
        );
    }
    println!("      irqs {:?}", irqs);

    let vm_cfg = match vm_cfg_entry(vmid) {
        Some(vm_cfg) => vm_cfg,
        None => return Err(()),
    };
    vm_cfg.add_passthrough_device_irqs(&mut irqs);
    Ok(0)
}

/* Add passthrough device config streams ids for VM */
pub fn vm_cfg_add_passthrough_device_streams_ids(
    vmid: usize,
    streams_ids_base_ipa: usize,
    streams_ids_length: usize,
) -> Result<usize, ()> {
    println!(
        "\nVM[{}] vm_cfg_add_pt_dev streams ids:\n     streams_ids_base_ipa {:x} streams_ids_length {:x}",
        vmid, streams_ids_base_ipa, streams_ids_length
    );

    // Copy passthrough device streams ids from user ipa.
    let streams_ids_base_pa = vm_ipa2pa(active_vm().unwrap(), streams_ids_base_ipa);
    if streams_ids_base_pa == 0 {
        println!("illegal streams_ids_base_ipa {:x}", streams_ids_base_ipa);
        return Err(());
    }
    let mut streams_ids = vec![0 as usize, streams_ids_length];
    if streams_ids_length > 0 {
        memcpy_safe(
            &streams_ids[0] as *const _ as *const u8,
            streams_ids_base_pa as *mut u8,
            streams_ids_length * 8, // sizeof(usize) / sizeof(u8)
        );
    }
    println!("      get streams_ids {:?}", streams_ids);

    let vm_cfg = match vm_cfg_entry(vmid) {
        Some(vm_cfg) => vm_cfg,
        None => return Err(()),
    };
    vm_cfg.add_passthrough_device_streams_ids(&mut streams_ids);
    Ok(0)
}

/* Add device tree device config for VM */
pub fn vm_cfg_add_dtb_dev(
    vmid: usize,
    name_ipa: usize,
    dev_type: usize,
    irq_list_ipa: usize,
    irq_list_length: usize,
    addr_region_ipa: usize,
    addr_region_length: usize,
) -> Result<usize, ()> {
    println!(
        "\nVM[{}] vm_cfg_add_dtb_dev:\n     dev_type {} irq_list_length {} addr_region_ipa {:x} addr_region_length {:x}",
        vmid, dev_type, irq_list_length, addr_region_ipa, addr_region_length
    );

    // Copy DTB device name from user ipa.
    let name_pa = vm_ipa2pa(active_vm().unwrap(), name_ipa);
    if name_pa == 0 {
        println!("illegal dtb_dev name ipa {:x}", name_ipa);
        return Err(());
    }
    let dtb_dev_name_u8 = vec![0 as u8; NAME_MAX_LEN];
    memcpy_safe(
        &dtb_dev_name_u8[0] as *const _ as *const u8,
        name_pa as *mut u8,
        NAME_MAX_LEN,
    );
    let dtb_dev_name_str = match String::from_utf8(dtb_dev_name_u8.clone()) {
        Ok(str) => str,
        Err(error) => {
            println!(
                "error: {:?} in parsing the DTB device name {:?}",
                error, dtb_dev_name_u8
            );
            String::from("unknown")
        }
    };
    println!(
        "      get dtb dev name {:?}",
        dtb_dev_name_str.trim_end_matches(char::from(0))
    );

    // Copy DTB device irq list from user ipa.
    let irq_list_pa = vm_ipa2pa(active_vm().unwrap(), irq_list_ipa);
    if irq_list_pa == 0 {
        println!("illegal dtb_dev irq list ipa {:x}", irq_list_ipa);
        return Err(());
    }
    let mut dtb_irq_list: Vec<usize> = Vec::new();

    if irq_list_length > 0 {
        let tmp_dtb_irq_list = vec![0 as usize, irq_list_length];
        memcpy_safe(
            &tmp_dtb_irq_list[0] as *const _ as *const u8,
            irq_list_pa as *mut u8,
            irq_list_length * 8, // sizeof(usize) / sizeof(u8)
        );
        for i in 0..irq_list_length {
            dtb_irq_list.push(tmp_dtb_irq_list[i]);
        }
    }
    println!("      get dtb dev dtb_irq_list {:?}", dtb_irq_list);

    // Get VM config entry.
    let vm_cfg = match vm_cfg_entry(vmid) {
        Some(vm_cfg) => vm_cfg,
        None => return Err(()),
    };
    // Get DTB device config list.
    let vm_dtb_dev = VmDtbDevConfig {
        name: dtb_dev_name_str.trim_end_matches(char::from(0)).to_string(),
        dev_type: DtbDevType::from_usize(dev_type),
        irqs: dtb_irq_list,
        addr_region: AddrRegions {
            ipa: addr_region_ipa,
            length: addr_region_length,
        },
    };

    vm_cfg.add_dtb_device(vm_dtb_dev);

    Ok(0)
}

/**
 * Final Step for GVM configuration.
 * Set up GVM configuration;
 * Set VM kernel image load region;
 */
fn vm_cfg_finish_configuration(vmid: usize, img_size: usize) -> Vm {
    // Set up GVM configuration.
    vmm_init_gvm(vmid);

    // Get VM structure.
    let vm = match vm(vmid) {
        None => {
            panic!("vm_cfg_upload_kernel_image:failed to init VM[{}]", vmid);
        }
        Some(vm) => vm,
    };

    let mut config = vm.config();
    let load_ipa = config.kernel_load_ipa();

    // Find actual physical memory region according to kernel image ipa.
    for (idx, region) in config.memory_region().iter().enumerate() {
        if load_ipa < region.ipa_start || load_ipa + img_size > region.ipa_start + region.length {
            continue;
        }
        let offset = load_ipa - region.ipa_start;
        println!(
            "VM [{}] {} kernel image region: ipa=<0x{:x}>, pa=<0x{:x}>, img_size=<{}KB>",
            vm.id(),
            config.vm_name(),
            load_ipa,
            vm.pa_start(idx) + offset,
            img_size / 1024
        );
        config.set_kernel_load_pa(vm.pa_start(idx) + offset);
    }
    vm
}

/**
 * Load kernel image file from MVM user space.
 * It's the last step in GVM configuration.
 */
pub fn vm_cfg_upload_kernel_image(
    vmid: usize,
    img_size: usize,
    cache_ipa: usize,
    load_offset: usize,
    load_size: usize,
) -> Result<usize, ()> {
    // Before upload kernel image, set GVM.
    let vm = match vm(vmid) {
        None => {
            println!(
                "\nSuccessfully add configuration file for VM [{}]\nStart to init...",
                vmid
            );
            // This code should only run once.
            vm_cfg_finish_configuration(vmid, img_size)
        }
        Some(vm) => vm,
    };
    let config = vm.config();

    println!(
        "VM[{}] Upload kernel image. cache_ipa:{:x} load_offset:{:x} load_size:{:x}",
        vmid, cache_ipa, load_offset, load_size
    );
    // Get cache pa.
    let cache_pa = vm_ipa2pa(active_vm().unwrap(), cache_ipa);
    if cache_pa == 0 {
        println!("illegal cache ipa {:x}", cache_ipa);
        return Err(());
    }
    let src = unsafe { core::slice::from_raw_parts_mut((cache_pa) as *mut u8, load_size) };

    // Get kernel image load pa.
    let load_pa = config.kernel_load_pa();
    if load_pa == 0 {
        println!(
            "vm_cfg_upload_kernel_image: failed to get kernel image load pa of VM[{}]",
            vmid
        );
        return Err(());
    }
    // Copy from user space.
    let dst = unsafe { core::slice::from_raw_parts_mut((load_pa + load_offset) as *mut u8, load_size) };
    dst.copy_from_slice(src);
    Ok(0)
}
