use alloc::vec::Vec;

use spin::Mutex;

use arm_gic::SGI_RANGE;
use crate::arch::cpu::CPU_INTERFACE_LIST;
use crate::arch::manageVm::VmmEvent;
use crate::arch::vm::Vm;
use crate::arch::{GICD, current_cpu};

const IPI_IRQ_NUM: usize = 1;

#[derive(Copy, Clone, Debug)]
pub enum InitcEvent {
    VgicdGichEn,
    VgicdSetEn,
    VgicdSetAct,
    VgicdSetPend,
    VgicdSetPrio,
    VgicdSetTrgt,
    VgicdSetCfg,
    VgicdRoute,
    None,
}

#[derive(Copy, Clone)]
pub enum PowerEvent {
    PsciIpiCpuOn,
    PsciIpiCpuOff,
    PsciIpiCpuReset,
}

#[derive(Copy, Clone)]
pub struct IpiInitcMessage {
    pub event: InitcEvent,
    pub vm_id: usize,
    pub int_id: u16,
    pub val: u8,
}

#[derive(Copy, Clone)]
pub struct IpiPowerMessage {
    pub src: usize,
    pub event: PowerEvent,
    pub entry: usize,
    pub context: usize,
}

#[derive(Copy, Clone)]
pub struct IpiVmmMsg {
    pub vmid: usize,
    pub event: VmmEvent,
}

#[derive(Clone, Copy)]
pub struct IpiHvcMsg {
    pub src_vmid: usize,
    pub trgt_vmid: usize,
    pub fid: usize,
    pub event: usize,
}

#[derive(Clone, Copy)]
pub struct IpiIntInjectMsg {
    pub vm_id: usize,
    pub int_id: usize,
}

#[derive(Copy, Clone, Debug)]
pub enum IpiType {
    IpiTIntc = 0,
    IpiTPower = 1,
    IpiTHvc = 4,
    IpiTVMM = 5,
    IpiTIntInject = 8,
}

#[derive(Clone)]
pub enum IpiInnerMsg {
    Initc(IpiInitcMessage),
    Power(IpiPowerMessage),
    VmmMsg(IpiVmmMsg),
    HvcMsg(IpiHvcMsg),
    IntInjectMsg(IpiIntInjectMsg),
    None,
}

pub struct IpiMessage {
    pub ipi_type: IpiType,
    pub ipi_message: IpiInnerMsg,
}

const IPI_HANDLER_MAX: usize = 16;

pub type IpiHandlerFunc = fn(&IpiMessage);

pub struct IpiHandler {
    pub handler: IpiHandlerFunc,
    pub ipi_type: IpiType,
}

impl IpiHandler {
    fn new(handler: IpiHandlerFunc, ipi_type: IpiType) -> IpiHandler {
        IpiHandler { handler, ipi_type }
    }
}

pub static IPI_HANDLER_LIST: Mutex<Vec<IpiHandler>> = Mutex::new(Vec::new());

pub fn ipi_irq_handler() {
    // println!("ipi handler");
    let cpu_id = current_cpu().cpu_id;
    let mut cpu_if_list = CPU_INTERFACE_LIST.lock();
    let mut msg: Option<IpiMessage> = cpu_if_list[cpu_id].pop();
    drop(cpu_if_list);

    while !msg.is_none() {
        let ipi_msg = msg.unwrap();
        let ipi_type = ipi_msg.ipi_type as usize;

        let ipi_handler_list = IPI_HANDLER_LIST.lock();
        let len = ipi_handler_list.len();
        let handler = ipi_handler_list[ipi_type].handler.clone();
        drop(ipi_handler_list);

        if len <= ipi_type {
            info!("illegal ipi type {}", ipi_type);
        } else {
            // println!("ipi type is {:#?}", ipi_msg.ipi_type);
            handler(&ipi_msg);
        }
        let mut cpu_if_list = CPU_INTERFACE_LIST.lock();
        msg = cpu_if_list[cpu_id].pop();
    }
}

pub fn ipi_register(ipi_type: IpiType, handler: IpiHandlerFunc) -> bool {
    // check handler max
    let mut ipi_handler_list = IPI_HANDLER_LIST.lock();
    for i in 0..ipi_handler_list.len() {
        if ipi_type as usize == ipi_handler_list[i].ipi_type as usize {
            info!("ipi_register: try to cover exist ipi handler");
            return false;
        }
    }

    while (ipi_type as usize) >= ipi_handler_list.len() {
        ipi_handler_list.push(IpiHandler::new(handler, ipi_type));
    }
    ipi_handler_list[ipi_type as usize] = IpiHandler::new(handler, ipi_type);
    // ipi_handler_list.push(IpiHandler::new(handler, ipi_type));
    true
}

fn ipi_send(target_id: usize, msg: IpiMessage) -> bool {
    // The qemu max cpu num is 4
    if target_id >= 4 {
        info!("ipi_send: core {} not exist", target_id);
        return false;
    }

    let mut cpu_if_list = CPU_INTERFACE_LIST.lock();
    cpu_if_list[target_id].msg_queue.push(msg);
    if let Some(gicd) = GICD {
        gicd.set_sgi(target_id, IPI_IRQ_NUM);
    } else {
        warn!("No available gicd in ")
    }

    true
}

pub fn ipi_send_msg(target_id: usize, ipi_type: IpiType, ipi_message: IpiInnerMsg) -> bool {
    let msg = IpiMessage { ipi_type, ipi_message };
    ipi_send(target_id, msg)
}

pub fn ipi_intra_broadcast_msg(vm: Vm, ipi_type: IpiType, msg: IpiInnerMsg) -> bool {
    let mut i = 0;
    let mut n = 0;
    while n < (vm.cpu_num() - 1) {
        if ((1 << i) & vm.ncpu()) != 0 && i != current_cpu().cpu_id {
            n += 1;
            if !ipi_send_msg(i, ipi_type, msg.clone()) {
                info!(
                    "ipi_intra_broadcast_msg: Failed to send ipi request, cpu {} type {}",
                    i, ipi_type as usize
                );
                return false;
            }
        }

        i += 1;
    }
    true
}
