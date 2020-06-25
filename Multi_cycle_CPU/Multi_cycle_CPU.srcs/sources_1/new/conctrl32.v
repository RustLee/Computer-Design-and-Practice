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
    input reset,
    input [31:0]Instruction,
    input [31:0]NPC,
    output reg [31:0]PC,
    output [31:0]pre_PC, 
    output reg [3:0]option_ALU,
    output reg [2:0]Mode_ALU,
    output [2:0]Mode_REG,
    output [2:0]Mode_Npc,
    output reg WriteMem,
    output reg Sel_signed,
    output reg Sel_IRwrite
    );

    reg Sel_NPC = 0;
    reg [2:0]curr_state = 0;
    reg [2:0]next_state = 0;
	
	reg [2:0]Mode_reg = `Reg_Mode6;
	assign Mode_REG = Mode_reg;
	reg [2:0]Mode_NPC = `Others;
	assign Mode_Npc = Mode_NPC;

    wire [5:0]op = Instruction[31:26];
    wire [4:0]rs = Instruction[25:21];
    wire [4:0]rt = Instruction[20:16];
    wire [4:0]rd = Instruction[15:10];
    wire [4:0]shamt = Instruction[10:6];
    wire [5:0]funct = Instruction[5:0];
    wire [15:0]imm16 = Instruction[15:0];
    wire [25:0]imm26 = Instruction[25:0];

    assign pre_PC = op == `Instruction_Jal ? NPC : PC;
    
    always@ (negedge clk)
        begin 
            if(reset)
                begin
                    PC <= 0;
                end
            else if(Sel_NPC)
                begin    
                    PC <= NPC;
                end
        end
        
	always@(posedge clk)
		begin
			if(reset)
				begin
					curr_state <= 0;
				end
			else
				begin
					curr_state <= next_state;
				end
		end

    always @ *
		begin
		    case(curr_state)
		        `ifetch_state:
					begin
						next_state = `idecode_state;
					end
				`wait_state:
					begin
						next_state = `ifetch_state;
					end
				`idecode_state:
					begin
				        case(op)
							6'b000000: 
								begin 
									if(funct==`Instruction_Jr) 
										begin 
											next_state = `ifetch_state; 
										end 
									else 
										begin 
											next_state = `execute_state; 
										end
									end
							`Instruction_J: 
								begin
									next_state = `ifetch_state;
								end
							`Instruction_Jal: 
								begin 
									next_state = `writeback_state; 
								end
							default: 
								begin 
									next_state = `execute_state; 
								end
							endcase
						end
				`execute_state: 
					begin 
						case(op)
							`Instruction_Beq:    
								next_state = `ifetch_state;
							`Instruction_Bne:
								next_state = `ifetch_state;
							`Instruction_Lw:    
								next_state = `memory_state;
							`Instruction_Sw:   
								next_state = `memory_state;
							default:    
								next_state = `writeback_state;
						endcase
					end
				`memory_state:     
					begin 
						case(op)
							`Instruction_Lw:
								next_state = `writeback_state;
							`Instruction_Sw:
								next_state = `ifetch_state;
							default:   
								next_state = `ifetch_state;
						endcase
					end
				`writeback_state:      
					begin 
						next_state = `ifetch_state;
					end
				default: 
					begin 
						next_state = `ifetch_state; 
					end
			endcase
		end
		
		reg flag = 0;
		always@ *
			begin
				case (curr_state)
					`ifetch_state:  
						begin 
							Sel_IRwrite = 1;
							if(!flag)
								begin
									Sel_NPC = 0;
									flag = 1;
								end
							else
								begin
									Sel_NPC=1;
								end
							Mode_reg = `Reg_Mode6; //不写寄存器
							WriteMem = 0;
						end
					`wait_state: 
						begin 
							Sel_IRwrite=0; 
							Sel_NPC=0;
							Mode_reg = `Reg_Mode6; //不写寄存器
							WriteMem = 0;
						end
					`idecode_state:
						begin 
							Sel_IRwrite=0; 
							//Sel_NPC=0;
							Mode_reg = `Reg_Mode6; //不写寄存器
							WriteMem = 0;
							case(op)
							6'b000000:
								begin
									if(funct==`Instruction_Jr) 
										begin 
											Mode_NPC = `Jr; 
										end
									else 
										begin 
											Mode_NPC = `Others;
											Sel_NPC=0;
										end
								end
							`Instruction_J:     
								begin  
									Mode_NPC = `J; 
									Sel_NPC=0; 
								end 
							`Instruction_Jal:   
								begin  
									Mode_NPC = `Jal; 
								end
							default:    
								begin  
									Mode_NPC = `Others;
									Sel_NPC=0; 
								end
							endcase
						end
					`execute_state: 
						begin 
							Sel_IRwrite=0; 
							Sel_NPC=0;
							Mode_reg = `Reg_Mode6; //不写寄存器
							WriteMem = 0;
							case(op)
								6'b000000:
									begin
										case (funct)
											`Instruction_Add:  
												begin 
													option_ALU = `Add;  
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_Addu: 
												begin 
													option_ALU = `Add;  
													Mode_ALU = `Option_Mode0;
												end 
											`Instruction_Sub:  
												begin 
													option_ALU = `Sub;  
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_Subu: 
												begin 
													option_ALU = `Sub;  
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_And:  
												begin 
													option_ALU = `And;  
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_Or:   
												begin 
													option_ALU = `Or;   
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_Xor:  
												begin 
													option_ALU = `Xor;  
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_Nor:  
												begin 
													option_ALU = `Nor;  
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_Slt:  
												begin 
													option_ALU = `Sub;  
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_Sltu: 
												begin 
													option_ALU = `Sub;  
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_Sll:  
												begin 
													option_ALU = `Sll;  
													Mode_ALU = `Option_Mode1;
												end
											`Instruction_Srl:  
												begin 
													option_ALU = `Srl;  
													Mode_ALU = `Option_Mode1;
												end
											`Instruction_Sra:  
												begin 
													option_ALU = `Sra;  
													Mode_ALU = `Option_Mode1;
												end
											`Instruction_Sllv: 
												begin 
													option_ALU = `Sll;  
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_Srlv: 
												begin 
													option_ALU = `Srl;  
													Mode_ALU = `Option_Mode0;
												end
											`Instruction_Srav: 
												begin 
													option_ALU = `Sra;  
													Mode_ALU = `Option_Mode0;
												end
											default:   
												begin 
												end
										endcase
									end
								`Instruction_Addi:  
									begin 
										option_ALU = `Add; 
										Mode_ALU = `Option_Mode2; 
										Sel_signed = 1; 
									end
								`Instruction_Addiu: 
									begin 
										option_ALU = `Add; 
										Mode_ALU = `Option_Mode2; 
										Sel_signed = 1; 
									end
								`Instruction_Andi:  
									begin 
										option_ALU = `And; 
										Mode_ALU = `Option_Mode2; 
										Sel_signed = 0; 
									end
								`Instruction_Ori:   
									begin 
										option_ALU = `Or;  
										Mode_ALU = `Option_Mode2; 
										Sel_signed = 0; 
									end
								`Instruction_Xori:  
									begin 
										option_ALU = `Xor; 
										Mode_ALU = `Option_Mode2; 
										Sel_signed = 0; 
									end
								`Instruction_Sltiu: 
									begin 
										option_ALU = `Sub; 
										Mode_ALU = `Option_Mode2; 
										Sel_signed = 0; 
									end
								`Instruction_Lui:   
									begin 
										option_ALU = `Sll; 
										Mode_ALU = `Option_Mode3; 
										Sel_signed = 0; 
									end //将立即数左移16位
								`Instruction_Lw:    
									begin 
										option_ALU = `Add; 
										Mode_ALU = `Option_Mode2; 
										Sel_signed = 1; 
									end   
								`Instruction_Sw:    
									begin 
										option_ALU = `Add; 
										Mode_ALU = `Option_Mode2; 
										Sel_signed = 1; 
									end
								`Instruction_Beq:   
									begin 
										option_ALU = `Sub; 
										Mode_ALU = `Option_Mode0; 
										Mode_NPC = `Beq; 
										Sel_signed = 1; 
										Sel_NPC=0;
									end
								`Instruction_Bne:   
									begin 
										option_ALU = `Sub; 
										Mode_ALU = `Option_Mode0; 
										Mode_NPC = `Bne; 
										Sel_signed = 1; 
										Sel_NPC=0;
									end
								`Instruction_Bgtz:  
									begin 
										option_ALU = `Sub; 
										Mode_ALU = `Option_Mode0; 
										Mode_NPC = `Bgtz;
										Sel_signed = 1; 
										Sel_NPC=0;
									end
								default:    
									begin 
										Sel_NPC=0; 
									end
							endcase
						end
					`memory_state:     
						begin 
							Sel_IRwrite=0; 
							Sel_NPC=0;
							Mode_reg = `Reg_Mode6; //不写寄存器
							case (op)
								`Instruction_Sw:  
									begin 
										WriteMem = 1; 
									end
								default: 
									WriteMem = 0;
							endcase
						end
					`writeback_state:      
						begin 
							Sel_IRwrite=0; 
							Sel_NPC=0;
								   case(op)
									6'b000000:
										begin
											case (funct)
												`Instruction_Slt:  
													begin 
														Mode_reg = `Reg_Mode2; 
													end
												`Instruction_Sltu: 
													begin 
														Mode_reg = `Reg_Mode2; 
													end
												`Instruction_Sll:  
													begin 
														if(Instruction[31:0]==0)
															begin
																Mode_reg = `Reg_Mode6;
															end
														else
															begin
																Mode_reg = `Reg_Mode0;  
															end
													end
												`Instruction_Jr:   
													begin  
														Mode_reg = `Reg_Mode6; 
													end //jr不需要考虑ALU的运算情况, 因为用不到
												default:    
													begin  
														Mode_reg = `Reg_Mode0;
													end
											endcase
										end
									`Instruction_Sltiu: 
										begin  
											Mode_reg = `Reg_Mode1;  
										end
									`Instruction_Lw:    
										begin  
											Mode_reg = `Reg_Mode4;  
										end   
									`Instruction_Sw:    
										begin  
											Mode_reg = `Reg_Mode6;  
										end
									`Instruction_Beq:   
										begin  
											Mode_reg = `Reg_Mode6;  
										end
									`Instruction_Bne:   
										begin  
											Mode_reg = `Reg_Mode6;  
										end
									`Instruction_Bgtz:  
										begin  
											Mode_reg = `Reg_Mode6;  
										end
									`Instruction_J:     
										begin  
											Mode_reg = `Reg_Mode6;  
										end 
									`Instruction_Jal:   
										begin  
											Mode_reg = `Reg_Mode5;  
										end//regmode5是把{PC+4}写到$31里
									default:    
										begin  
											Mode_reg = `Reg_Mode3; 
										end
									endcase
						end
					default: begin Sel_NPC=0;  end
				endcase
			end		
		
endmodule