import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ValueChange
from cocotb.clock import Clock

# Define primary time unit
# - changed from 'ns' to 'us' to compensate
#   for scale error in GTKWave
TIME_UNIT = "ns"

bin2ssd = {
    0b0000: 0b1111110,
    0b0001: 0b0110000,
    0b0010: 0b1101101,
    0b0011: 0b1111001,
    0b0100: 0b0110011,
    0b0101: 0b1011011,
    0b0110: 0b1011111,
    0b0111: 0b1110000,
    0b1000: 0b1111111,
    0b1001: 0b1111011,
    0b1010: 0b1110111,
    0b1011: 0b0011111,
    0b1100: 0b1001110,
    0b1101: 0b0111101,
    0b1110: 0b1001111,
    0b1111: 0b1000111
}

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

    # Write magic sequence
    while magic != 0:
        vis_byte = magic & 0xFF
        low_nib = vis_byte & 0x0F
        high_nib = (vis_byte >> 4) & 0x0F

        # - update `d0` and `d1` simultaneously
        await RisingEdge(dut.c)
        dut.d0.value = low_nib
        dut.d1.value = high_nib

        # - anchor assertion of `bin2ssd(d1)` to clock rising edge
        await RisingEdge(dut.mclk)
        assert dut.abcdefg.value == bin2ssd[high_nib]

        # - anchor assertion of `bin2ssd(d0)` to value change
        # FIXME: this can't be reasoned with,
        #        except perhaps visually
        await ValueChange(dut.abcdefg)
        assert dut.abcdefg.value == bin2ssd[low_nib]

        magic >>= 8
    await FallingEdge(dut.c)
    await Timer(1000, unit=TIME_UNIT)
    dut._log.info("Running test...done")
