`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 14:28:50
// Design Name: 
// Module Name: idecode32
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


module idecode32(
    input clk,
    input reset,
    input [2:0]ModeSel,
    input [31:0]PC,
    input [31:0]Offset,
    input [31:0]Instruction,
    input [1:0]zero,	
    output reg [31:0]NPC,
	output [31:0]PC_4
    );
	
	wire [31:0] PC_ext;
	
	Ext_16_to_32 extend(
	Instruction[15:0],
	1'b1,
	PC_ext
	);
	
    assign PC_4 = PC;
		
    always @*
        begin
            if(reset)
                begin
                    NPC <= 0;
                end
            else
                begin
                    case (ModeSel)
                        `Jr:
                            begin
                                NPC <= Offset;
                            end
                        `J , `Jal:
                            begin
                                NPC <= {4'b0,Instruction[25:0],2'b0};
                            end
                        `Beq:
                            begin
                                NPC <= zero == 2'b00 ? PC + (PC_ext<<2) : PC+4;
                            end
                        `Bne:
                            begin
                                NPC <= zero == 2'b00 ? PC+4 : PC + (PC_ext<<2);
                            end
                        `Bgtz:
                            begin
                                NPC <= zero == 2'b01 ? (PC_ext<<2) : PC+4;
                            end
                        `Others: 
                            begin
                                NPC <= PC+  4;
                            end
                    endcase
                end
        end
endmodule
