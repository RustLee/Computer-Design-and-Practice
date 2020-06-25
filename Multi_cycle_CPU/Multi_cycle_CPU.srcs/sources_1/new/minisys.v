`timescale 1ns / 1ps
`include "para.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 11:55:37
// Design Name: 
// Module Name: minisys
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

module minisys(
    input fpga_rst,
    input fpga_clk    
    );
    
    wire [31:0]debug_wb_pc;
    wire debug_wb_rf_wen;
    wire [4:0] debug_wb_rf_wnum;
    wire[31:0] debug_wb_rf_wdata;
	
    wire WriteMem;
    wire clock;
	wire Sel_WD;
	wire Sign_Sel;
	wire IR_write;
	wire [1:0]zero;
	wire [2:0]Option_Mode;
    wire [2:0]Sel_NPC;       
    wire [2:0]Mode_reg;
	wire [3:0]option_ALU;
    wire [4:0]WriteAddr;    
    wire [31:0]RF_RD1;
    wire [31:0]RF_RD2;
    wire [31:0]result;
    wire [31:0]option_pre;
    wire [31:0]option_post;
    wire [31:0]Extend_number;
    wire [31:0]reg31;
	wire [31:0]Instruction;
	wire [31:0]read_data;
	wire [31:0]NPC;
	wire [31:0]PC;
    wire [31:0]PC_4;
	wire [31:0]WD;
    
    assign debug_wb_rf_wen = Sel_WD;
    assign debug_wb_rf_wnum = WriteAddr;
    assign debug_wb_rf_wdata = WD;
	
	ifetc32 TK_ins(
    clock,
    PC,
    IR_write,
    Instruction
    );

    Cpu_clk CLK(
    fpga_clk,
    clock
    );
	
    dmemory32 RAM(
    read_data,
    result,
    RF_RD2,
    WriteMem,
    clock
    );
	
    idecode32 PC_NPC(
    clock,
    fpga_rst,
    Sel_NPC,
    PC,
    RF_RD1,
    Instruction,
    zero,
    NPC,
    PC_4
    );
	
    MUX_reg Sel_RG(
    Mode_reg,
    zero,
    Instruction[20:16],
    Instruction[15:11],
    WriteAddr,
    result,
    read_data,
    PC_4,
    WD,
    Sel_WD
    );
	
    Regfile RG(
    clock,
    fpga_rst,
    Instruction[25:21],
    RF_RD1,
    Instruction[20:16],
    RF_RD2,
    WriteAddr,
    WD,
    Sel_WD
    );
	
    MUX_option Sel_ALU(
    Option_Mode,
    RF_RD1,
    RF_RD2,
    Instruction[10:6],
    Extend_number,
    option_pre,
    option_post
    );
	
    executs32 ALU(
    clock,
    option_ALU,
    option_pre,
    option_post,
    result,
    zero
    );
	
    Ext_16_to_32 excend2(
    Instruction[15:0],
    Sign_Sel,
    Extend_number
    );
	
    control32 CTRL(
    clock,
    fpga_rst,
    Instruction,
    NPC,
    PC,
    debug_wb_pc,
    option_ALU,
    Option_Mode,
    Mode_reg,
    Sel_NPC,
    WriteMem,
    Sign_Sel,
    IR_write
    );

endmodule



