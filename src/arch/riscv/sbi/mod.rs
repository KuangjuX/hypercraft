mod dbcn;
mod srst;

use crate::{HyperError, HyperResult};
use dbcn::DebugConsoleFunction;
use sbi_spec;
use srst::ResetFunction;

/// The values returned from an SBI function call.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct SbiReturn {
    /// The error code(0 for success)
    pub error_code: i64,
    /// The return value if the operation is successful
    pub return_value: i64,
}

/// SBI return value conventions
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum SbiReturnTyoe {
    /// Legacy(v0.1) extensions return a single value in A0, usually with the convention that 0
    /// is success and < 0 is an implementation defined error code.
    Legacy(u64),
    /// Modern extensions use the standard error code values enumerated above.
    Standard(SbiReturn),
}

/// SBI Message used to invoke the specfified SBI extension in the firmware.
#[derive(Clone, Copy, Debug)]
pub enum SbiMessage {
    /// The legacy GetChar extension.
    GetChar,
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
            sbi_spec::legacy::LEGACY_CONSOLE_GETCHAR => Ok(SbiMessage::GetChar),
            sbi_spec::legacy::LEGACY_SET_TIMER => Ok(SbiMessage::SetTimer(args[0])),
            sbi_spec::time::EID_TIME => Ok(SbiMessage::SetTimer(args[0])),
            sbi_spec::srst::EID_SRST => ResetFunction::from_regs(args).map(SbiMessage::Reset),
            _ => {
                error!("args: {:?}", args);
                Err(HyperError::NotFound)
            }
        }
    }
}
