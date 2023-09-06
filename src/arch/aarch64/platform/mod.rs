mod platform_common;
mod platform_qemu;

pub use self::platform_common::*;
pub use platform_qemu::{PLAT_DESC, QemuPlatform};