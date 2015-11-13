`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2015 12:17:34 AM
// Design Name: 
// Module Name: sierpscroller
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


`include "display640x480.sv"

`default_nettype none

module sierpscroller(
    input wire [`xbits-1:0] x,
    input wire [`ybits-1:0] y,
    input wire clock,
    output logic pixelon
    );
    
    logic [32 + `xbits:0] displacement;
    
    logic [`xbits-1:0] xdisp;
    logic [`ybits-1:0] ydisp;
    always_ff @(posedge clock)
        displacement <= displacement + 1;
    
    
    
    always_comb
        begin
        xdisp <= displacement[`xbits - 1 + 20:20];
        ydisp <= displacement[`ybits - 1 + 22:22];
        pixelon <= ((x + xdisp) & (y + ydisp)) == 0;
    end
    
endmodule
