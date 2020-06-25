`timescale 1ns / 1ps
`include "para.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 11:55:37
// Design Name: 
// Module Name: control32
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

module control32(
    input clk,
    input [31:0]Instruction,
    input [1:0]zero,
    output reg [3:0]option_ALU,
    output reg [2:0]Mode_ALU,
    output reg [2:0]Mode_reg,
    output reg [2:0]Sel_NPC,
    output reg WriteMem,
    output reg Sel_signed
    );


    wire [5:0]op = Instruction[31:26];
    wire [4:0]rs = Instruction[25:21];
    wire [4:0]rt = Instruction[20:16];
    wire [4:0]rd = Instruction[15:10];
    wire [4:0]shamt = Instruction[10:6];
    wire [5:0]funct = Instruction[5:0];
    wire [15:0]imm16 = Instruction[15:0];
    wire [25:0]imm26 = Instruction[25:0];


    always @ *
		begin
			case(op)
				6'b000000:
					begin
						case (funct)
							`Instruction_Add:  
								begin 
									option_ALU = `Add;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Addu: 
								begin 
									option_ALU = `Add;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others;
									WriteMem = 0; 
									Sel_signed = 0; 
								end 
							`Instruction_Sub:  
								begin 
									option_ALU = `Sub;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Subu: 
								begin 
									option_ALU = `Sub;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_And:  
								begin 
									option_ALU = `And;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Or:   
								begin 
									option_ALU = `Or;   
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Xor:  
								begin 
									option_ALU = `Xor;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Nor:  
								begin 
									option_ALU = `Nor;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Slt:  
								begin 
									option_ALU = `Sub;  
									Mode_reg = zero == 2'b10 ? `Reg_Mode1 : `Reg_Mode2; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Sltu: 
								begin 
									option_ALU = `Sub;  
									Mode_reg = zero == 2'b10 ? `Reg_Mode1 : `Reg_Mode2; 
									Mode_ALU = `Option_Mode0; Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Sll:  
								begin 
									if(Instruction[31:0]==0)
									begin
										Sel_NPC = `Others; 
										WriteMem = 0; 
										Mode_reg = `Reg_Mode6;
									end
									else
									begin
										option_ALU = `Sll;  
										Mode_reg = `Reg_Mode0; 
										Mode_ALU = `Option_Mode1; 
										Sel_NPC = `Others; 
										WriteMem = 0; 
										Sel_signed = 0; 
									end
								end
							`Instruction_Srl:  
								begin 
									option_ALU = `Srl;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode1; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Sra:  
								begin 
									option_ALU = `Sra;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode1; 
									Sel_NPC = `Others; WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Sllv: 
								begin 
									option_ALU = `Sll;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Srlv: 
								begin 
									option_ALU = `Srl;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Srav: 
								begin 
									option_ALU = `Sra;  
									Mode_reg = `Reg_Mode0; 
									Mode_ALU = `Option_Mode0; 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Sel_signed = 0; 
								end
							`Instruction_Jr:
								begin 
									Sel_NPC = `Jr; 
									Mode_reg = `Reg_Mode6; 
									WriteMem = 0; 
								end
							default:    
								begin 
									Sel_NPC = `Others; 
									WriteMem = 0; 
									Mode_reg = `Reg_Mode6;
								end
						endcase
					end
				`Instruction_Addi:  
					begin 
						option_ALU = `Add;  
						Mode_reg = `Reg_Mode3; 
						Mode_ALU = `Option_Mode2; 
						Sel_NPC = `Others; 
						WriteMem = 0; 
						Sel_signed = 1; 
					end
				`Instruction_Addiu: 
					begin 
						option_ALU = `Add;  
						Mode_reg = `Reg_Mode3; 
						Mode_ALU = `Option_Mode2; 
						Sel_NPC = `Others; 
						WriteMem = 0; 
						Sel_signed = 1; 
					end
				`Instruction_Andi:  
					begin 
						option_ALU = `And;  
						Mode_reg = `Reg_Mode3; 
						Mode_ALU = `Option_Mode2; 
						Sel_NPC = `Others; 
						WriteMem = 0; 
						Sel_signed = 0; 
					end
				`Instruction_Ori:   
					begin 
						option_ALU = `Or;   
						Mode_reg = `Reg_Mode3; 
						Mode_ALU = `Option_Mode2; 
						Sel_NPC = `Others; 
						WriteMem = 0; 
						Sel_signed = 0; 
					end
				`Instruction_Xori:  
					begin 
						option_ALU = `Xor;  
						Mode_reg = `Reg_Mode3; 
						Mode_ALU = `Option_Mode2; 
						Sel_NPC = `Others; 
						WriteMem = 0; 
						Sel_signed = 0; 
					end
				`Instruction_Sltiu: 
					begin 
						option_ALU = `Sub;  
						Mode_reg = zero == 2'b10 ? `Reg_Mode1 : `Reg_Mode2; 
						Mode_ALU = `Option_Mode2; Sel_NPC = `Others; 
						WriteMem = 0; 
						Sel_signed = 0; 
					end
				`Instruction_Lui:   
					begin 
						option_ALU = `Sll;  
						Mode_reg = `Reg_Mode3; 
						Mode_ALU = `Option_Mode3; 
						Sel_NPC = `Others; 
						WriteMem = 0; 
						Sel_signed = 0; 
					end 
				`Instruction_Lw:    
					begin 
						option_ALU = `Add;  
						Mode_reg = `Reg_Mode4; 
						Mode_ALU = `Option_Mode2; 
						Sel_NPC = `Others; 
						WriteMem = 0; 
						Sel_signed = 1; 
					end   
				`Instruction_Sw:    
					begin 
						option_ALU = `Add;  
						Mode_reg = `Reg_Mode6; 
						Mode_ALU = `Option_Mode2; 
						Sel_NPC = `Others; 
						WriteMem = 1; 
						Sel_signed = 1; 
					end
				`Instruction_Beq:   
					begin 
						option_ALU = `Sub;  
						Mode_reg = `Reg_Mode6; 
						Mode_ALU = `Option_Mode0; 
						Sel_NPC = `Beq;    
						WriteMem = 0; 
						Sel_signed = 1; 
					end
				`Instruction_Bne:   
					begin 
						option_ALU = `Sub;  
						Mode_reg = `Reg_Mode6; 
						Mode_ALU = `Option_Mode0; 
						Sel_NPC = `Bne;    
						WriteMem = 0; 
						Sel_signed = 1; 
					end
				`Instruction_Bgtz:  
					begin 
						option_ALU = `Sub;  
						Mode_reg = `Reg_Mode6; 
						Mode_ALU = `Option_Mode0; 
						Sel_NPC = `Bgtz;   
						WriteMem = 0; 
						Sel_signed = 1; 
					end
				`Instruction_J:     
					begin 
						Mode_reg = `Reg_Mode6; 
						Sel_NPC = `J; 
						WriteMem = 0; 
						Sel_signed = 0; 
					end 
				`Instruction_Jal:   
					begin 
						Mode_reg = `Reg_Mode5; 
						Sel_NPC = `Jal; 
						WriteMem = 0; 
						Sel_signed = 0; 
					end
				default:    
					begin 
						Sel_NPC = `Others; 
						WriteMem = 0; 
						Mode_reg = `Reg_Mode6; 
					end
			endcase
		end
endmodule