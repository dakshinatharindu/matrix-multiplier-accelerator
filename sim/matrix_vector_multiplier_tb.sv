`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2023 10:55:59 PM
// Design Name: 
// Module Name: matrix_vector_multiplier_tb
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


module matrix_vector_multiplier_tb();

    // local parameters
    parameter DATA_WIDTH    = 8;
    parameter MAT_ROW       = 2;
    parameter MAT_COL       = 2;

    // ports
    logic   [MAT_ROW-1:0][MAT_COL-1:0][DATA_WIDTH-1:0]  mat;
    logic   [MAT_COL-1:0][DATA_WIDTH-1:0]               vec;
    logic   [MAT_ROW-1:0][DATA_WIDTH-1:0]               res;

    matrix_vector_multiplier #(
        .DATA_WIDTH(DATA_WIDTH),
        .MAT_ROW(MAT_ROW),
        .MAT_COL(MAT_COL)
    ) dut (
        .mat(mat),
        .vec(vec),
        .res(res)
    );

    initial begin
        #10;

        // test case 1
        mat = '{'{8'h01, 8'h02}, '{8'h03, 8'h04}};
        vec = '{8'h01, 8'h02};

        #10;
        $finish();
    end

endmodule
