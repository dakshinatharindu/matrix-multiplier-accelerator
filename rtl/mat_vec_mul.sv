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


module mat_vec_mul #(
    parameter DATA_WIDTH = 8,
    parameter MAT_ROW = 4,
    parameter MAT_COL = 4
)(
    input   logic                   clk,
    input   logic [DATA_WIDTH-1:0]  mat     [0:MAT_ROW-1][0:MAT_COL-1],
    input   logic [DATA_WIDTH-1:0]  vec     [0:MAT_COL-1],
    output  logic [DATA_WIDTH-1:0]  res     [0:MAT_ROW-1]
    );

    logic [DATA_WIDTH-1:0]  temp     [0:MAT_ROW-1];

    always_comb begin : blockName
        for (int i = 0; i < MAT_ROW; i++) begin
            temp[i] = 0;
            for (int j = 0; j < MAT_COL; j++) begin
                temp[i] = temp[i] + mat[i][j] * vec[j];
            end
        end
    end

    always @(posedge clk) begin
        res <= temp;
    end
    
endmodule
