// Main file for Raspberry Pi emulator

import IO

// Sample program to turn on OK led
// 00008000 <_start>:
//     8000:	e59f0018 	ldr	r0, [pc, #24]	; 8020 <loop$+0x4>
//     8004:	e3a01001 	mov	r1, #1
//     8008:	e1a01901 	lsl	r1, r1, #18
//     800c:	e5801004 	str	r1, [r0, #4]
//     8010:	e3a01001 	mov	r1, #1
//     8014:	e1a01801 	lsl	r1, r1, #16
//     8018:	e5801028 	str	r1, [r0, #40]	; 0x28

// 0000801c <loop$>:
//     801c:	eafffffe 	b	801c <loop$>
//     8020:	20200000 	.word	0x20200000

type Address UInt32

// Amount of memory in bytes
const memorySize      = 1024 * 64
const memorySizeWords = memorySize >> 2

type RaspberryPi struct {
    cpu:    Cpu
    soc:    SoC
    memory: [memorySizeWords]Word
}

func RaspberryPi() -> *RaspberryPi {
    pi := new RaspberryPi
    pi.cpu = Cpu(pi)
    return pi
}

const memStart = 0x8000

func RaspberryPi.PowerOn() {
    // Read file kernel.img into memory at the appropriate position
    file := IO.OpenFile("kernel.img", FileMode.Open, FileAccess.Read)
    defer file.Close()

    const bufferSize = 1024            // Read file in 1K chunks
    var bytes: [bufferSize]Byte

    var addr: Address = 0
    moreToRead := true

    while moreToRead {
        numBytesRead, error := file.Read(bytes, bufferSize)
        i := 0

        while i < numBytesRead {
            value := Word(bytes[i]) | Word(bytes[i+1] << 8) | Word(bytes[i + 2] << 16) | Word(bytes[i+3] << 24)
            self.memory[addr] = value
            addr += 1
            i += 4
        }
    }
}

func RaspberryPi.ReadWord(addr: Address) -> Word {
    if addr > memorySize - 1 {
        Assert(false)
    }

    return self.memory[addr >> 2]                      // addr is in bytes so need the word address
}

func RaspberryPi.WriteWord(addr: Address, value: Word) {
    if addr > memorySize - 1 {
        Assert(false)
    }

    self.memory[addr >> 2] = value
}

func main() -> Int32 {
    pi := RaspberryPi()
    pi.PowerOn()

    pi.cpu.PrintRegisters()

    // Execute a single instruction
    pi.cpu.ExecuteInstruction()

    pi.cpu.ExecuteInstruction()
    pi.cpu.ExecuteInstruction()
    pi.cpu.ExecuteInstruction()
    pi.cpu.ExecuteInstruction()
    pi.cpu.ExecuteInstruction()
    pi.cpu.ExecuteInstruction()
    
    pi.cpu.PrintRegisters()
    return 0
}