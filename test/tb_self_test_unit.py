import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ValueChange
from cocotb.clock import Clock

# Define primary time unit
# - changed from 'ns' to 'us' to compensate
#   for scale error in GTKWave
TIME_UNIT = "ns"

@cocotb.test()
async def main_test(dut):
    # for our sanity's sake, try not
    # to repeat any nibbles
    magic = 0xCAFEBABE

    """Try accessing the design."""

    dut._log.info("Running test...")

    # Resetting unit
    dut.reset.value = 1

    # Starting clock, at 100MHz
    dut._log.info("Starting clock")
    cocotb.start_soon(Clock(dut.mclk, 10, unit=TIME_UNIT).start())

    # Hold reset for 20 ns
    await Timer(20, unit=TIME_UNIT)
    dut.reset.value = 0

    # Let the DUT run
    await Timer(20000, unit=TIME_UNIT)
    dut._log.info("Running test...done")
