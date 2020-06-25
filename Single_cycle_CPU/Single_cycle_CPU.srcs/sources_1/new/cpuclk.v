`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/08 16:45:27
// Design Name: 
// Module Name: Cpu_clk
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


module Cpu_clk(
    input clk_in1,
    output clk_out1
    );
    cpuclk UCLK(
        .clk_in1(clk_in1),
        .clk_out1(clk_out1)
    );
endmodule
