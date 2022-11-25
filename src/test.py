import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


@cocotb.test()
async def test_hex_sr(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut.recirc.value = 0
    for cycle in range(521):
        dut.sr_in = cycle % 64
        await RisingEdge(dut.clk)
        if cycle >= 400:
            v = int(dut.sr_out)
            assert v == (cycle - 400) % 64
            # output matches input with 40 cycle latency
        await FallingEdge(dut.clk)

    dut.recirc.value = 1
    for cycle in range(521, 1042):
        dut.sr_in = cycle % 64
        await RisingEdge(dut.clk)
        v = int(dut.sr_out)
        if cycle >= 921
            v = int(dut.sr_out)
            assert v == (cycle - 400) # 64
        await FallingEdge(dut.clk)
