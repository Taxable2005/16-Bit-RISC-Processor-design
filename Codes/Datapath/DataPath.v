`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2025 22:47:07
// Design Name: 
// Module Name: DataPath
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


module DataPath(
    input clk,
    input reset,
    input PC_enable,
    input [1:0] PC_op,
    input [1:0] mux1_sel,
    input [1:0] mux2_sel,
    input Reg_Write_enable,
    input IR_enable,
    input IR_control_enable,
    output [6:0] IR_control,
    input ALU_enable,
    input Datamem_enable_read,
    input Datamem_enable_write,
    input AC_enable,
    input Zero_flag_enable,
    output Zero_flag,
    input Shifter_enable,
    input ALU_out_enable,
    input AR_enable
    );
    wire [15:0] Databus1;
    wire [15:0] Databus2;
    wire [15:0] Addressbus;
    
    wire [15:0] Data_mem_mux1;
    wire [15:0] ALU_Shifter;
    wire [15:0] IR_mux1;
    wire [15:0] I_mem_IR;
    wire [15:0] AC_ALU;
    wire [15:0] Reg_AC;
    wire [15:0] ALU_out_mux2;
    wire [15:0] Reg_mux1; 
    wire [15:0] Shifter_ALU_out;
    wire [5:0] PC_I_memory;
    wire [3:0] IR_Reg1, IR_Reg2;
    wire [4:0] IR_ALU;


    ProgramCounter PC( .clk(clk), .reset(reset), .PC_enable(PC_enable), .PC_op(PC_op), .offset(Databus1), .PC_output(PC_I_memory));
    
    mux4x1 mux1( .sel(mux1_sel), .in0(Reg_mux1), .in1(Data_mem_mux1), .in2(IR_mux1), .in3(16'b0), .out(Databus1));
    
    mux4x1 mux2( .sel(mux2_sel), .in0(ALU_out_mux2), .in1(Databus1), .in2(16'b0), .in3(16'b1111111111111111), .out(Databus2));
    
    Register_File Registers( .clk(clk), .reset(reset), .Write_enable(Reg_Write_enable), .Write_reg(IR_Reg2), .Read_reg_1(IR_Reg1), .Read_reg_2(IR_Reg2), .Write_data(Databus2), .Read_data_1(Reg_mux1), .Read_data_2(Reg_AC));
    
    IR IR( .clk(clk), .reset(reset), .IR_enable(IR_enable), .IR_control_enable(IR_control_enable), .IR_control(IR_control), .IR_data1(IR_Reg1), .IR_data2(IR_Reg2), .IR_opcode(IR_ALU), .instruction_datapath(IR_mux1), .IR_Input(I_mem_IR));
    
    ALU_pro ALU( .reset(reset), .ALU_enable(ALU_enable), .ALU_op(IR_ALU), .A(AC_ALU), .B(Databus1), .ALU_out(ALU_Shifter));
    
    Data_memory DM( .clk(clk), .reset(reset), .enable_read(Datamem_enable_read), .enable_write(Datamem_enable_write), .address_write(Addressbus), .data_write(Databus2), .address_read(Addressbus), .data_read(Data_mem_mux1));
    
    AC AC( .clk(clk), .reset(reset), .AC_enable(AC_enable), .AC_input(Reg_AC), .AC_output(AC_ALU) );
    
    Flags Flags( .clk(clk), .reset(reset), .Zero_flag_enable(Zero_flag_enable), .Zero_flag(Zero_flag), .ALU_out(ALU_out_mux2) );
    
    Shifter Shifter(  .reset(reset), .Shifter_enable(Shifter_enable), .Shifter_op(IR_ALU), .A(ALU_Shifter), .Shifter_out(Shifter_ALU_out));
    
    I_memory IM( .clk(clk), .reset(reset), .address_read(PC_I_memory), .Instruction_out(I_mem_IR) );
    
    ALU_out_pro ALU_out( .reset(reset), .ALU_out_enable(ALU_out_enable), .ALU_out_in(Shifter_ALU_out), .ALU_out_out(ALU_out_mux2));
    
    AR AR( .clk(clk), .reset(reset), .AR_enable(AR_enable), .AR_input(Databus1), .AR_output(Addressbus));
    endmodule

