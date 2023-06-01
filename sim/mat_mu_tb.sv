`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2023 10:15:44 PM
// Design Name: 
// Module Name: mat_mu_tb
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


module mat_mu_tb();

    // local parameters
    parameter DATA_WIDTH = 32;
    parameter ROWS_A = 3;
    parameter COLS_A = 4;
    parameter COLS_B = 1;

    logic                       clk;
    logic                       rstn;
    logic                       in_valid;
    logic   [DATA_WIDTH-1:0]    a [0:ROWS_A-1][0:COLS_A-1];
    logic   [DATA_WIDTH-1:0]    b [0:COLS_A-1][0:COLS_B-1];
    logic   [DATA_WIDTH-1:0]    c [0:ROWS_A-1][0:COLS_B-1];
    logic                       out_valid;
    logic                       out_ready;

    mat_mul #(.DATA_WIDTH(DATA_WIDTH), .ROWS_A(ROWS_A), .COLS_A(COLS_A), .COLS_B(COLS_B)) dut (
        .clk(clk),
        .rstn(rstn),
        .in_valid(in_valid),
        .a(a),
        .b(b),
        .c(c),
        .out_valid(out_valid),
        .out_ready(out_ready)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        $display("Start testbench");
        #10;
        in_valid = 0;
        
        rstn = 0;
        #20;
        rstn = 1;
        #20;

        @(negedge clk);
        for (int i = 0; i < ROWS_A; i++) begin
            for (int j = 0; j < COLS_A; j++) begin
                a[i][j] = $urandom_range(0, 8);
            end
        end

        for (int i = 0; i < COLS_A; i++) begin
            for (int j = 0; j < COLS_B; j++) begin
                b[i][j] = $urandom_range(0, 8);
            end
        end
        in_valid = 1;
        


        

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(negedge clk);
        out_ready = 1;
        for (int i = 0; i < ROWS_A; i++) begin
            for (int j = 0; j < COLS_A; j++) begin
                a[i][j] = $urandom_range(0, 8);
            end
        end

        for (int i = 0; i < COLS_A; i++) begin
            for (int j = 0; j < COLS_B; j++) begin
                b[i][j] = $urandom_range(0, 8);
            end
        end
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $finish;
    end
endmodule
