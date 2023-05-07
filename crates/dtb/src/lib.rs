#![no_std]
use fdt_rs::{
    base::{DevTree, DevTreeNode, DevTreeProp},
    prelude::{FallibleIterator, PropReader},
};
use lazy_init::LazyInit;

static TREE: LazyInit<DevTree> = LazyInit::new();
/// # Safety
///
/// Callers of this method the must guarantee the following:
///
/// - The passed address is 32-bit aligned.
pub unsafe fn init(dtb: *const u8) {
    TREE.init_by(DevTree::from_raw_pointer(dtb).unwrap());
}
pub struct DeviceNode<'a>(DevTreeNode<'a, 'static>);
pub struct DeviceProp<'a>(DevTreeProp<'a, 'static>);
impl<'a> DeviceNode<'a> {
    pub fn find_prop(&'a self, name: &str) -> Option<DeviceProp<'a>> {
        self.0
            .props()
            .filter(|p| p.name().map(|s| s == name))
            .next()
            .unwrap()
            .map(DeviceProp)
    }
    pub fn prop(&'a self, name: &str) -> DeviceProp<'a> {
        self.find_prop(name).unwrap()
    }
}
impl<'a> DeviceProp<'a> {
    pub fn u32(&self, index: usize) -> u32 {
        self.0.u32(index).unwrap()
    }
    pub fn u64(&self, index: usize) -> u64 {
        self.0.u64(index).unwrap()
    }
    pub fn str(&self) -> &'static str {
        self.0.str().unwrap()
    }
}
pub fn compatible_node(compatible: &str) -> Option<DeviceNode> {
    TREE.compatible_nodes(compatible)
        .next()
        .unwrap()
        .map(DeviceNode)
}
pub fn get_node(name: &str) -> Option<DeviceNode> {
    TREE.nodes()
        .filter(|n| n.name().map(|s| s == name))
        .next()
        .unwrap()
        .map(DeviceNode)
}
pub fn devices<F>(device_type: &str, f: F)
where
    F: Fn(DeviceNode),
{
    TREE.nodes()
        .filter_map(|n| {
            let n = DeviceNode(n);
            Ok(
                if n.find_prop("device_type").map(|p| p.str()) == Some(device_type) {
                    Some(n)
                } else {
                    None
                },
            )
        })
        .for_each(|n| {
            f(n);
            Ok(())
        })
        .unwrap();
}
pub fn compatible_nodes<F, T>(compatible: &str, f: F) -> Option<(T, DeviceNode)>
where
    F: Fn(&DeviceNode) -> Option<T>,
{
    TREE.compatible_nodes(compatible)
        .filter_map(|n| {
            let n = DeviceNode(n);
            Ok(f(&n).map(|t| (t, n)))
        })
        .next()
        .unwrap()
}
