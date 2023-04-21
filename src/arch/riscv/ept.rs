use crate::{GuestPageTable, HostPageNum, HyperCraftHal};

#[derive(Debug)]
pub struct GuestPageTableSv39 {
    root_ppn: HostPageNum,
}

impl<H: HyperCraftHal> GuestPageTable<H> for GuestPageTableSv39 {
    fn new() -> Self {
        Self {
            root_ppn: H::alloc_16_page().unwrap(),
        }
    }

    fn map(
        &mut self,
        _gpa: crate::GuestPhysAddr,
        _hpa: crate::HostPhysAddr,
        _flags: impl crate::memory::IntoRvmPageTableFlags,
    ) -> crate::HyperResult {
        todo!()
    }

    fn unmap(&mut self, _gpa: crate::GuestPhysAddr) -> crate::HyperResult {
        todo!()
    }

    fn translate(&self, _gpa: crate::GuestPhysAddr) -> crate::HyperResult<crate::HostPhysAddr> {
        todo!()
    }

    fn token(&self) -> usize {
        todo!()
    }
}
