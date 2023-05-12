#![no_std]
#![deny(warnings)]
#![allow(clippy::if_same_then_else)]
#![feature(stmt_expr_attributes)]
use axlog::ax_println;

#[macro_use]
extern crate axlog;

mod gpm;
mod hv;
mod lang_items;
mod trap;

pub use gpm::GuestPageTable;
pub use hv::HyperCraftHalImpl;

extern "C" {
    fn ekernel();
}

extern crate alloc;

struct LogIfImpl;

#[crate_interface::impl_interface]
impl axlog::LogIf for LogIfImpl {
    fn console_write_str(s: &str) {
        axhal::console::write_bytes(s.as_bytes());
    }

    fn current_time() -> core::time::Duration {
        axhal::time::current_time()
    }

    fn current_cpu_id() -> Option<usize> {
        #[cfg(feature = "smp")]
        if is_init_ok() {
            Some(axhal::cpu::this_cpu_id())
        } else {
            None
        }
        #[cfg(not(feature = "smp"))]
        Some(0)
    }

    fn current_task_id() -> Option<u64> {
        if is_init_ok() {
            #[cfg(feature = "multitask")]
            {
                axtask::current_may_uninit().map(|curr| curr.id().as_u64())
            }
            #[cfg(not(feature = "multitask"))]
            None
        } else {
            None
        }
    }
}

// pub const MEMORY_END: usize = 0x8800_0000;

use core::sync::atomic::{AtomicUsize, Ordering};

static INITED_CPUS: AtomicUsize = AtomicUsize::new(0);

fn is_init_ok() -> bool {
    INITED_CPUS.load(Ordering::Acquire) == axconfig::SMP
}

extern "C" {
    fn main();
}

#[no_mangle]
pub extern "C" fn rust_main(cpu_id: usize, dtb: usize) {
    ax_println!("rust_main! cpu_id={}, dtb={:#x}", cpu_id, dtb);

    axlog::init();
    axlog::set_max_level(option_env!("LOG").unwrap_or(""));
    info!("Logging is enabled");
    #[cfg(feature = "alloc")]
    {
        info!("Initialize allocator");
        init_allocator();
    }

    unsafe {
        main();
    }
    panic!("main returned");
}

#[cfg(feature = "alloc")]
fn init_allocator() {
    use axhal::mem::phys_to_virt;
    axalloc::global_init(
        ekernel as usize,
        (phys_to_virt(0x9000_0000.into()) - ekernel as usize).into(),
    );
}

// fn setup_gpm() {}
