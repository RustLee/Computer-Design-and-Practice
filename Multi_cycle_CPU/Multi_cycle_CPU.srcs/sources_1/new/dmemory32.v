`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/08 10:55:55
// Design Name: 
// Module Name: dmemory32
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


module dmemory32(read_data,address,write_data,Memwrite,clock);
    output[31:0] read_data; // 从存储器中获得的数据
    input[31:0] address; //来自 memorio 模块，源头是来自执行单元算出的
    //alu_result
    input[31:0] write_data; //来自译码单元的 read_data2
    input Memwrite; //来自控制单元
    input clock;

    wire clk;
    assign clk = !clock; // 因为使用芯片的固有延迟，RAM 的地址
//线来不及在时钟上升沿准备好, 使得时钟上升沿数据读出有误，
//所以采用反相时钟，使得读出数据比地址准备好要晚大约半个时钟，从而得到正确地址。

// 分配 64KB RAM
ram ram (
    .clka(clk), // input wire clka
    .wea(Memwrite), // input wire [0 : 0] wea
    .addra(address[15:2]), // input wire [13 : 0] addra
    .dina(write_data), // input wire [31 : 0] dina
    .douta(read_data) // output wire [31 : 0] douta
);

endmodule
