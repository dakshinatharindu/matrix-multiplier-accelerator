`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2023 11:58:22 AM
// Design Name: 
// Module Name: mat_mul_wrapper
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


module mat_mul_wrapper#(
    parameter DATA_WIDTH = 32,
    parameter ROWS_A = 4,
    parameter COLS_A = 4,
    parameter COLS_B = 4
    )(
    input   logic                                               clk,
    input   logic                                               rstn,
    input   logic   [0:ROWS_A-1][0:COLS_A-1][DATA_WIDTH-1:0]    a,
    input   logic   [0:COLS_A-1][0:COLS_B-1][DATA_WIDTH-1:0]    b,
    output  logic   [0:ROWS_A-1][0:COLS_B-1][DATA_WIDTH-1:0]    c,
    output  logic                                               out_valid,
    input   logic                                               out_ready,
    output  logic                                [31:0]         counter,
    output logic r,
    output logic bu
    );

    logic   [DATA_WIDTH-1:0]    a_i [0:ROWS_A-1][0:COLS_A-1];
    logic   [DATA_WIDTH-1:0]    b_i [0:COLS_A-1][0:COLS_B-1];
    logic   [DATA_WIDTH-1:0]    c_i [0:ROWS_A-1][0:COLS_B-1];

    always_comb begin
        for (int i = 0; i < ROWS_A; i++) begin
            for (int j = 0; j < COLS_A; j++) begin
                a_i[i][j] = a[i][j];
            end
        end
    end

    always_comb begin
        for (int i = 0; i < COLS_A; i++) begin
            for (int j = 0; j < COLS_B; j++) begin
                b_i[i][j] = b[i][j];
            end
        end
    end

    always_comb begin
        for (int i = 0; i < ROWS_A; i++) begin
            for (int j = 0; j < COLS_B; j++) begin
                c[i][j] = c_i[i][j];
            end
        end
    end

    mat_mul #(.DATA_WIDTH(DATA_WIDTH), .ROWS_A(ROWS_A), .COLS_A(COLS_A), .COLS_B(COLS_B)) dut (
        .clk(clk),
        .rstn(rstn),
        .a(a_i),
        .b(b_i),
        .c(c_i),
        .out_valid(out_valid),
        .out_ready(out_ready),
        .counter(counter),
        .r(r),
        .bu(bu)
    );

endmodule
