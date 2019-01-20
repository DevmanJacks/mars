// GPIO used in SoC (BCM2835) in Raspberry Pi

const numGpioLines = 54

type FunctionSelect enum {
    Input = 0b000
    Output = 0b001
    AlternateFunction0 = 0b100
    AlternateFunction1 = 0b101
    AlternateFunction2 = 0b110
    AlternateFunction3 = 0b111
    AlternateFunction4 = 0b011
    AlternateFunction5 = 0b010
}

type GPIO struct {
    line: [54]FunctionSelect
}

func GPIO() -> *GPIO {
    return &GPIO{}
}

const gpioRegisterStart = 0x20200000
const gpioRgisterEnd = 0x202000B0

func GPIO.ReadMemory(addr: Address) -> Word {
    Assert(false)
}

func GPIO.WriteMemory(addr: Address, value: Word) {

}