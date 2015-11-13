//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 10/14/2015 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module smem #(
   parameter Nloc  = 40 * 30,                  // Number of memory locations
   parameter Dbits = 2,                  // Number of bits in data
   parameter Abits = 32,                  // Number of bits in address
   parameter initFile = "screentest_smem.mif"          
)( 
   input wire clk,                      
   input wire [Abits - 1 : 0] addr,     // Address for specifying memory location
   output logic [Dbits-1 : 0] dout,
   input wire [Abits - 1 : 0] write_addr,
   input wire [Dbits - 1 : 0] write_char,
   input wire enable          // Data read from memory (asynchronously, i.e., continuously)
   );

   logic [Dbits-1 : 0] mem [Nloc-1 : 0];     // The actual storage where data resides

   initial $readmemh(initFile ,mem, 0, Nloc - 1); 
   
   assign dout = mem[addr[$clog2(Nloc):0]];                  // Memory read: read continuously, no clock involved
   always @(posedge clk)
       if(enable)
           mem[write_addr[$clog2(Nloc):0]] <= write_char;
endmodule
