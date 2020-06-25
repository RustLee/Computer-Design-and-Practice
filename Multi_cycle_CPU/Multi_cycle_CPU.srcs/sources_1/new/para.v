//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/08 11:50:36
// Design Name: 
// Module Name: para
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


`define     Add     4'd1
`define     Sub     4'd2
`define     Sll     4'd3
`define     Srl     4'd4
`define     Sra     4'd5
`define     And     4'd6
`define     Or     4'd7
`define     Xor     4'd8
`define     Nor     4'd9

`define     Jr     3'd0
`define     J     3'd1 
`define     Jal     3'd1 
`define     Beq     3'd2 
`define     Bne     3'd3 
`define     Bgtz     3'd3
`define     Others     3'd4  

`define	Option_Mode0 	3'b000
`define 	Option_Mode1 	3'b001
`define 	Option_Mode2 	3'b010
`define 	Option_Mode3 	3'b011
`define 	Option_Mode4 	3'b100

`define 	Reg_Mode0 	3'b000
`define 	Reg_Mode1 	3'b001
`define 	Reg_Mode2 	3'b010
`define 	Reg_Mode3 	3'b011
`define 	Reg_Mode4 	3'b100
`define 	Reg_Mode5 	3'b101
`define 	Reg_Mode6 	3'b110
`define 	Reg_Mode7 	3'b111

`define    Instruction_Add    6'b100000
`define    Instruction_Addu    6'b100001
`define    Instruction_Sub    6'b100010
`define    Instruction_Subu    6'b100011
`define    Instruction_And    6'b100100
`define    Instruction_Or    6'b100101
`define    Instruction_Xor    6'b100110
`define    Instruction_Nor    6'b100111
`define    Instruction_Slt    6'b101010
`define    Instruction_Sltu    6'b101011
`define    Instruction_Sll    6'b000000
`define    Instruction_Srl    6'b000010
`define    Instruction_Sra    6'b000011
`define    Instruction_Sllv    6'b000100
`define    Instruction_Srlv    6'b000110
`define    Instruction_Srav    6'b000111
`define    Instruction_Jr    6'b001000
`define    Instruction_Addi    6'b001000
`define    Instruction_Addiu    6'b001001
`define    Instruction_Andi    6'b001100
`define    Instruction_Ori    6'b001101
`define    Instruction_Xori    6'b001110
`define    Instruction_Sltiu    6'b001011
`define    Instruction_Lui    6'b001111
`define    Instruction_Lw    6'b100011
`define    Instruction_Sw    6'b101011
`define    Instruction_Beq    6'b000100
`define    Instruction_Bne    6'b000101
`define    Instruction_Bgtz    6'b000111
`define    Instruction_J    6'b000010
`define    Instruction_Jal    6'b000011

`define    init_state		3'b000
`define    ifetch_state 	3'b001
`define    idecode_state		3'b010
`define    execute_state	3'b011
`define    memory_state     3'b100
`define    writeback_state  3'b101
`define    wait_state       3'b110