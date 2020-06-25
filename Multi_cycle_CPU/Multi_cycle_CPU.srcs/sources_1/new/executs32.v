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
    input clk,
    input [3:0]option,
    input [31:0]pre,
    input [31:0]post,
    output reg [31:0]result,
    output reg [1:0]zero
    );
    reg [31:0]temp_result;
    reg [1:0]temp_zero;
    always@ *
        begin
            if(result == 0)
                begin
                    zero = 2'b00;
                end
            else if(result[31] == 0)
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
					begin
						result = pre + post;
					end
                `Sub:
					begin
						result = pre - post;
					end
                `Sll:
					begin
						result = post << pre;
					end
                `Srl:
					begin
						result = post >> pre;
					end
                `Sra:
					begin
						result = ($signed(post)) >>> pre;
					end
                `And:
					begin
						result = pre & post;
					end
                `Or:
					begin
						result = pre | post;
					end
                `Xor:
					begin
						result = pre ^ post;
					end
                `Nor:
					begin
						result = ~(pre | post);  
					end
            endcase
        end                                                                                                                                                             
endmodule
