import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
import random

async def reset(dut):
    dut.reset <= 1

    await ClockCycles(dut.clk, 5)
    dut.reset <= 0;

@cocotb.test()
async def test_pwm(dut):
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    
    # test a range of values
    for i in range(10, 255, 20):
        # set pwm to this level
        dut.level <= i

        await reset(dut)

        # wait pwm level clock steps
        await ClockCycles(dut.clk, i)

        # assert still high
        assert(dut.out)

        # wait for next rising clk edge
        await RisingEdge(dut.clk)

        # assert pwm goes low
        assert(dut.out == 0)
