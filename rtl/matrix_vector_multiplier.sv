`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2023 11:07:02 AM
// Design Name: 
// Module Name: mat_vec_mul
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


module matrix_vector_multiplier #(
        parameter DATA_WIDTH = 8,
        parameter MAT_ROW = 2,
        parameter MAT_COL = 2
    )(
        input   logic   [MAT_ROW-1:0][MAT_COL-1:0][DATA_WIDTH-1:0]  mat,
        input   logic   [MAT_COL-1:0][DATA_WIDTH-1:0]               vec,
        output  logic   [MAT_ROW-1:0][DATA_WIDTH-1:0]               res     
    );

    always_comb begin
        for (int i = 0; i < MAT_ROW; i++) begin
            res[i] = 0;
            for (int j = 0; j < MAT_COL; j++) begin
                res[i] = res[i] + mat[i][j] * vec[j];
            end
        end
    end
    
endmodule
