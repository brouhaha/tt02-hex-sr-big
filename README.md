![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg)

# hex_sr: hex 40-bit shift register with recirculated multiplexer

This project implements a hex 40-bit shift register with a recirulate
multiplexer, for Tiny Tapeout 2.

There are six data inputs, six 40-bit shift registers, and  six data outputs.

The rising edge of the clock input causes a shift.

The actual shift register inputs depend on the recirc input singal. If
recirc is 0, the external data inputs are used, while if recirc is 1,
the shift register outputs are fed back to shift register inputs, causing
the data to recirculate.
