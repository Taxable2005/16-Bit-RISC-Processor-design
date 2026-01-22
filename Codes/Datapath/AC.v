`timescale 1ns / 1ps

module AC(
    input clk,
    input reset,
    input [15:0] AC_input,
    output [15:0] AC_output,
    input AC_enable
);
    reg [15:0] AC;

    always @(posedge clk) begin
        if (reset)
            AC <= 16'b0;
        else if (AC_enable)
            AC <= AC_input;
    end

    assign AC_output = AC;
endmodule
