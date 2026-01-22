`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2025 00:00:12
// Design Name: 
// Module Name: I_memory
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

module I_memory(
    input [5:0] address_read,
    output reg [15:0] Instruction_out,
    input clk,
    input reset
    );

    reg [15:0] I_mem[63:0];
    integer i;
    always @(posedge clk)
    begin
    I_mem[1] <= 16'b1011000000000000;
    I_mem[2] <= 16'b0000000000000001;
    I_mem[3] <= 16'b1011000000000010; //                               B           A   
    I_mem[4] <= 16'b0000000000001100; //                             (Mux)    (Accumalator)
    I_mem[5] <= 16'b0011001000000010; // adressing mode + opcode + register1 + register2 + extra bit
    I_mem[6] <= 16'b0100001000000010; //      00          00000      0000        0000         0

        if (reset)
        begin
            for (i = 0; i < 64; i = i + 1)
            begin
                I_mem[i] <= 16'b00;
            end
        end
        else
        begin
        Instruction_out <= I_mem[address_read]; 
        end
    end

endmodule
