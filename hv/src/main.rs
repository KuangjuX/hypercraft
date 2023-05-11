#![no_std]
#![no_main]

extern crate alloc;

use libax::hv::{self, HyperCallMsg, HyperCraftHalImpl, PerCpu, VCpu, VmCpus, VmExitInfo, VM};

/// guest code: print hello world!
unsafe extern "C" fn hello_world() {
    libax::println!("Hello guest!");
}

#[no_mangle]
fn main() {
    libax::println!("Hello, hv!");

    // boot cpu
    PerCpu::<HyperCraftHalImpl>::init(0, 0x4000);

    // get current percpu
    let pcpu = PerCpu::<HyperCraftHalImpl>::this_cpu();

    // create vcpu
    // let vcpu = hv::create_vcpu(pcpu, 0x9000_0000, 0).unwrap();
    let vcpu = pcpu.create_vcpu(0x9000_0000, 0).unwrap();
    let mut vcpus = VmCpus::new();

    // add vcpu into vm
    vcpus.add_vcpu(vcpu).unwrap();
    let mut vm = VM::new(vcpus).unwrap();

    // vm run
    libax::info!("vm run cpu 0");
    vm.run(0);
}
