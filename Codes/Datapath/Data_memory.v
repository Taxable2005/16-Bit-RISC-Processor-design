`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2025 00:12:27
// Design Name: 
// Module Name: Data_memory
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

module Data_memory(
    input enable_read,
    input enable_write,
    input [5:0] address_write,
    input [15:0] data_write,
    input [5:0] address_read,
    output reg [15:0] data_read,
    input clk,
    input reset
);

    reg [15:0] data_mem [0:63];
    reg [5:0] address_read_reg;
    reg [5:0] address_write_reg;
    integer i;

    initial begin
        for (i = 0; i < 64; i = i + 1)
            data_mem[i] = 16'b0;
    end

    always @(posedge clk) begin
    
        if (reset) begin
            for (i = 0; i < 64; i = i + 1) begin
                data_mem[i] <= 16'b00;
            end
        end else begin
            if (enable_read) begin
                data_read <= data_mem[address_read_reg]; 
            end
            if (enable_write) begin
                data_mem[address_write_reg] <= data_write; 
            end
        end
    end
    always @(*)
    begin
    address_read_reg = address_read;
    address_write_reg = address_write;
    end

endmodule
