`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 10/2/2015 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.sv"

module vgadisplaydriver(
    input wire clk,
    input wire [1:0] character,
    output wire [10:0] smem_address,
    output logic [3:0] red, green, blue,
    output wire hsync, vsync
    );

   wire [`xbits-1:0] x;
   wire [`ybits-1:0] y;
   wire activevideo;

   vgatimer myvgatimer(clk, hsync, vsync, activevideo, x, y);
   wire [`ybits-5:0] y_over_16;
   assign y_over_16 = y[`ybits-1:4];
   assign smem_address = x[`xbits-1:4] + {y_over_16, 5'b0} + {y_over_16, 3'b0}; // times 32
   wire [11:0] color;
   wire [32:0] bmem_addr;
   assign bmem_addr = {character, 8'b0} + {x[3:0], 4'b0} + y[3:0];
   bmem mem (bmem_addr, color);
   
   assign red[3:0]   = (activevideo == 1) ? color[11:8]: 4'b0;
   assign green = (activevideo == 1) ? color[7:4]: 4'b0;
   assign blue  = (activevideo == 1) ? color[3:0] : 4'b0;

endmodule