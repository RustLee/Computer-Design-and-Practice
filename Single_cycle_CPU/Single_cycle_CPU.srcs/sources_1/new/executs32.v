`timescale 1ns / 1ps
`include "para.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/08 11:38:46
// Design Name: 
// Module Name: executs32
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


module executs32(
    input [3:0]option,
    input [31:0]pre,
    input [31:0]post,
    output reg [31:0]result,
    output reg [1:0]zero
    );
    always@ *
        begin
            if(result == 0)
                begin
                    zero = 2'b00;
                end
            else if(result > 0)
                begin
                    zero = 2'b01;
                end
            else 
                begin
                    zero = 2'b10;
                end
        end
    always@ *
        begin
            case(option)
                `Add:
                    result = pre + post;
                `Sub:
                    result = pre - post;
                `Sll:
                    result = post << pre;
                `Srl:
                    result = post >> pre;
                `Sra:
                    result = ($signed(post)) >>> pre;
                `And:
                    result = pre & post;
                `Or:
                    result = pre | post;
                `Xor:
                    result = pre ^ post;
                `Nor:
                    result = ~(pre | post);  
            endcase
        end                                                                                                                                                             
endmodule
