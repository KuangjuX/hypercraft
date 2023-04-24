use crate::{HyperCraftHal, HyperResult};

use super::VmCpus;

/// A VM that is being run.
pub struct VM<H: HyperCraftHal> {
    vcpus: VmCpus<H>,
}

impl<H: HyperCraftHal> VM<H> {
    pub fn new(vcpus: VmCpus<H>) -> HyperResult<Self> {
        Ok(Self { vcpus })
    }
}
