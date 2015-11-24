`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2015 10:27:28 AM
// Design Name: 
// Module Name: mandel_unit
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


module mandel_unit(
    input wire reset,
    input wire [31:0] x_set, y_set,
    input wire clk,
    output logic escaped
    );
    logic signed [31:0] c_re, c_im, z_re, z_im;
    logic signed [63:0] z_re_squared, z_im_squared, z_cross;
    always_ff @(posedge clk)
        if(reset)
            begin
                c_re <= x_set;
                c_im <= y_set;
                z_re <= x_set;
                z_im <= y_set;
                escaped <= 0;
            end
        else
            if(!escaped)
                begin
                    z_re <= z_re_squared[61:30] - z_im_squared[61:30] + c_re;
                    z_im <= z_cross[62:31] + c_im;
                    escaped <= (z_re_squared[61:30] + z_im_squared[61:30]) > 32'h0a000000;
                end
    always_comb
        begin
            z_re_squared <= (z_re * z_re);
            z_im_squared <= (z_im * z_im);
            z_cross <= (z_im * z_re);
        end
endmodule
