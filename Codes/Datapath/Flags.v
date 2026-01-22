`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2025 00:43:51
// Design Name: 
// Module Name: Flags
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


module Flags(
input clk,
input reset,
input [15:0] ALU_out,
input Zero_flag_enable,
output reg Zero_flag


    );
    
wire zero_next;  
assign zero_next = (ALU_out == 16'b0);

always @(posedge clk or posedge reset) begin

    if (reset)
       Zero_flag <= 1'b0;
    else if (Zero_flag_enable)
        Zero_flag <= zero_next;
end

endmodule
