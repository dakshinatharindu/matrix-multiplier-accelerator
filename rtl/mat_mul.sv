`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: DT
// Engineer: Dakshina Tharindu 
// 
// Create Date: 05/31/2023 09:27:32 PM
// Design Name: Matrix Multiplier
// Module Name: mat_mul
// Project Name: 
// Target Devices: Zybo Z7-20
// Tool Versions: 2023.1
// Description: AXI4 Lite Matrix Multiplier
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mat_mul #(
    parameter DATA_WIDTH = 32,
    parameter ROWS_A = 4,
    parameter COLS_A = 4,
    parameter COLS_B = 4
    )(
    input   logic                       clk,
    input   logic                       rstn,
    input   logic   [DATA_WIDTH-1:0]    a       [0:ROWS_A-1][0:COLS_A-1],
    input   logic   [DATA_WIDTH-1:0]    b       [0:COLS_A-1][0:COLS_B-1],
    output  logic   [DATA_WIDTH-1:0]    c       [0:ROWS_A-1][0:COLS_B-1],
    output  logic                       out_valid,
    input   logic                       out_ready,
    output  logic                                [31:0]         counter,
    output  logic r,
    output logic bu
    );
    

    logic   [DATA_WIDTH-1:0]    a_copy      [0:ROWS_A-1][0:COLS_A-1];
    logic   [DATA_WIDTH-1:0]    b_tr_copy   [0:COLS_B-1][0:COLS_A-1];
    logic   [DATA_WIDTH-1:0]    vec_res     [0:ROWS_A-1];
    logic                       ready;
    logic                       buff_filled;

    assign r = ready;
    assign bu = buff_filled;

    always_ff @(posedge clk) begin
        if (!rstn) begin
            ready <= 1'b1;
            buff_filled <= 1'b0;
        end
        else begin
            if (ready && !buff_filled) begin
                a_copy <= a;
                ready <= 1'b0;
                for ( int i = 0; i < COLS_B; i++ ) begin
                    for ( int j = 0; j < COLS_A; j++ ) begin
                        b_tr_copy[i][j] <= b[j][i];
                    end
                end
            end
        end
    end


    mat_vec_mul #(.DATA_WIDTH(DATA_WIDTH), .MAT_ROW(ROWS_A), .MAT_COL(COLS_A))
        dut (
            .clk(clk),
            .mat(a_copy),
            .vec(b_tr_copy[0]),
            .res(vec_res)
        );
    
    always_ff @( posedge clk ) begin
        for ( int i = 0; i < ROWS_A; i++ ) begin
            c[i][COLS_B-1] <= vec_res[i];
        end
    end

    always_ff @( posedge clk ) begin
        for ( int i = 1; i < COLS_B; i++ ) begin
            if (!ready & !buff_filled) begin
                b_tr_copy[i-1] <= b_tr_copy[i];
            end
        end
    end

    always_ff @( posedge clk ) begin
        for ( int i = 0; i < ROWS_A; i++ ) begin
            for ( int j = 1; j < COLS_B; j++ ) begin
                if (!rstn) begin
                    c[i][j] <= 0;
                end
                else if (!ready & !buff_filled)begin
                    c[i][j-1] <= c[i][j];
                end
            end
        end
    end

    // counter to count the number of cycles
    logic [$clog2(COLS_B)+1:0]    count;
    always_ff @( posedge clk ) begin
        if (!rstn) begin
            count <= 0;
        end
        else if (!ready) begin
            count <= count + 1;
        end
        else begin
            count <= 0;
        end
    end

    always_ff @( posedge clk ) begin
        if (count == COLS_B) begin
            buff_filled <= 1'b1;        
        end
    end

    assign out_valid = buff_filled;

    always_ff @( posedge clk ) begin
        if (buff_filled & out_ready) begin
            buff_filled <= 1'b0;
            ready <= 1'b1;
        end
    end

    always_ff @(posedge clk) begin
        if (rstn == 0) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end

    

    
endmodule
