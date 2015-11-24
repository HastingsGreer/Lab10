`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 10/30/2015 
//
// This is a self-checking tester for your full MIPS processor 
// (Lab 10).  Use the test program for sqr() provided under Lab 10,
// i.e., initialize instruction memory with sqr_imem.txt, and data memory
// with sqr_dmem.txt.
//
// Use this tester carefully!  The names of your top-level input/output
// and internal signals may be different, so modify all of signal names on the
// right-hand-side of the "wire" assigments appearing above the uut
// instantiation.  Observe that the uut itself only has clock and reset inputs
// now, and no debug outputs.  Instead, the internal signals are "pulled out"
// using the member selection, or dot, operator (".").
//
// If you decide not to use some of these internal signals for debugging, you
// may comment the relevant lines out.  Be sure to comment out the
// corresponding "ERROR_*" lines below as well.
//
//////////////////////////////////////////////////////////////////////////////////


module topsim;
    
    wire ps2_clk = 1'b0;
    wire ps2_data = 1'b0;
    wire [3:0] X = 4'b0000;  //switches for controlling tmem
    wire [3:0] red, green, blue;
    wire hsync, vsync;
    wire [7:0] segments;
    wire [7:0] digitselect;
	// Inputs
	logic clk;
	logic reset;
 
	screen_top uut(
	       clk, 
	       ps2_clk, 
	       X,
	       red, green, blue,
	       hsync, vsync,
	       segments, 
	       digitselect
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
   end

   initial begin
      #0.5 clk = 0;
      forever
         #0.5 clk = ~clk;
   end
   
   initial begin
      #50 $finish;
   end
   
   
   
   

endmodule
