`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2015 05:52:56 PM
// Design Name: 
// Module Name: datapath
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
`default_nettype none

module datapath #(
   parameter Abits = 5,          // Number of bits in address
   parameter Dbits = 32,         // Number of bits in data
   parameter Nloc = 32           // Number of memory locations
)(
       input wire clk,
       input wire reset,
       output logic [31:0] pc = 0,
       input wire [31:0] instr,
       input wire [1:0] pcsel,
       input wire [1:0] wasel,
       input wire sext,
       input wire bsel,
       input wire [1:0] wdsel,
       input wire [4:0] alufn,
       input wire werf,
       input wire [1:0] asel,
       output logic Z,
       output logic [31:0] mem_addr,
       output logic [31:0] mem_writedata,
       input wire [31:0] mem_readdata
    );
    logic [31:0] BT;
    logic [4:0] reg_writeaddr;
    logic [31:0] reg_writedata;
    logic [4:0] Rs;
    logic [4:0] Rt;
    logic [31:0] pcPlus4;
    logic [31:0] ReadData1, ReadData2;
    logic [15:0] Imm;
    logic [31:0] signimm;
    logic [4:0] shamt;
    wire [31:0] aluA;
    wire [31:0] aluB;
    wire [31:0] alu_result;
    
    assign reg_writeaddr = (wasel == 2'b00) ? instr[15:11]:
                       (wasel == 2'b01) ? instr[20:16]:
                       (wasel == 2'b10) ? 5'b11111: 5'bxxxxx;
    
    assign Rs = instr[25:21];
    assign Rt = instr[20:16];
    
    register_file myreg(clk, werf, Rs, Rt, reg_writeaddr, reg_writedata, ReadData1, ReadData2);
        
    
    
    assign Imm = instr[15:0];
    
    assign signimm = sext ? (Imm[15] ? {{16{1'b1}} , Imm} 
                                     : {{16{1'b0}} , Imm})
                          : {{16{1'b0}} , Imm};
    
    assign shamt = instr[10:6];
    
    assign aluA = (asel == 2'b00) ? ReadData1 : 
                  (asel == 2'b01) ? shamt:
                  32'h10;
    
    assign aluB = bsel ? signimm : ReadData2;
    
    
    
    ALU myalu(aluA, aluB, alu_result, alufn, Z);
    assign mem_addr = alu_result;
    
    always_comb
        case(wdsel)
            2'b00: reg_writedata <= pcPlus4;
            2'b01: reg_writedata <= alu_result;
            2'b10: reg_writedata <= mem_readdata;
            default: reg_writedata <= {32{1'bx}};
        endcase
        
    logic [31:0] newPC;
    
    always_ff @(posedge clk)
        pc <= reset ? 32'b0 : newPC;
        
    assign pcPlus4 = pc + 4;
    always_comb
        case(pcsel)
            2'b00: newPC <= pcPlus4;
            2'b01: newPC <= BT;
            2'b10: newPC <= {pc[31:28], instr[25:0], 2'b00};
            2'b11: newPC <= ReadData1;
            default: newPC <= {32{1'bx}};
        endcase
        
    assign mem_writedata = ReadData2;
    
    assign BT = pcPlus4 + {signimm[29:0], 2'b00};
    
    
endmodule
