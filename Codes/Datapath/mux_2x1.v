`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2025 23:34:30
// Design Name: 
// Module Name: PC_adder
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


module mux2x1 (
    input wire [15:0] in0,
    input wire [15:0] in1, 
    input wire sel,          
    output wire [15:0] out   
);

    assign out = (sel == 1'b0) ? in0 : in1;

endmodule


