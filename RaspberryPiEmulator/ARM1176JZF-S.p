// CPU used in Raspberry Pi Model B+

type Word UInt32
type Register UInt32               // 0 - 15

type ProcessorMode enum {
    User = 0b10000
    FIQ = 0b10001
    IRQ = 0b10010
    Supervisor = 0b10011
    Abort = 0b10111
    Undefined = 0b11011
    System = 0b11111
}

type Cpu struct {
    mode:       ProcessorMode
    registers:  [31]Word

    pi:         *RaspberryPi
}

// Named registers
const PC: Word = 15
const LR: Word = 14
const SP: Word = 13

func Cpu(pi: *RaspberryPi) -> Cpu {
    return Cpu { mode = ProcessorMode.System, pi = pi }
}

func Cpu.ReadRegister(reg: Register) -> Word {
    if self.mode == ProcessorMode.User || self.mode == ProcessorMode.System {
        return self.registers[reg]
    } else {
        Assert(false)
    }

    return 0
}

func Cpu.WriteRegister(reg: Register, value: Word) {
    Print("Writing: ")
    Print(String(value))
    Print(" to register: ")
    Println(String(reg))

    if self.mode == ProcessorMode.User || self.mode == ProcessorMode.System {
        self.registers[reg] = value
    } else {
        Assert(false)
    }
}

func Cpu.PrintRegisters() {
    const numRegisters = 16
    reg := 0

    while reg < numRegisters {
        if reg < 10 {
            Print(" ")
        }

        Print(String(reg))
        Print(": 0x")
        PrintHex(self.ReadRegister(reg))
        
        if reg == 3 || reg == 7 || reg == 11 || reg == 15 {
            Println("")
        } else {
            Print("   ")
        }

        reg += 1
    }
}

func Cpu.FetchInstruction() -> Word {
    return self.pi.ReadWord(self.ReadRegister(PC))
}

func Cpu.CheckExecuteInstruction(instruction: Word) -> Bool {
    return true
}

const registerMask = 0b1111

const dataProcessingMask = 0b11 << 26
const dataProcessingImmediateMask = 1 << 25
const dataProcessingLslMask = 0b111 << 25 | 0b111 << 4
const opcodeMask = 0b1111
const rotateMask = 0b1111
const immediateMask = 0xff
const shiftMask = 0b11111

const loadStoreWordOrUnsignedByte = 0b01 << 26
const loadStoreWordOrUnsignedByteMask = 0b11 << 26

func Cpu.ExecuteInstruction() {
    instruction := self.FetchInstruction()

    if self.CheckExecuteInstruction(instruction) {
        if instruction & dataProcessingMask == 0 {
            self.ExecuteDataProcessing(instruction)
        } else if instruction & loadStoreWordOrUnsignedByteMask == loadStoreWordOrUnsignedByte {
            self.ExecuteLoadStoreWordOrUnsignedByte(instruction)
        } else {
            Print("Instruction ")
            PrintHex(instruction)
            Println(" not recognised.")
            Assert(false)
        }
    }

    self.WriteRegister(PC, self.ReadRegister(PC) + 4)
}

func Cpu.ExecuteDataProcessing(instruction: Word) {
    // Opcodes
    const Mov = 13

    opcode := instruction >> 21 & opcodeMask
    s := instruction >> 20 & 1
    rn := instruction >> 16 & registerMask
    rd := instruction >> 12 & registerMask

    var operand: Word
    var shifterCarryOut: Bool

    if instruction & dataProcessingImmediateMask == dataProcessingImmediateMask {
        rotate := (instruction >> 8 & rotateMask) << 1
        immediate := instruction & immediateMask
        operand = (immediate >> rotate) | (immediate << (32 - rotate))
        // TODO: Set carry out
    } else if instruction &dataProcessingLslMask == 0 {
        shift := instruction >> 7 & shiftMask
        rm := instruction & registerMask
        rmValue := self.ReadRegister(rm)

        if (rm == PC) {
            rmValue += 8
        }

        rnValue := self.ReadRegister(rn)

        if (rn == PC) {
            rnValue += 8
        }

        operand = rmValue << shift
        // TODO: Set carry out
    } else {
        Assert(false)
    }

    switch opcode {
       case Mov:
            self.WriteRegister(rd, operand)

            if s == 1 {
                // TODO: Set flags
                Assert(false)
            }
        
        default:
            Assert(false)
    }
}

// TODO: This needs to fully implement TLBs etc.
func Cpu.ExecuteLoadStoreWordOrUnsignedByte(instruction: Word) {
    i := instruction >> 25 & 1
    p := instruction >> 24 & 1
    u := instruction >> 23 & 1
    b := instruction >> 22 & 1
    w := instruction >> 21 & 1
    l := instruction >> 20 & 1
    rn := instruction >> 16 & registerMask
    rd := instruction >> 12 & registerMask
    rm := instruction & registerMask
    offset12 := instruction & 0xfff
    shiftImm := instruction >> 7 & 0x1f
    shift := instruction >> 5 & 0b11

    addr := self.ReadRegister(rn)

    if p == 1 {             // Immediate offset
        if u == 1 {
            addr += offset12
        } else {
            addr -= offset12
        }
    } else {
        Assert(false)
    }

    if rn == 15 {
        addr += 8
    }

    if l == 1 {             // Load
        if b == 0 {         // Word
            self.WriteRegister(rd, self.pi.ReadWord(addr))
        } else {
            Assert(false)
        }
    } else {                // Store
        if b == 0 {         // Word
            self.pi.WriteWord(addr, self.ReadRegister(rd))
        } else {
            Assert(false)
        }
    }
}