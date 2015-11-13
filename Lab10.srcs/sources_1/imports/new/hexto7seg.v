//////////////////////////////////////////////////////////////////////////////////
// Montek Singh
// 9/15/2015
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module hexto7seg(
    input wire [3:0] X,
    output logic [7:0] segments
    );
    always_comb
        case (X)
            4'h0 : segments <= ~8'b11111100;
            4'h1 : segments <= ~8'b01100000;
            4'h2 : segments <= ~8'b11011010;
            4'h3 : segments <= ~8'b11110010;
            4'h4 : segments <= ~8'b01100110;
            4'h5 : segments <= ~8'b10110110;
            4'h6 : segments <= ~ 8'b10111110;
            4'h7 : segments <= ~8'b11100000;
            4'h8 : segments <= ~8'b11111110;
            4'h9 : segments <= ~8'b11110110;
            4'ha : segments <= ~8'b11101110;
            4'hb : segments <= ~8'b00111110;
            4'hc : segments <= ~8'b00011010;
            4'hd : segments <= ~8'b01111010;
            4'he : segments <= ~8'b10011110;
            4'hf : segments <= ~8'b10001110;
            default : segments <= ~8'b00000001;
        endcase
   

endmodule
