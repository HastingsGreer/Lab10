`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2015 10:31:21 AM
// Design Name: 
// Module Name: fulladder
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


module fulladder(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
    );
    
    wire t1, t2, t3;
    xor x1(t1, A, B);
    xor x2(Sum, Cin, t1);
    and a1(t2, Cin, t1);
    and a2(t3, A, B);
    or  o1(Cout, t2, t3);
endmodule
