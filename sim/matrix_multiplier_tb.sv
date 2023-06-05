`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2023 11:57:35 PM
// Design Name: 
// Module Name: matrix_multiplier_tb
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


module matrix_multiplier_tb();
        parameter DATA_WIDTH    = 8;
        parameter ROWS_A        = 2;
        parameter COLS_A        = 2;
        parameter COLS_B        = 2;

        logic clk;
        logic [ROWS_A-1:0][COLS_A-1:0][DATA_WIDTH-1:0] a;
        logic [COLS_A-1:0][COLS_B-1:0][DATA_WIDTH-1:0] b;
        logic [ROWS_A-1:0][COLS_B-1:0][DATA_WIDTH-1:0] c;

        matrix_multiplier #(.DATA_WIDTH(DATA_WIDTH), .ROWS_A(ROWS_A), .COLS_A(COLS_A), .COLS_B(COLS_B)) dut (
                .clk(clk),
                .a(a),
                .b(b),
                .c(c)
        );

        // clock generation
        always begin
                clk = 0;
                #5;
                clk = 1;
                #5;
        end

        initial begin
            #30;
            a = '{'{8'h01, 8'h02}, '{8'h03, 8'h04}};
            b = '{'{8'h05, 8'h06}, '{8'h07, 8'h08}};
            #30;
            $finish();
        end

endmodule
