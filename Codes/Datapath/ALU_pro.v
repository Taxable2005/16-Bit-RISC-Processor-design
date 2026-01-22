`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2025 11:37:40
// Design Name: 
// Module Name: ALU_pro
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


module ALU_pro(
    input reset,
    input ALU_enable,
    input [4:0] ALU_op,
    input [15:0] A,
    input [15:0] B,
    output reg [15:0]  ALU_out
    );
    always @(*)
    begin
    if (reset)
    begin
    ALU_out = 16'b0;
    end
    else
    begin
    if(ALU_enable)
    begin
    case (ALU_op)
    5'b00001: ALU_out = A+B;
    5'b00010: ALU_out = A-B;
    5'b00011: ALU_out = A+1;
    5'b00100: ALU_out = A-1;
    5'b00101: ALU_out = A&B;
    5'b00110: ALU_out = A|B;
    5'b00111: ALU_out = ~A;
    5'b00000: ALU_out = A^B;
    5'b01000: ALU_out = A-B;
    5'b01001: ALU_out = A-B;
    5'b01010: ALU_out = A-B;
    default: ALU_out = A;
    endcase
    end
    end
    end
    
endmodule
