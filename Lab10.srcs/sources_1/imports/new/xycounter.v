`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2015 11:01:38 PM
// Design Name: 
// Module Name: xycounter
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


module xycounter #(parameter width=2, height=2) (
    input wire clock,
    input wire enable,
    output logic [$clog2(width) - 1:0] x = 0,
    output logic [$clog2(height) - 1:0] y = 0
    );
    
    always_ff @(posedge clock) begin
        if(enable) begin
            x <= (x == width - 1) ? 0 : x + 1; 
            if(x==width - 1)
                y <= (y == height - 1) ? 0 : y + 1;
        end
    end
endmodule
