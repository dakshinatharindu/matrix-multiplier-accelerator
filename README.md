# Matrix Multiplication Accelerator

## Introduction
This is a matrix multiplication accelerator implemented in Xilinz Zynq Soc. This is a self-learning project for me to learn how to use Vivado and Vitis for SoC design. The accelerator is implemented in the PL part of the SoC, and the host program is implemented in the PS part of the SoC. The host program is written in C and the accelerator is written in Verilog and SystemVerilog. The host program is compiled by Vitis and the accelerator is synthesized by Vivado. The host program and the accelerator are connected by AXI4-LITE interface. The host program gets the input matrices from external UART and sends them to the accelerator. The accelerator calculates the result and sends it back to the host program then the host program sends the result to external UART. A python script is written to send the input matrices to the host program and receive the result from the host program through UART.

## RTL Design
The RTL design of the accelerator is shown below. 
![alt text](https://github.com/dakshinatharindu/matrix-multiplier-accelerator/blob/main/images/schematic.pdf)