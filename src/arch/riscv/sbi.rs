use crate::{HyperError, HyperResult};

/// SBI Message used to invoke the specfified SBI extension in the firmware.
#[derive(Clone, Copy, Debug)]
pub struct SbiMessage {
    /// SBI extension ID.
    pub extension: usize,
    /// SBI function ID, if applicable.
    pub function: usize,
    /// SBI parameters.
    pub params: [usize; 6],
}

impl SbiMessage {
    /// Creates an SbiMessage struct from the given GPRs. Intended for use from the ECALL handler
    /// and passed the saved register state from the calling OS. A7 must contain a valid SBI
    /// extension and the other A* registers will be interpreted based on the extension A7 selects.
    pub fn from_regs(args: &[usize]) -> Self {
        SbiMessage {
            extension: args[7],
            function: args[6],
            params: [args[0], args[1], args[2], args[3], args[4], args[5]],
        }
    }
}
