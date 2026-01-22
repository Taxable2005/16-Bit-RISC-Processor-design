`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 
// Create Date: 07.08.2025
// Design Name: Register File
// Module Name: RegisterFile
//////////////////////////////////////////////////////////////////////////////////

module RegisterFile (
    input clk,
    input reset,

    // Write port
    input write_enable,
    input [3:0] write_addr,
    input [15:0] write_data,

    // Read port 1
    input [3:0] read_addr1,
    output reg [15:0] read_data1,

    // Read port 2
    input [3:0] read_addr2,
    output reg [15:0] read_data2
);

    reg [15:0] mem [15:0]; // 16 registers, each 16-bit wide
    integer i;

    // Reset and write logic
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 16; i = i + 1)
                mem[i] <= 16'd0;
        end
        else if (write_enable) begin
            mem[write_addr] <= write_data;
        end
    end

    // Read logic (combinational)
    always @(*) begin
        read_data1 = mem[read_addr1];
        read_data2 = mem[read_addr2];
    end

endmodule
