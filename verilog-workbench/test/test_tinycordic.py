import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles, Timer
import random
import math
from cocotb.handle import RealObject
from bitstring import BitArray
# print(BitArray(bin="0b111").int)

def text_to_decimal(text):
    ascii_values = [ord(character) for character in text]
    a =int(''.join(str(bin(i)[2:].zfill(8)) for i in ascii_values), 2)
    return a

def sgined_bin_to_int(a):
    a_b = "0b" + str(a)
    return BitArray(bin=a_b).int

def bin_to_int(a):
    return int(bin(a),2)

def angle_to_int(a):
    return int(62/180*a)
    
def int_to_angle(a):
    return 180/62*a

def value_to_int(a):
    return int(62/2*a)

def int_to_value(a):
    return 2/62*a

async def reset(dut):
    dut.reset.value = 1

    await ClockCycles(dut.clk, 5)
    dut.reset.value = 0
async def convert_values(dut):
    while True:
        # print(int_to_value(bin_to_int(dut.reg_x.value)))
        # print(sgined_bin_to_int(dut.reg_z.value))
        dut.read_x.value = text_to_decimal(str(round(int_to_value(sgined_bin_to_int(dut.reg_x.value)), 2)))
        dut.read_y.value = text_to_decimal(str(round(int_to_value(sgined_bin_to_int(dut.reg_y.value)), 2)))
        dut.read_z.value = text_to_decimal(str(round(int_to_angle(sgined_bin_to_int(dut.reg_z.value)), 2)))
        await Timer(1, units='us')


@cocotb.test()
async def test_tinycordic(dut):
    dut.io_in.value = 0 # initialize
    await Timer(10, units='us')
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    
    await reset(dut) # reset
    cocotb.fork(convert_values(dut))

    # print(op)
    # print(funct3)
    # print(funct7_5)
    # print(len(op))
    # test a range of values
    for i in range(0, 50):
        # pass
        # dut.op.value = op[i]
        # dut.funct3.value = funct3[i]
        # dut.funct7_5.value = funct7_5[i]
        # dut.inst.value = text_to_decimal(instruction[i])
                # dut.real_ans_x.value = f"{angle}"
        # dut.real_ans_y.value = math.sin(angle)


        # print(op[i])
        # set pwm to this level
        # await FallingEdge(dut.clk)
        # # dut.address_1.value = i
        # await Timer(1, units='us')
        # # dut.address_2.value = i
        # await Timer(1, units='us')
        # dut.address_3.value = i
        # await Timer(1, units='us')
        # data = random.randint(0, 4294967295)
        # dut.write_data.value = data
        # await Timer(1000, units='ps')
        # wait pwm level clock steps
        await ClockCycles(dut.clk, 20)

        angle = random.randint(-90,90)
        dut.z0.value = angle_to_int(angle)
        dut.inp_angle.value = text_to_decimal(str(angle))
        # set_signal_val_real(dut.real_ans_x.value, math.cos(angle))
        # dut.real_ans_x._set_value(math.cos(angle), call_sim)
        dut.real_ans_x.value = text_to_decimal(str(round(math.cos(math.radians(angle)), 2)))
        dut.real_ans_y.value = text_to_decimal(str(round(math.sin(math.radians(angle)), 2)))

        await reset(dut) # reset
        # if (i > 150):
        #     await FallingEdge(dut.clk)
        #     if (io)
        # # assert still high
        # if (i != 0):
        #     assert(dut.read_data_1.value == data)
        #     assert(dut.read_data_2.value == data)
    
