`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2025 18:50:21
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    input [15:0] Write_data,
    input [3:0] Write_reg,
    input reset,
    input Write_enable,
    input [3:0] Read_reg_1,
    input [3:0] Read_reg_2,
    output [15:0] Read_data_1,
    output [15:0] Read_data_2,
    input clk
    );
    reg [15:0] Register [0:15];
    integer i; 
    integer k;
    initial begin
        for (k = 0; k < 16; k = k + 1)
            Register[k] = 16'd0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 16; i = i + 1)
                Register[i] <= 16'b0;
        end else if (Write_enable) begin
            Register[Write_reg] <= Write_data;
        end
    end
    assign Read_data_1 = Register[Read_reg_1];
    assign Read_data_2 = Register[Read_reg_2];   
endmodule
