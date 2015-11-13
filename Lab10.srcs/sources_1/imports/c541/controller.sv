//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 10/30/2015 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

// These are non-R-type, so check op code
`define LW     6'b 100011
`define SW     6'b 101011
`define ADDI   6'b 001000
`define ADDIU  6'b 001001
`define SLTI   6'b 001010
`define ORI    6'b 001101
`define BEQ    6'b 000100
`define BNE    6'b 000101
`define J      6'b 000010
`define JAL    6'b 000011
`define LUI    6'b 001111

// These are all R-type, i.e., op=0, so check the func field
`define ADD    6'b 100000
`define SUB    6'b 100010
`define AND    6'b 100100
`define OR     6'b 100101
`define XOR    6'b 100110
`define NOR    6'b 100111
`define SLT    6'b 101010
`define SLTU   6'b 101011
`define SLLV   6'b 000100
`define SLL    6'b 000000
`define SRL    6'b 000010
`define SRA    6'b 000011
`define JR     6'b 001000  


module controller(
   input  wire [5:0] op, 
   input  wire [5:0] func,
   input  wire Z,
   output logic [1:0] pcsel,
   output logic [1:0] wasel, 
   output logic sext,
   output logic bsel,
   output logic [1:0] wdsel, 
   output logic [4:0] alufn,
   output logic wr,
   output logic werf, 
   output logic [1:0] asel
   ); 

  assign pcsel = ((op == 6'b0) & (func == `JR)) ? 2'b11   // controls 4-way multiplexor
               : ((op == `J ) | (op == `JAL)) ? 2'b10
               : ((op == `BEQ) & (Z == 1'b1)) ? 2'b01
               : ((op == `BNE) & (Z == 1'b0)) ? 2'b01
               : 2'b00;

  logic [9:0] controls;
  assign {werf, wdsel[1:0], wasel[1:0], asel[1:0], bsel, sext, wr} = controls[9:0];

  always_comb
     case(op)                                     // non-R-type instructions
        `LW: controls <= 10'b 1_10_01_00_1_1_0;     // LW
        `SW: controls <= 10'b 0_xx_xx_00_1_1_1;     // SW
      `ADDI: controls <= 10'b 1_01_01_00_1_1_0;
     `ADDIU: controls <= 10'b 1_01_01_00_1_1_0;      // ADDI
      `SLTI: controls <= 10'b 1_01_01_00_1_1_0;     // SLTI
       `ORI: controls <= 10'b 1_01_01_00_1_0_0;                      // ORI
       `BNE,
       `BEQ: controls <= 10'b 0_xx_xx_00_0_1_0;
         `J: controls <= 10'b 0_xx_xx_xx_x_x_0;
       `JAL: controls <= 10'b 1_00_10_xx_x_x_0;
       `LUI: controls <= 10'b 1_01_01_10_0_x_0;
         
       // add remaining non-R-type instructions here
      6'b000000:                                    
         case(func)                              // R-type
             `ADD: controls <= 10'b 1_01_00_00_0_x_0; // ADD
             `SUB: controls <= 10'b 1_01_00_00_0_x_0; // SUB
              `OR,
             `XOR,
             `NOR,
             `AND: controls <= 10'b 1_01_00_00_0_x_0;
            `SLTU,
             `SLT: controls <= 10'b 1_01_00_00_0_x_0;
            `SLLV: controls <= 10'b 1_01_00_00_0_x_0;
             `SLL,
             `SRL,
             `SRA: controls <= 10'b 1_01_00_01_0_x_0;
              `JR: controls <= 10'b 0_xx_xx_xx_x_x_0;
              // add remaining R-type instructions here
            default:   controls <= 10'b 0_xx_xx_xx_x_x_0; // unknown instruction, turn off register and memory writes
         endcase
      default: controls <= 10'b 0_xx_xx_xx_x_x_0; // unknown instruction, turn off register and memory writes
    endcase
      

  always_comb
    case(op)                        // non-R-type instructions
        `LW,                          // LW
        `SW,                          // SW
      `ADDIU,
      `ADDI: alufn <= 5'b 0xx01;      // ADDI
      `SLTI: alufn <= 5'b 1x011;      // SLTI
       `ORI: alufn <= 5'b x0100;
       `BEQ,                          // BEQ
       `BNE: alufn <= 5'b 1xx01;       // BNE
       `LUI: alufn <= 5'b x0010;
       
      6'b000000:                      
         case(func)                 // R-type
             `ADD: alufn <= 5'b 0xx01; // ADD
             `SUB: alufn <= 5'b 1xx01; // SUB
             `AND: alufn <= 5'b x0000;
             `OR:  alufn <= 5'b x0100;
             `XOR: alufn <= 5'b x1000;
             `NOR: alufn <= 5'b x1100;
             `SLT: alufn <= 5'b 1x011;
            `SLTU: alufn <= 5'b 1x111;
            `SLLV: alufn <= 5'b x0010;
             `SLL: alufn <= 5'b x0010;
             `SRL: alufn <= 5'b x1010;
             `SRA: alufn <= 5'b x1110;
            default:   alufn <= 5'b xxxxx; // ???
         endcase
      default: alufn <= 5'bxxxxx;          // J, JAL
    endcase

endmodule
