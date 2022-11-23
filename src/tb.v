`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

module tb (
    // testbench is controlled by test.py
    input clk,
    input recirc,
    input [5:0] sr_in,
    output [5:0] sr_out
   );

    // this part dumps the trace to a vcd file that can be viewed with GTKWave
    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // wire up the inputs and outputs
    wire [7:0] inputs = {sr_in, recirc, clk};
    wire [7:0] outputs;
    assign sr_out = outputs[7:2];

    // instantiate the DUT
    hex_sr #(.LENGTH(40)) hex_sr(
        .io_in  (inputs),
        .io_out (outputs)
        );

endmodule
