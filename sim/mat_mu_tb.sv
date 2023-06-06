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
    parameter DATA_WIDTH = 8;
    parameter ROWS_A = 2;
    parameter COLS_A = 2;
    parameter COLS_B = 2;

    logic                                               clk;
    logic                                               rstn;
    logic   [ROWS_A*COLS_A*DATA_WIDTH-1:0]    a;
	logic   [COLS_A*COLS_B*DATA_WIDTH-1:0]    b;
	logic   [ROWS_A*COLS_B*DATA_WIDTH-1:0]    c;
    logic                                               out_valid;
    logic                                               out_ready;
    logic [DATA_WIDTH-1:0]                              slv_1;
    logic [DATA_WIDTH-1:0]                              slv_2;
    logic [DATA_WIDTH-1:0]                              slv_3;
    logic [DATA_WIDTH-1:0]                              slv_4;
    logic [DATA_WIDTH-1:0]                              slv_5;
    logic [DATA_WIDTH-1:0]                              slv_6;
    logic [DATA_WIDTH-1:0]                              slv_7;
    logic [DATA_WIDTH-1:0]                              slv_8;
    logic [31:0]                                        counter;
    logic r;
    logic bu;

    mat_mul_wrapper #(.DATA_WIDTH(DATA_WIDTH), .ROWS_A(ROWS_A), .COLS_A(COLS_A), .COLS_B(COLS_B)) dut (
        .clk(clk),
        .rstn(rstn),
        .a(a),
        .b(b),
        .c(c),
        .out_valid(out_valid),
        .out_ready(out_ready),
        .counter(counter),
        .r(r),
        .bu(bu)
    );

    assign a = {slv_1, slv_2, slv_3, slv_4};
    assign b = {slv_5, slv_6, slv_7, slv_8};

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        $display("Start testbench");
        #10;
        
        rstn = 0;
        #20;
        rstn = 1;
        #20;

        @(negedge clk);
        slv_1 <= 2;
        slv_2 <= 4;
        slv_3 <= 6;
        slv_4 <= 7;
        slv_5 <= 1;
        slv_6 <= 4;
        slv_7 <= 7;
        slv_8 <= 9;

        
        rstn = 0;
        #20;
        rstn = 1;


        

        #2000;
        $finish;
    end
endmodule
