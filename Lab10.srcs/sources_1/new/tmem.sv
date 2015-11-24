/////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module tmem #(
   parameter Nloc  = 16,                  // Number of memory locations
   parameter Dbits = 32,                  // Number of bits in data
   parameter Abits = 32         
)(                   
   input wire clk,
   input wire mem_wr,
   input wire [Abits - 1 : 0] addr,
   input wire [Dbits - 1 : 0] mem_writedata,    
   output logic [Dbits-1 : 0] dout,           // Data read from memory (asynchronously, i.e., continuously)
   input wire [Abits - 1 : 0] debug_addr,
   output logic [Dbits-1 : 0] debug_data
   );
   //clk, mem_wr, mem_addr, mem_writedata, mem_readdata
   logic [Dbits-1 : 0] mem [Nloc-1 : 0];     // The actual storage where data resides

   initial $readmemh("tmem_init.mif",mem, 0, Nloc - 1);
   
   always_ff @(posedge clk)                               	// Memory write: only when wr==1, and only at posedge clock
       if(mem_wr)
           mem[addr[31:2]] <= mem_writedata; 
   
   assign dout = mem[addr[31:2]];                  // Memory read: read continuously, no clock involved
   assign debug_data = mem[debug_addr];
endmodule
