`timescale 1ns / 1ps
`include "para.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 11:39:24
// Design Name: 
// Module Name: MUX_option
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


module MUX_option(
    input [2:0]Option_Mode,
    input [31:0]RF_RD1,
    input [31:0]RF_RD2,
    input [31:0]IM_10_6,
    input [31:0]Extend_number,
    output reg [31:0]Option_1,
    output reg [31:0]Option_2
    );

    always@*
		begin
			case(Option_Mode)
				`Option_Mode0: 
					begin 
						Option_1 = RF_RD1; 
						Option_2 = RF_RD2; 
					end
				`Option_Mode1: 
					begin 
						Option_1 = IM_10_6; 
						Option_2 = RF_RD2; 
					end
				`Option_Mode2: 
					begin 
						Option_1 = RF_RD1; 
						Option_2 = Extend_number; 
					end
				`Option_Mode3: 
					begin 
						Option_1 = 32'h10; 
						Option_2 = Extend_number; 
					end
				`Option_Mode4: 
                    begin 
                        Option_1 = RF_RD1; 
                        Option_2 = 32'b0; 
                    end
			endcase
		end
		
endmodule
