mod dbcn;
mod srst;

use crate::{HyperError, HyperResult};
use dbcn::DebugConsoleFunction;
use sbi_spec;
use srst::ResetFunction;

/// SBI Message used to invoke the specfified SBI extension in the firmware.
#[derive(Clone, Copy, Debug)]
pub enum SbiMessage {
    /// The legacy PutChar extension.
    PutChar(usize),
    /// The SetTimer Extension
    SetTimer(usize),
    /// Handles output to the console for debug
    DebugConsole(DebugConsoleFunction),
    /// Handles system reset
    Reset(ResetFunction),
}

impl SbiMessage {
    /// Creates an SbiMessage struct from the given GPRs. Intended for use from the ECALL handler
    /// and passed the saved register state from the calling OS. A7 must contain a valid SBI
    /// extension and the other A* registers will be interpreted based on the extension A7 selects.
    pub fn from_regs(args: &[usize]) -> HyperResult<Self> {
        match args[7] {
            sbi_spec::legacy::LEGACY_CONSOLE_PUTCHAR => Ok(SbiMessage::PutChar(args[0])),
            // sbi_spec::legacy::LEGACY_SET_TIMER => Ok(SbiMessage::SetTimer(args[0])),
            sbi_spec::time::EID_TIME => Ok(SbiMessage::SetTimer(args[0])),
            sbi_spec::srst::EID_SRST => ResetFunction::from_regs(args).map(SbiMessage::Reset),
            _ => Err(HyperError::NotFound),
        }
    }
}
