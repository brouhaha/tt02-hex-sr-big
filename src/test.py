import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


@cocotb.test()
async def test_hex_sr(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    cycles = 512
    sr_len = 100

    dut.recirc.value = 0
    for cycle in range(cycles):
        dut.sr_in = cycle % 64
        await RisingEdge(dut.clk)
        if cycle >= sr_len:
            v = int(dut.sr_out)
            assert v == (cycle - sr_len) % 64
            # output matches input with 40 cycle latency
        await FallingEdge(dut.clk)

    dut.recirc.value = 1
    for cycle in range(cycles, 2 * cycles):
        dut.sr_in = cycle % 64
        await RisingEdge(dut.clk)
        v = int(dut.sr_out)
        if cycle >= cycles + sr_len:
            v = int(dut.sr_out)
            assert v == (cycle - sr_len) # 64
        await FallingEdge(dut.clk)
