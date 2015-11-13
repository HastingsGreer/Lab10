`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2015 10:46:45 PM
// Design Name: 
// Module Name: vgatimer
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
`timescale 1ns / 1 ps
`default_nettype none
`include "display640x480.sv"

module vgatimer(
    input wire clk,
    output wire hsync, vsync, activevideo, 
    output wire [`xbits - 1:0] x,
    output wire [`ybits - 1:0] y
    );
    
    logic [1:0] clk_count = 0;
    always_ff @(posedge clk)
       clk_count <= clk_count + 2'b01;
    
    logic Every2ndTick, Every4thTick;
    assign Every2ndTick = (clk_count[0] == 1'b 1);
    assign Every4thTick = (clk_count[1:0] == 2'b 11);
    
    
    xycounter #(`WholeLine, `WholeFrame) xy(clk, Every4thTick, x, y);
    
    assign hsync = ((x >= `hSyncStart) & (x <= `hSyncEnd))^`hSyncPolarity;
    assign vsync = ((y >= `vSyncStart) & (y <= `vSyncEnd))^`hSyncPolarity;
    assign activevideo = (x < `hVisible) & (y < `vVisible);
    
    
endmodule
