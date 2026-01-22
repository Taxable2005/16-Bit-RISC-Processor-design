`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2025 17:26:00
// Design Name: 
// Module Name: Processor_Test_Module
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


module Processor_Test_Module(

    );
    
    reg clk;
    reg reset;
    wire PC_enable;
    wire [1:0] PC_op;
    wire [1:0] mux1_sel;
    wire [1:0] mux2_sel;
    wire Reg_Write_enable;
    wire IR_enable;
    wire IR_control_enable;
    wire [6:0] IR_control;
    wire ALU_enable;
    wire Datamem_enable_read;
    wire Datamem_enable_write;
    wire AC_enable;
    wire Zero_flag_enable;
    wire Zero_flag;
    wire Shifter_enable;
    wire ALU_out_enable;
    wire AR_enable;

    
      initial begin
            clk = 1'b0;
            forever #5 clk = ~clk;
              end
      initial begin
            #500 $stop;
              end
      initial begin
            reset = 1;
            #2 reset = 0;  
              end
      initial begin
            $monitor("Time=%0t | PC_enable=%b",
            $time, PC_enable);
              end




    
    DataPath body( .clk(clk),
                   .reset(reset),
                   .PC_enable(PC_enable),
                   .PC_op(PC_op), 
                   .mux1_sel(mux1_sel), 
                   .mux2_sel(mux2_sel), 
                   .Reg_Write_enable(Reg_Write_enable), 
                   .IR_enable(IR_enable), 
                   .IR_control_enable(IR_control_enable), 
                   .IR_control(IR_control), 
                   .ALU_enable(ALU_enable), 
                   .Datamem_enable_read(Datamem_enable_read), 
                   .Datamem_enable_write(Datamem_enable_write), 
                   .AC_enable(AC_enable), 
                   .Zero_flag_enable(Zero_flag_enable), 
                   .Zero_flag(Zero_flag), 
                   .Shifter_enable(Shifter_enable), 
                   .ALU_out_enable(ALU_out_enable), 
                   .AR_enable(AR_enable) );
    Control_unit brain( .clk(clk), 
                        .reset(reset), 
                        .PC_enable(PC_enable), 
                        .PC_op(PC_op), .mux1_sel(mux1_sel), 
                        .mux2_sel(mux2_sel), 
                        .Reg_Write_enable(Reg_Write_enable), 
                        .IR_enable(IR_enable), 
                        .IR_control_enable(IR_control_enable), 
                        .IR_control(IR_control), 
                        .ALU_enable(ALU_enable), 
                        .Datamem_enable_read(Datamem_enable_read), 
                        .Datamem_enable_write(Datamem_enable_write), 
                        .AC_enable(AC_enable), 
                        .Zero_flag_enable(Zero_flag_enable), 
                        .Zero_flag(Zero_flag), 
                        .Shifter_enable(Shifter_enable), 
                        .ALU_out_enable(ALU_out_enable), 
                        .AR_enable(AR_enable));
    
endmodule
