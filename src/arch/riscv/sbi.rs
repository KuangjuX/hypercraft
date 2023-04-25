use crate::{HyperError, HyperResult};
use sbi_spec::legacy;

/// SBI Message used to invoke the specfified SBI extension in the firmware.
#[derive(Clone, Copy, Debug)]
pub enum SbiMessage {
    /// The legacy PutChar extension.
    PutChar(usize),
    /// Handles output to the console for debug
    DebugConsole(DebugConsoleFunction),
}

impl SbiMessage {
    /// Creates an SbiMessage struct from the given GPRs. Intended for use from the ECALL handler
    /// and passed the saved register state from the calling OS. A7 must contain a valid SBI
    /// extension and the other A* registers will be interpreted based on the extension A7 selects.
    pub fn from_regs(args: &[usize]) -> HyperResult<Self> {
        match args[7] {
            legacy::LEGACY_CONSOLE_PUTCHAR => Ok(SbiMessage::PutChar(args[0])),
            _ => Err(HyperError::NotFound),
        }
    }
}

/// Functions for the Debug Console extension
#[derive(Copy, Clone, Debug)]
pub enum DebugConsoleFunction {
    /// Prints the given string to the system console.
    PutString {
        /// The length of the string to print.
        len: u64,
        /// The address of the string.
        addr: u64,
    },
}
