//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 10/14/2015 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module imem #(
   parameter Nloc  = 32,                  // Number of memory locations
   parameter Dbits = 32,                  // Number of bits in data
   parameter Abits = 32,                  // Number of bits in address
   parameter initFile = "sqr_imem.txt"          
)(                       
   input wire [Abits - 1 : 0] addr,     // Address for specifying memory location
   output logic [Dbits-1 : 0] dout           // Data read from memory (asynchronously, i.e., continuously)
   );

   logic [Dbits-1 : 0] mem [Nloc-1 : 0];     // The actual storage where data resides

   initial $readmemh(initFile ,mem, 0, Nloc - 1); 
   
   assign dout = mem[addr[2+$clog2(Nloc):2]];                  // Memory read: read continuously, no clock involved

endmodule
