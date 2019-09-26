////////////////////////////////////////////////////////
//
// Simple Hello World program for Phobos and RaspberryPi
//
// (c) 2019 Mark A Jackson
//
////////////////////////////////////////////////////////

const MAILBOX_STATUS_ADDRESS = 0x2000B898

func MailboxWrite(mailbox: UInt32, message: UInt32) {
    // Ensure arguments are valid
    if mailbox <= 0b1111 && message <= 0x0FFFFFFF {
        
    } else {
        // Arguments invalid
    }
}