import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
from test.encoder import Encoder

async def reset(dut):
    dut.a <= 0
    dut.b <= 0
    dut.reset <= 1

    await ClockCycles(dut.clk, 5)
    dut.reset <= 0;
    await ClockCycles(dut.clk, 5)


@cocotb.test()
async def test_perfect_encoder(dut):
    clock = Clock(dut.clk, 10, units="us")
    clocks_per_phase = 5
    # no noise
    encoder = Encoder(dut.clk, dut.a, dut.b, clocks_per_phase = clocks_per_phase, noise_cycles = 0)
    cocotb.fork(clock.start())

    await reset(dut)
    assert dut.value == 0

    # count up
    for i in range(clocks_per_phase * 2 *  255):
        await encoder.update(1)

    assert(dut.value == 255)

    # count down
    for i in range(clocks_per_phase * 2  * 255):
        await encoder.update(-1)

    await ClockCycles(dut.clk, 5)
    assert(dut.value == 0)
