mod platform_common;
mod platform_qemu;

pub use platform_common::*;
pub use platform_qemu::{PLAT_DESC, QemuPlatform};