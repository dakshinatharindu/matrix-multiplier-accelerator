`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2023 11:20:42 PM
// Design Name: 
// Module Name: matrix_multiplier
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


module matrix_multiplier #(
        parameter DATA_WIDTH    = 8,
        parameter ROWS_A        = 2,
        parameter COLS_A        = 2,
        parameter COLS_B        = 2
    )(
        input logic clk,
        input logic [ROWS_A-1:0][COLS_A-1:0][DATA_WIDTH-1:0] a,
        input logic [COLS_A-1:0][COLS_B-1:0][DATA_WIDTH-1:0] b,
        output logic [ROWS_A-1:0][COLS_B-1:0][DATA_WIDTH-1:0] c    
    );

    logic [ROWS_A-1:0][COLS_B-1:0][DATA_WIDTH-1:0] c_temp;

    // transpose c
    logic [COLS_B-1:0][ROWS_A-1:0][DATA_WIDTH-1:0] c_tr;
    always_ff @(posedge clk) begin
        for (int i = 0; i < ROWS_A; i++) begin
            for (int j = 0; j < COLS_B; j++) begin
                c[i][j] <= c_tr[j][i];
            end
        end
    end

    // transpose b
    logic [COLS_B-1:0][COLS_A-1:0][DATA_WIDTH-1:0] b_tr;
    always_comb begin
        for (int i = 0; i < COLS_B; i++) begin
            for (int j = 0; j < COLS_A; j++) begin
                b_tr[i][j] = b[j][i];
            end
        end
    end

    genvar i;
    for (i = 0; i < COLS_B; i++) begin
        matrix_vector_multiplier #(
            .DATA_WIDTH(DATA_WIDTH),
            .MAT_ROW(ROWS_A),
            .MAT_COL(COLS_A)
        ) mat_vec_mul (
            .mat(a),
            .vec(b_tr[i]),
            .res(c_tr[i])
        );
    end


endmodule
