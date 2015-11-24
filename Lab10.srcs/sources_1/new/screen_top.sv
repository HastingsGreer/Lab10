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
    parameter imem_init="bounce7.mif",
    parameter dmem_init="screentest_dmem.mif"
   )(
    input wire clk,
    input wire ps2_clk,
    input wire ps2_data,
    input wire [3:0] X,  //switches for controlling tmem
    output wire [3:0] red, green, blue,
    output wire hsync, vsync,
    output wire [7:0] segments,
    output wire [7:0] digitselect
    
    );
    logic [1:0] character;
    logic [10:0] vga_read_address;
    
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
    
    
    wire dmem_wr, smem_wr, tmem_wr, dmem_addr, smem_addr, tmem_addr; 
    wire reset = 1'b0;
    
    wire [31:0] dmem_out, smem_out, tmem_out, kbd_out;
    
    assign dmem_wr = (mem_addr[14:13] == 2'b01) & mem_wr;
    assign smem_wr = (mem_addr[14:13] == 2'b10) & mem_wr;
    assign tmem_wr = (mem_addr[14:12] == 3'b110) & mem_wr;
                    
    assign mem_readdata = (mem_addr[14:13] == 2'b01) ? dmem_out :
                          (mem_addr[14:13] == 2'b10) ? smem_out :
                          //(mem_addr[14:12] == 3'b110) ? tmem_out :
                          //(mem_addr[14:12] == 3'b111) ? kbd_out :
                          31'h69696969;
    
    mips mips(clk12, reset, pc, instr, mem_wr, mem_addr, mem_writedata, mem_readdata);
    imem #(128, 32, 32, imem_init) imem(pc[31:0], instr);
    
    dmem #(256, 32, 32, dmem_init) dmem(clk12, dmem_wr, mem_addr[12:0], mem_writedata, dmem_out);
    
    smem screenmem (clk, vga_read_address, character, mem_addr[12:0], mem_writedata, smem_wr, smem_out);
    vgadisplaydriver vga (clk, character, vga_read_address, red, green, blue, hsync, vsync);
    
    wire [31:0] debug_read;
    tmem #(16, 32, 32) tmem(clk12, tmem_wr, mem_addr[12:0], mem_writedata, tmem_out, X, debug_read);
    hexDisplay hx(debug_read, clk, segments, digitselect);
    
    keyboard keyb(clk, ps2_clk, ps2_data, kbd_out);
endmodule