`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2025 22:24:26
// Design Name: 
// Module Name: Shifter
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


module Shifter(
    input [15:0] A,
    output reg [15:0] Shifter_out,
    input  reset,
    input Shifter_enable,
    input [4:0] Shifter_op
    );
    always @(*)
    begin
    if(reset)
    begin
    Shifter_out = 16'b00;
    end
    else
    begin
    if(Shifter_enable)
    begin
    case (Shifter_op)
    5'b10000 : Shifter_out = {A[0],A[15:1]};
    5'b10001 : Shifter_out = {A[14:0],A[15]};
    5'b10010 : Shifter_out = A >> 1;
    5'b10011 : Shifter_out = A << 1;
    5'b10100 : Shifter_out = {A[15],A[15:1]};
    5'b10101 : Shifter_out = A <<< 1;
    default : Shifter_out = A;
    endcase
    end
    else
    begin
    Shifter_out = A;
    end
    
    end
    end
endmodule
