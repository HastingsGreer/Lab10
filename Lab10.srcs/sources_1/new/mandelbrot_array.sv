`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2015 11:53:59 AM
// Design Name: 
// Module Name: mandelbrot_array
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


module mandelbrot_array
    (
    input wire [2:0] element,
    input wire [31:0] x, y,
    input wire clk,
    output logic escaped
    );
    
    wire [7:0] reset;
    wire [7:0] escaped_array;
    mandel_unit man_el [7:0] (reset, x, y, clk, escaped_array);
    
    assign escaped = escaped_array[element];
    assign reset = 1 << element;
    
endmodule
