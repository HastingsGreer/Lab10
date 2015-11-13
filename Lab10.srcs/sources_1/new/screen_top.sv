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


module screen_top
   #(
    parameter imem_init="screentest_imem.mif",
    parameter dmem_init="screentest_dmem.mif"
   )(
    input wire clk,
    output wire [3:0] red, green, blue,
    output wire hsync, vsync
    );
    logic [1:0] character;
    logic [10:0] smem_read_address;
    
    wire [31:0] pc, instr, mem_readdata, mem_writedata, mem_addr;
    wire mem_wr;
    
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

    
    wire dmem_wr, smem_wr, dmem_addr, smem_addr; 
    wire reset = 1'b0;
    
    mips mips(clk25, reset, pc, instr, mem_wr, mem_addr, mem_writedata, mem_readdata);
    imem #(32, 32, 32, imem_init) imem(pc[31:0], instr);
    dmem #(32, 32, 32, dmem_init) dmem(clk25, mem_wr, mem_addr, mem_writedata, mem_readdata);
  
    smem screenmem (clk, smem_read_address, character, smem_addr, mem_writedata, smem_wr);
    vgadisplaydriver vga (clk, character, smem_read_address, red, green, blue, hsync, vsync);
    
endmodule