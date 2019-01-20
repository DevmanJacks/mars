// SoC used in Raspberry Pi Model B+

type SoC struct {
    gpio:   *GPIO

    pi:     *RaspberryPi
}

const peripheralStart = 0x20000000
const peripheralEnd = 0x2fffffff

func SoC(pi: *RaspberryPi) -> Cpu {
    return SoC { pi = pi, gpio = GPIO() }
}

func SoC.WriteMemory(addr: Address, value: Word) {

}