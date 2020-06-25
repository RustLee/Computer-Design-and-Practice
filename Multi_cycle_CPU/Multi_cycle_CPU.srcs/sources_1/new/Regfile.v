`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 14:41:24
// Design Name: 
// Module Name: Regfile
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

module Regfile(
    input clk,
	input fpga_rst,
	
    input [4:0]rd1,
    output reg [31:0]Regdata1,

    input [4:0]rd2,
    output reg [31:0]Regdata2,

    input [4:0]WriteAddr,
    input [31:0]WD,
    input WDsel
    );

	integer i = 0;
	reg [31:0] imem[31:0];

    always @(negedge clk)
        begin
            Regdata1 <= imem[rd1];
            Regdata2 <= imem[rd2];
        end

	always @(posedge clk)   
	    begin
			if(WDsel)    
				begin
					imem[WriteAddr] <= WD;
				end
			if(fpga_rst)
				begin
					for(i = 0;i <= 31;i = i+1)
						begin
							imem[i]<=0;
						end
				end
		end

endmodule
