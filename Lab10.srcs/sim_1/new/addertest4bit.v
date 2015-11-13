`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Montek Singh
// 01/09/2015 03:17:59 AM
// 
//////////////////////////////////////////////////////////////////////////////////


module addertest4bit();

    reg [3:0] A;
    reg [3:0] B;
    reg Cin;
    wire [3:0] Sum;
    wire Cout;
    adder4bit myadder(.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout));
    
    integer i;
    
    initial begin
            // Initialize Inputs
            A = 0;
            B = 0;
            Cin = 0;
    
            // Wait 5 ns for global reset to finish
            #5;
            
            // Let us try some additions
            for(i=0; i<4; i=i+1)
            begin
              #1 A = A + 1; B = B + 3;
            end
              
            // Let us try some subtractions
           
            
            #5 $finish;
        end
    
endmodule
