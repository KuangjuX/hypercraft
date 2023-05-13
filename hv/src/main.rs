#![no_std]
#![no_main]

extern crate alloc;

use libax::hv::{
    self, GuestPageTable, GuestPageTableTrait, HyperCallMsg, HyperCraftHalImpl, PerCpu, Result,
    VCpu, VmCpus, VmExitInfo, VM,
};
use page_table_entry::MappingFlags;

/// guest code: print hello world!
unsafe extern "C" fn hello_world() {
    libax::println!("Hello guest!");
}

#[no_mangle]
fn main(hart_id: usize) {
    libax::println!("Hello, hv!");

    // boot cpu
    PerCpu::<HyperCraftHalImpl>::init(0, 0x4000);

    // get current percpu
    let pcpu = PerCpu::<HyperCraftHalImpl>::this_cpu();

    // create vcpu
    // let vcpu = hv::create_vcpu(pcpu, 0x9000_0000, 0).unwrap();
    // let gpt = GuestPageTable::new().unwrap();
    let gpt = setup_gpm().unwrap();
    let vcpu = pcpu
        .create_vcpu::<GuestPageTable>(0, 0x9000_0000, gpt)
        .unwrap();
    let mut vcpus = VmCpus::new();

    // add vcpu into vm
    vcpus.add_vcpu(vcpu).unwrap();
    let mut vm = VM::new(vcpus).unwrap();

    // vm run
    libax::info!("vm run cpu{}", hart_id);
    vm.run(0);
}

pub fn setup_gpm() -> Result<GuestPageTable> {
    let mut gpt = GuestPageTable::new()?;
    gpt.map_region(
        0x9000_0000,
        0x9000_0000,
        0x800_0000,
        MappingFlags::READ | MappingFlags::WRITE | MappingFlags::EXECUTE | MappingFlags::USER,
    )?;
    Ok(gpt)
}
