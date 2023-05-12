use axhal::mem::{PhysAddr, VirtAddr};
use hypercraft::{GuestPageTableTrait, GuestPhysAddr, HyperError, HyperResult, NestedPageTable};

use page_table_entry::MappingFlags;

pub type GuestPagingIfImpl = axhal::paging::PagingIfImpl;
// pub type GuestPageTable = NestedPageTable<GuestPagingIfImpl>;
pub struct GuestPageTable(NestedPageTable<GuestPagingIfImpl>);

// pub struct GuestMemoryRegion {
//     pub gpa: guestPhysAddr,
//     pub hpa: HostPhysAddr,
//     pub size: usize,
//     pub flags: MemRegionFlags,
// }

// #[cfg(target_arch = "riscv64")]
// #[crate_interface::impl_interface]
// impl IntoHyperPageTableFlags for PTEFlags {
//     fn is_read(&self) -> bool {
//         self.contains(PTEFlags::R)
//     }

//     fn is_write(&self) -> bool {
//         self.contains(PTEFlags::W)
//     }

//     fn is_execute(&self) -> bool {
//         self.contains(PTEFlags::X)
//     }

//     fn is_user(&self) -> bool {
//         self.contains(PTEFlags::U)
//     }
// }

// #[crate_interface::impl_interface]
// impl IntoHyperPageTableFlags for MappingFlags {
//     fn is_read(&self) -> bool {
//         self.contains(MappingFlags::READ)
//     }

//     fn is_write(&self) -> bool {
//         self.contains(MappingFlags::WRITE)
//     }

//     fn is_execute(&self) -> bool {
//         self.contains(MappingFlags::EXECUTE)
//     }

//     fn is_user(&self) -> bool {
//         self.contains(MappingFlags::USER)
//     }
// }

// pub struct GuestPhysMemorySet {
//     regions: BTreeMap<GuestPhysAddr, GuestMemoryRegion>,
//     npt: GuestPageTable,
// }

impl GuestPageTableTrait for GuestPageTable {
    fn new() -> HyperResult<Self> {
        let npt = NestedPageTable::<GuestPagingIfImpl>::try_new_gpt()
            .map_err(|_| HyperError::NoMemory)?;
        Ok(GuestPageTable(npt))
    }

    fn map(
        &mut self,
        gpa: GuestPhysAddr,
        hpa: hypercraft::HostPhysAddr,
        flags: MappingFlags,
    ) -> HyperResult<()> {
        self.0
            .map(
                VirtAddr::from(gpa),
                PhysAddr::from(hpa),
                page_table::PageSize::Size4K,
                flags,
            )
            .map_err(|paging_err| {
                error!("paging error: {:?}", paging_err);
                HyperError::Internal
            })?;
        Ok(())
    }

    fn map_region(
        &mut self,
        gpa: GuestPhysAddr,
        hpa: hypercraft::HostPhysAddr,
        size: usize,
        flags: MappingFlags,
    ) -> HyperResult<()> {
        self.0
            .map_region(VirtAddr::from(gpa), PhysAddr::from(hpa), size, flags, false)
            .map_err(|err| {
                error!("paging error: {:?}", err);
                HyperError::Internal
            })?;
        Ok(())
    }

    fn unmap(&mut self, gpa: GuestPhysAddr) -> HyperResult<()> {
        let (_, _) = self.0.unmap(VirtAddr::from(gpa)).map_err(|paging_err| {
            error!("paging error: {:?}", paging_err);
            return HyperError::Internal;
        })?;
        Ok(())
    }

    fn translate(&self, gpa: GuestPhysAddr) -> HyperResult<hypercraft::HostPhysAddr> {
        let (addr, _, _) = self.0.query(VirtAddr::from(gpa)).map_err(|paging_err| {
            error!("paging error: {:?}", paging_err);
            HyperError::Internal
        })?;
        Ok(addr.into())
    }

    fn token(&self) -> usize {
        #[cfg(target_arch = "riscv64")]
        8usize
            << 60
            | usize::from(self.0.root_paddr()) >> 12
    }
}
