`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2015 05:09:04 PM
// Design Name: 
// Module Name: hexDisplay
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


module hexDisplay(
    input wire [31:0] val,
    input wire clock,
    output logic [7:0] segments,
    output logic [7:0] segmentSelect
    );
    logic [20:0] count;
    always_ff @(posedge clock)
        count <= count + 1;
    logic [31:0] character;
    assign character = val >> {count[20:18], 2'b00};
    assign segmentSelect = ~(8'b00000001 << count[20:18]);
    
    hexto7seg seg (character[3:0], segments);
    
endmodule
