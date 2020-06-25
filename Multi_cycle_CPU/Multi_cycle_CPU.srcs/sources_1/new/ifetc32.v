`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/08 10:52:06
// Design Name: 
// Module Name: ifetc32
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


module ifetc32(
    input clock,
    input [31:0]PC,
    input IR_write,
    output reg [31:0]IR 
    );
    wire [31:0]Instruction;
    //∑÷≈‰ 64KB ROM£¨
prgrom instmem(
    .clka(clock), // input wire clka
    .addra(PC[15:2]), // input wire [13 : 0] addra
    .douta(Instruction) // output wire [31 : 0] douta
);
    always@ (posedge clock)
        begin
            if(IR_write)
                begin
                    IR <= Instruction;
                end    
        end
endmodule
