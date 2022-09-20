import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
import random

class BouncingSwitch():

    def __init__(self, dut):
        self.dut = dut

    async def set(self, value, bounce_cycles = 5):
        for i in range(bounce_cycles):
            self.dut.button <= random.randint(0, 1)
            await ClockCycles(self.dut.clk, 1)

        # finally set to what it should be
        self.dut.button <= value
        await ClockCycles(self.dut.clk, 1)


async def reset(dut):
    dut.reset <= 1
    dut.button <= 0

    await ClockCycles(dut.clk, 5)
    dut.reset <= 0;
    await ClockCycles(dut.clk, 5)

@cocotb.test()
async def test_debouncer(dut):
    clock = Clock(dut.clk, 10, units="us")
    clocks_per_phase = 10
    switch = BouncingSwitch(dut)
    cocotb.fork(clock.start())

    await reset(dut)
    assert dut.debounced == 0

    # toggle button 10 times
    for i in range(10):
        # set the switch, which will bounce
        await switch.set(1)

        # assert still low
        assert dut.debounced == 0

        # wait 8 clock cycles (default history length in debounce.v) + 1 for register
        await ClockCycles(dut.clk,9) 

        # assert button is as set
        assert dut.debounced == 1

        # same for off
        await switch.set(0)

        # assert still high
        assert dut.debounced == 1

        # wait 8 clock cycles (default history length in debounce.v) + 1 for register
        await ClockCycles(dut.clk, 9)

        assert dut.debounced == 0

