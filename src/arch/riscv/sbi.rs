/// SBI Message used to invoke the specfified SBI extension in the firmware.
#[derive(Clone, Copy, Debug)]
pub enum SbiMessage {
    /// The legacy PutChar extension.
    PutChar(u64),
    /// Handles output to the console for debug
    DebugConsole(DebugConsoleFunction),
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
