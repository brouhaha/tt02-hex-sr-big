// shift register with recirculate multiplexer
// Copyright 2022 Eric Smith <spacewar@gmail.com>
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module sr_recirc #( parameter LENGTH = 40 ) (
	   input clk,
	   input recirc,  // 0 to shift in data_in, 1 to recirculate
	   input data_in,
	   output data_out
);

   logic [LENGTH-1:0] shift_reg;

   assign data_out = shift_reg[LENGTH - 1];

   initial
   begin
      for (integer i = 0; i < LENGTH; i += 1)
	shift_reg[i] = 0;
   end

   always @(posedge clk)
   begin
      if (recirc)
        shift_reg [0] <= shift_reg[LENGTH - 1];
      else
        shift_reg [0] <= data_in;
      shift_reg [LENGTH-1:1] <= shift_reg [LENGTH-2:0];
   end

endmodule

