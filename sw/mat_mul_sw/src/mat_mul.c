/******************************************************************************
 *
 * Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Use of the Software is limited solely to applications:
 * (a) running on a Xilinx device, or
 * (b) that interact with a Xilinx device through a bus or interconnect.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
 * OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * Except as contained in this notice, the name of the Xilinx shall not be used
 * in advertising or otherwise to promote the sale, use or other dealings in
 * this Software without prior written authorization from Xilinx.
 *
 ******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include "platform.h"
#include "xbasic_types.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xuartps.h"

#define ROWS_A 2
#define COLS_A 2
#define COLS_B 2

volatile Xuint32 *mat_mul = (Xuint32 *)XPAR_MATRIX_MULTIPLIER_0_S_AXI_BASEADDR;
XUartPs Uart_Ps;

int initUart() {
    XUartPs_Config *Config;
    int Status;

    Config = XUartPs_LookupConfig(XPAR_PS7_UART_1_DEVICE_ID);
    if (NULL == Config) {
        return XST_FAILURE;
    }

    Status = XUartPs_CfgInitialize(&Uart_Ps, Config, Config->BaseAddress);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    XUartPs_SetBaudRate(&Uart_Ps, 115200);

    return XST_SUCCESS;
}

void send_uart(int *C) {
    for (int i = 0; i < ROWS_A * COLS_B; i++) {
        XUartPs_Send(&Uart_Ps, &C[i], 4);
    }
}

u32 recev_word() {
    u32 word = 0;
    u8 byte = 0;
    int i = 0;

    while (i < 4) {
        i += XUartPs_Recv(&Uart_Ps, &byte, 1);
        word = word | (byte << ((i - 1) * 8));
    }
    return word;
}

void recev_matrix(int *A, int rows, int cols) {
    for (int i = 0; i < rows * cols; i++) {
        A[i] = recev_word();
    }
}

void matrix_multiplier(int *A, int *B, int *C) {
    for (int i = 0; i < ROWS_A * COLS_A; i++) {
        *(mat_mul + i) = A[i];
    }

    for (int i = 0; i < COLS_A * COLS_B; i++) {
        *(mat_mul + i + ROWS_A * COLS_A) = B[i];
    }

    for (int i = 0; i < ROWS_A * COLS_B; i++) {
        C[i] = *(mat_mul + i + ROWS_A * COLS_A + COLS_A * COLS_B);
    }
}

int main() {
    init_platform();
    initUart();

    u32 A[ROWS_A * COLS_A];
    u32 B[COLS_A * COLS_B];
    u32 C[ROWS_A * COLS_B];

    while (1) {
        recev_matrix(A, ROWS_A, COLS_A);
        recev_matrix(B, COLS_A, COLS_B);
        matrix_multiplier(A, B, C);
        send_uart(C);
    }

    cleanup_platform();
    return 0;
}
