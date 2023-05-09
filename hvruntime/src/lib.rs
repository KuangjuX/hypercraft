#![no_std]

use axlog::ax_println;

#[macro_use]
extern crate axlog;

mod lang_items;
mod trap;

extern "C" {
    fn ekernel();
}

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
        // #[cfg(feature = "smp")]
        // if is_init_ok() {
        //     Some(axhal::cpu::this_cpu_id())
        // } else {
        //     None
        // }
        // #[cfg(not(feature = "smp"))]
        // Some(0)
        None
    }

    fn current_task_id() -> Option<u64> {
        // if is_init_ok() {
        //     #[cfg(feature = "multitask")]
        //     {
        //         axtask::current_may_uninit().map(|curr| curr.id().as_u64())
        //     }
        //     #[cfg(not(feature = "multitask"))]
        //     None
        // } else {
        //     None
        // }
        None
    }
}

pub const MEMORY_END: usize = 0x8800_0000;

extern "C" {
    fn main();
}

#[no_mangle]
pub extern "C" fn rust_main(cpu_id: usize, dtb: usize) -> ! {
    ax_println!("rust_main! cpu_id={}, dtb={:#x}", cpu_id, dtb);

    #[cfg(feature = "alloc")]
    init_allocator();

    unsafe {
        main();
    }

    unreachable!()
}

#[cfg(feature = "alloc")]
fn init_allocator() {
    axalloc::global_init(ekernel as usize, MEMORY_END - ekernel as usize);
}
