`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2025 21:29:31
// Design Name: 
// Module Name: Control_unit
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


module Control_unit(
    input clk,
    input reset,
    output reg PC_enable,
    output reg [1:0] PC_op,
    output reg [1:0] mux1_sel,
    output reg [1:0] mux2_sel,
    output reg Reg_Write_enable,
    output reg IR_enable,
    output reg IR_control_enable,
    input [6:0] IR_control,
    output reg ALU_enable,
    output reg Datamem_enable_read,
    output reg Datamem_enable_write,
    output reg AC_enable,
    output reg Zero_flag_enable,
    input  Zero_flag,
    output reg Shifter_enable,
    output reg ALU_out_enable,
    output reg AR_enable
    );
    parameter Fetch = 3'b000;
    parameter Decode = 3'b001;
    parameter Decode2 = 3'b010;
    parameter Execute1 = 3'b011;
    parameter Execute2 = 3'b100;
    parameter Wait1 = 3'b101;
    parameter Wait2 = 3'b110;
    parameter Wait3 = 3'b111;

    parameter Direct = 2'b00;
    parameter Indirect = 2'b01;
    parameter Immediate = 2'b10;
    reg [2:0] state;
    reg [2:0] Next_state;
    reg [4:0] opcode;
    reg [1:0] addressing_mode;
    reg execute;
    reg fetch;
    always@(posedge clk or posedge reset)
    begin
    
    if(reset)
    begin
    
    state <= Fetch;
    end
    else
    begin
    state <= Next_state;
    end
    end
    
    initial begin   
        Next_state <= Fetch;
            end
    
    always@(*)
    begin
    case(state)
    
    Wait1:begin
    
    
            PC_op=2'b00;
            
            
            Next_state = Wait2;
         end
    
    Wait2:begin

            Next_state = Decode;
          end       
    
    Wait3:begin
            case(addressing_mode)
                Direct:begin
                            casez(opcode)
                            5'b01???:begin
                                        mux2_sel = 2'b00;
                                        Reg_Write_enable = 1'b1;
                                        Next_state = Fetch;                           
                                     end
                            endcase
                       end
                Immediate:begin
                        
                            casez(opcode)
                            5'b00???:begin
                                        mux2_sel = 2'b00;
                                        Reg_Write_enable = 1'b1;
                                        Next_state = Fetch;                           
                                     end
                            5'b11011:begin
                                        Next_state = Fetch;
                                     end
                            5'b11000:begin
                                        Next_state = Fetch;
                                     end
                        
                            default:begin
                                    Next_state = Fetch;
                                    end
                        endcase
                          end
            default:begin
                        Next_state = Fetch;
                    end
            endcase    
          end
    
    Fetch: begin

            PC_enable=1'b0;
            PC_op=2'b0;
            mux1_sel=2'b11;
            mux2_sel=2'b11;
            Reg_Write_enable=1'b0;
            IR_enable=1'b0;
            IR_control_enable=1'b1;
            ALU_enable=1'b0;
            Datamem_enable_read=1'b0;
            Datamem_enable_write=1'b0;
            AC_enable=1'b0;
            Zero_flag_enable=1'b0;
            Shifter_enable=1'b0;
            ALU_out_enable=1'b0;
            AR_enable=1'b0;


            PC_enable = 1'b1;
            PC_op = 2'b01;
            IR_control_enable = 1'b1;
            IR_enable = 1'b1;
            


            execute = 1'b0; //used in case of Indirect addressing mode 
            fetch = 1'b0; //used in case of Immediate addressing mode
            Next_state = Wait1;
            end
    
    Decode:begin
            addressing_mode = IR_control[6:5];
            opcode = IR_control[4:0];
            
            
            case(addressing_mode)
            Indirect:begin
                        casez(opcode)
                        5'b00???:begin
                                    mux1_sel = 2'b00;
                                    AR_enable = 1'b1;
                                    Datamem_enable_read = 1'b1;
                                    AC_enable = 1'b1;
                                    Next_state = Execute1;
                                 end
                        endcase
                     end
            Direct:begin
                        casez(opcode)
                        5'b01???:begin
                                    AC_enable = 1'b1;
                                    mux1_sel = 2'b00;

                                    Next_state = Execute1;
                                 end
                        5'b10???:begin
                                    AC_enable = 1'b1;
                                    mux1_sel = 2'b00;

                                    Next_state = Execute1;
                                 end
                        5'b00???:begin
                                    AC_enable = 1'b1;
                                    mux1_sel = 2'b00;


                                    Next_state = Execute1;
                                 end
                        5'b01100:begin
                                    mux2_sel = 2'b11;
                                    Reg_Write_enable = 1'b1;
                                    Next_state = Fetch;
                                    
                                 end
                        5'b01011:begin
                                    mux1_sel = 2'b11;
                                    mux2_sel = 2'b01;
                                    Reg_Write_enable = 1'b1;
                                    Next_state = Fetch;
                                    
                                 end
                        5'b01010:begin
                                    AC_enable = 1'b1;
                                    mux1_sel = 2'b00;
                                    ALU_enable = 1'b1;
                                    ALU_out_enable = 1'b1;
                                    Zero_flag_enable=1'b1;
                                    Next_state = Execute1;
                                 end
                        5'b11011:begin
                                    mux1_sel = 2'b00;
                                    mux2_sel = 2'b01;
                                    PC_enable = 1'b1;
                                    PC_op = 2'b11;
                                    Next_state = Fetch;
                                 end
                        5'b11010:begin
                                    mux1_sel = 2'b00;
                                    mux2_sel = 2'b01;
                                    Reg_Write_enable = 1'b1;
                                    Next_state = Fetch;
                                 end
                        5'b11000:begin
                                    mux1_sel = 2'b00;
                                    AR_enable = 1'b1;
                                    Datamem_enable_read = 1'b1;
                                    Next_state = Execute1;
                                 end
                        5'b11001:begin
                                    AC_enable = 1'b1;
                                    mux1_sel = 2'b00;
                                    AR_enable = 1'b1;

                                    Next_state = Execute1;
                                 end                        
                        endcase
                   end
            Immediate:begin
                        casez(opcode)
                        5'b00???:begin
                                    PC_enable = 1'b1;
                                    PC_op = 2'b01;
                                    AC_enable = 1'b1;
                                    Next_state = Execute1;
                                 end
                        5'b01010:begin
                                    PC_enable = 1'b1;
                                    PC_op = 2'b01;
                                    AC_enable = 1'b1;
                                    Next_state = Execute1;
                                 end
                        5'b11011:begin
                                    PC_enable = 1'b1;
                                    PC_op = 2'b01;
                                    Next_state = Execute1;                                   
                                 end
                        5'b11000:begin
                                    PC_enable = 1'b1;
                                    PC_op = 2'b01;
                                    Next_state = Execute1;
                                 end
                        default:begin
                                    Next_state = Fetch;
                                end
                        endcase   
                      end
            default:begin
                        Next_state = Fetch;
                    end
            endcase
           end  
    
    Execute1:begin
            case(addressing_mode)
                Indirect:begin
                            casez(opcode)
                            5'b00???:begin
                                        mux1_sel = 2'b01;
                                        ALU_enable = 1'b1;
                                        ALU_out_enable = 1'b1;
                                        Next_state = Execute2;
                                     end
                            endcase
                         end
                Direct:begin
                        casez(opcode)
                        5'b01???:begin
                                    ALU_enable = 1'b1;
                                    ALU_out_enable = 1'b1;
                                    PC_enable = 1'b0;
                                    
                                    Next_state = Execute2;
                                 end 
                        5'b10???:begin
                                    Shifter_enable=1'b1;
                                    ALU_enable = 1'b1;
                                    ALU_out_enable = 1'b1;
                                    mux2_sel = 2'b00;
                                    Reg_Write_enable = 1'b1;
                                    Next_state = Fetch;
                                 end                                       
                        5'b00???:begin
                                    ALU_enable = 1'b1;
                                    ALU_out_enable = 1'b1;
                                    mux2_sel = 2'b00;
                                    Reg_Write_enable = 1'b1;
                                    Next_state = Fetch;
                                 end 
                        5'b01010:begin
                                    Zero_flag_enable=1'b1;
                                    Next_state = Wait3;
                                 end
                        5'b11000:begin
                                    
                                    mux1_sel = 2'b01;
                                    mux2_sel = 2'b01;
                                    Reg_Write_enable = 1'b1;
                                    Next_state = Fetch;
                                 end
                        5'b11001:begin
                                    ALU_enable = 1'b1;
                                    ALU_out_enable = 1'b1;
                                    mux2_sel = 2'b00;
                                    Datamem_enable_write = 1'b1;
                                    Next_state = Fetch;
                                 end 
                                
                        endcase
                   end
                Immediate:begin
                        
                        casez(opcode)
                            5'b00???:begin
                                        PC_op = 2'b00;
                                        Next_state = Execute2;                           
                                     end
                            5'b01010:begin
                                        PC_op = 2'b00;
                                        IR_enable=1'b1;
                                        Next_state = Execute2;                                       
                                     end
                            5'b11011:begin
                                        PC_op = 2'b00;
                                        IR_enable=1'b1;
                                        Next_state = Execute2;                                        
                                     end
                            5'b11000:begin
                                        PC_op = 2'b00;
                                        IR_enable=1'b1;
                                        Next_state = Execute2;
                            
                                     end
                        
                            default:begin
                                    Next_state = Fetch;
                                    end
                        endcase
                          end
            default:begin
                        Next_state = Fetch;
                    end
            endcase
            end 
    
    Execute2:begin
            case(addressing_mode)
                Direct:begin
                            casez(opcode)
                            5'b01???:begin
                                        Next_state = Wait3;
                                     end
                            endcase
                       end
                Indirect:begin
                            casez(opcode)
                            5'b00???:begin
                                        mux2_sel = 2'b00;
                                        Reg_Write_enable = 1'b1;
                                        Next_state = Fetch;
                                     end
                            endcase
                     end

                Immediate:begin
                                
                        casez(opcode)
                            5'b00???:begin
                                        mux1_sel = 2'b10;
                                        ALU_enable = 1'b1;
                                        IR_control_enable = 1'b0;
                                        ALU_out_enable = 1'b1;
                                        Next_state = Wait3;
                                     end
                            5'b01010:begin
                                        IR_control_enable = 1'b0;
                                        mux1_sel = 2'b10;
                                        ALU_enable = 1'b1;
                                        ALU_out_enable = 1'b1;
                                        Zero_flag_enable=1'b0;
                                        Next_state = Wait3;
                                     end
                            5'b11011:begin
                                        IR_control_enable = 1'b0;
                                        mux1_sel = 2'b10;
                                        PC_enable = 1'b1;
                                        PC_op = 2'b11;
                                        Next_state = Wait3;
                                     end
                            5'b11000:begin
                                        IR_control_enable = 1'b0;
                                        mux1_sel = 2'b10;
                                        mux2_sel = 2'b01;
                                        Reg_Write_enable = 1'b1;
                                        Next_state = Wait3;    
                                     end
                        
                            default:begin
                                        Next_state = Fetch;
                                    end
                        endcase
                          end
            default:begin
                        Next_state = Fetch;
                    end
            endcase
             end
      
     endcase
    end
    
    
endmodule
