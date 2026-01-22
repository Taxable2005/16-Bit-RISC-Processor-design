`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 11:58:48
// Design Name: 
// Module Name: AR
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


module AR(
    input clk,
    input reset,
    input [15:0] AR_input,
    output [15:0] AR_output,
    input AR_enable
    );
  reg [15:0] AR ;
always@(posedge clk)
begin
if(reset)
begin
AR <= 16'b0;
end
else
begin
if(AR_enable)
begin
AR <= AR_input;
end
else
begin
AR <= AR;
end
end
end
assign AR_output = AR;

endmodule
