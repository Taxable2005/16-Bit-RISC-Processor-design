`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2025
// Design Name: ALU_out register
// Module Name: ALU_out_register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: A register to store ALU result
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU_out_pro (                
    input reset,              
    input ALU_out_enable,             
    input [15:0] ALU_out_in,     
    output reg [15:0] ALU_out_out      
);

    always @(*) begin
        if (reset) 
            ALU_out_out = 16'b0;                
        else if (ALU_out_enable) 
            ALU_out_out = ALU_out_in;               
    end

endmodule