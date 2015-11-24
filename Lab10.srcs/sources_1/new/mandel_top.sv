`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2015 10:46:58 AM
// Design Name: 
// Module Name: screen_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mandel_top
   (
    input wire clk,
    output wire [3:0] red, green, blue,
    output wire hsync, vsync
    );
   
     wire clk100, clk50, clk25, clk12;
   
      // Uncomment *only* one of the following two lines:
      //    when synthesizing, use the first line
      //    when simulating, get rid of the clock divider, and use the second line
      //
      clockdivider_Nexys4 clkdv(clk, clk100, clk50, clk25, clk12);
      //assign clk100=clk; assign clk50=clk; assign clk25=clk; assign clk12=clk;
   
      // For synthesis:  use an appropriate clock frequency(ies) below
      //   clk100 will work for only the most efficient designs (hardly anyone)
      //   clk50 or clk 25 should work for the vast majority
      //   clk12 should work for everyone!
      //
      // Use the same clock frequency for the MIPS and data memory/memIO modules
      // The vgadisplaydriver should keep the 100 MHz clock.
      // For example:

    logic [10:0] x, y;
    logic activevideo, escaped;
    
    
    vgatimer myvgatimer(clk, hsync, vsync, activevideo, x, y);
   
    mandelbrot_array(x, {10'b0, x, 10'b0}, {10'b0, x, 10'b0}, clk12, escaped);
    assign red = 0;
    assign green = 0;
    assign blue = {4{escaped}};
    
    
    
endmodule