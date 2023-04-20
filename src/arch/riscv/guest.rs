use crate::GuestPhysMemorySetTrait;
use crate::HyperResult;
use alloc::sync::Arc;
/// Represents a guest within the hypervisor
pub struct Guest {
    pub(super) gpm: Arc<dyn GuestPhysMemorySetTrait>,
}

impl Guest {
    pub fn new(gpm: Arc<dyn GuestPhysMemorySetTrait>) -> HyperResult<Arc<Self>> {
        Ok(Arc::new(Self { gpm }))
    }
}
