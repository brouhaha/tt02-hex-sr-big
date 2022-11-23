// Testbench for Hex 40-bit shift register
// Copyright 2022 Eric Smith <spacewar@gmail.com>
// SPDX-License-Identifier: Apache-2.0

// Free runs a six bit counter as input to the hex shift register.
//
// For 200 clocks, runs in non-recirculate mode, so starting at cycle 40,
// will output what was input starting at cycle 0.
//
// For the next 200 clocks, runs in recirculate mode, so at cycle 240,
// there will be a discontinuity in the output, due to the input source
// having switched from the free-running counter to recirculation.

`default_nettype none

`timescale 1 ns/10 ps  // time unit = 1 ns, precision = 10 ps

module hex_sr_tb;
   localparam depth = 40;
   localparam period = 20;
    
   reg clk;
   reg recirc;
   reg [5:0] counter;
   
   wire [7:0] sr_in;
   wire [7:0] sr_out;

   assign sr_in[0] = clk;
   assign sr_in[1] = recirc;
   assign sr_in[7:2] = counter;

   initial
   begin
      recirc = 0;
      counter = 0;
      clk = 0;
      for (integer cycle = 0; cycle < 200; cycle = cycle + 1)
      begin
	 $display("cycle=%6d sr_in=%02x sr_out=%02x", cycle, counter, sr_out[7:2]);
         #(period/2) clk = 1;
         #(period/2) clk = 0;
      end
      recirc = 1;
      for (integer cycle = 200; cycle < 400; cycle = cycle + 1)
      begin
	 $display("cycle=%6d sr_in=%02x sr_out=%02x", cycle, counter, sr_out[7:2]);
         #(period/2) clk = 1;
         #(period/2) clk = 0;
      end
      $finish;
   end
     
   always @(posedge clk)
   begin
      counter <= counter + 1;
   end

   hex_sr #(.LENGTH(40)) hexsr0(sr_in, sr_out);

endmodule
