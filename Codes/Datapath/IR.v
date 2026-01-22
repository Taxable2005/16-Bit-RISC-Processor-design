`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    <your date here>
// Design Name: 
// Module Name:    <module_name> 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module IR(
        input [15:0] IR_Input,
        output reg [6:0] IR_control,
        output reg [15:0] instruction_datapath, //for immediate value to be sent to data memory or ALU
        input clk,
        input reset,
        input IR_enable,
        input IR_control_enable,
        output reg [3:0] IR_data1, // register 1 value
        output reg [3:0] IR_data2, // register 2 or register connected to AC value (whereever required)
        output reg [4:0] IR_opcode // opcode sending to ALU directly
       
);
reg [15:0] instruction_control;
always @(posedge clk)
begin
if(reset)
begin
 instruction_control <= 16'b0;
 instruction_datapath <= 16'b0;
end
else if (IR_enable)
begin
  instruction_control  = (IR_control_enable) ? IR_Input : instruction_control;
  instruction_datapath = (IR_control_enable) ? 16'b0 : IR_Input;
end
end

always @(*) begin

  IR_data1 = instruction_control[8:5];
  IR_data2 = instruction_control[4:1];
  IR_opcode = instruction_control[13:9];
  IR_control = instruction_control[15:9];
  
end

endmodule