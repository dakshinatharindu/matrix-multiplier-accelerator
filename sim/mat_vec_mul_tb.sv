`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2023 04:27:33 PM
// Design Name: 
// Module Name: mat_vec_mul_tb
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


module mat_vec_mul_tb();

    // local parameters
    parameter DATA_WIDTH = 32;
    parameter MAT_ROW = 4;
    parameter MAT_COL = 4;

    logic                   clk;
    logic [DATA_WIDTH-1:0]  mat     [0:MAT_ROW-1][0:MAT_COL-1];
    logic [DATA_WIDTH-1:0]  vec     [0:MAT_COL-1];
    logic [DATA_WIDTH-1:0]  res     [0:MAT_ROW-1];

    mat_vec_mul #(.DATA_WIDTH(DATA_WIDTH), .MAT_ROW(MAT_ROW), .MAT_COL(MAT_COL))
        dut (
            .clk(clk),
            .mat(mat),
            .vec(vec),
            .res(res)
        );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        $display("Start testbench");
        #10;

        @(posedge clk);
        @(negedge clk);

        for (int k = 0; k < 10; k++) begin
            for (int i = 0; i < MAT_ROW; i++) begin
                for (int j = 0; j < MAT_COL; j++) begin
                    mat[i][j] = $urandom_range(0, 255);
                end
            end

            for (int i = 0; i < MAT_COL; i++) begin
                vec[i] = $urandom_range(0, 255);
            end

            #20;
        end
        $finish;

    end


endmodule
