`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sujay Bhati
// 
// Create Date: 07.08.2025
// Design Name: Program Counter
// Module Name: ProgramCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: A simple 16-bit Program Counter with synchronous reset and enable
// 
//////////////////////////////////////////////////////////////////////////////////

module ProgramCounter (
    input wire clk,               
    input wire reset,              
    input wire PC_enable,             
    input wire [1:0] PC_op,
    input wire [15:0] offset,   
    output reg [15:0] PC_output    
);
    reg [15:0] PC;   
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 16'b0;           
        end 
        else if (PC_enable) begin
            case (PC_op)
                2'b00: PC <= PC;     
                2'b01: PC <= PC + 1;        
                2'b10: PC <= PC + 2;      
                2'b11: PC <= PC + offset;   
                default: PC <= PC;          
            endcase
        end
    end

    
    always @(*) begin
        PC_output = PC;
    end

endmodule