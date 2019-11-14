////////////////////////////////////////////////////////
//
// Simple Hello World program for Phobos and RaspberryPi
//
// (c) 2019 Mark A Jackson
//
////////////////////////////////////////////////////////

// General errors
const ERROR_NONE         = 0
const ERROR_INVALID_ARGS = 1

const MAILBOX_READ_ADDRESS   = 0x2000B880u
const MAILBOX_STATUS_ADDRESS = 0x2000B898u
const MAILBOX_WRITE_ADDRESS  = 0x2000B8A0u

// Bit 31 set in status register if write mailbox is full
const MAILBOX_FULL  = 0x80000000u

// Bit 30 set in status register if read mailbox is empty
const MAILBOX_EMPTY = 0x40000000u

func MailboxRead(mailbox: UInt32) -> (message, error: UInt32) {
    if mailbox <= 0b1111 {
        readMessage := false
        
        while !readMessage {
            status := ReadMemory(MAILBOX_STATUS_ADDRESS)
        
            while (status & MAILBOX_EMPTY) != 0 {
                status = ReadMemory(MAILBOX_STATUS_ADDRESS)
            }
        
            message := ReadMemory(MAILBOX_READ_ADDRESS)
            
            if (message & 0b1111) == mailbox {
                readMessage = true
            }
        }
        
        message &= 0xFFFFFFF0
        error = ERROR_NONE
    } else {
        // Arguments invalid
        error = ERROR_INVALID_ARGS;
    }

    return
}

func MailboxWrite(mailbox, message: UInt32) -> error: UInt32 {
    // Ensure arguments are valid
    if mailbox <= 0b1111 && message >= 0b10000 {
        status := ReadMemory(MAILBOX_STATUS_ADDRESS)
        
        while (status & MAILBOX_FULL) != 0 {
            status = ReadMemory(MAILBOX_STATUS_ADDRESS)
        }
        
        value := message | mailbox
        WriteMemory(MAILBOX_WRITE_ADDRESS, value)
        error = ERROR_NONE
    } else {
        // Arguments invalid
        error = ERROR_INVALID_ARGS;
    }

    return
}

@align(16)
type FrameBufferInfo struct {
    physicalWidth:  UInt32
    physicalHeight: UInt32
    virtualWidth:   UInt32
    virtualHeight:  UInt32
    pitch:          UInt32
    bitDepth:       UInt32
    x:              UInt32
    y:              UInt32
    frameBuffer:    ^UInt32
    bufferSize:     UInt32
}

func main() {
    fbi := FrameBuffer {
        physicalWidth = 1920,
        physicalHeight = 1080,
        virtualWidth = 1920,
        virtualHeight = 1080,
        bitDepth = 32,
        x = 0,
        y = 0
    }
    
    response := WriteMailbox(1, &fbi + 0x40000000)      // Add 0x40000000 to fbi address to tell GPU not to use cache
    
    if response == 0 {
        var colour: UInt32 = 0
        var pos: UInt32 = 0
        
        while pos < fbi.bufferSize {
            WriteMemory(frameBuffer + pos, colour)
            colour += 1
            
            if colour > 0xFFFFFFF {
                colour = 0
            }
        }
    } else {
        // Invalid FrameBufferInfo
    }
    
    while true {
    }
}
