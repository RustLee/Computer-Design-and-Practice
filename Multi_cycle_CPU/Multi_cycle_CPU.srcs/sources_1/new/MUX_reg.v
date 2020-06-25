`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 11:55:37
// Design Name: 
// Module Name: MUX_reg
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


module MUX_reg(
    input [2:0]Reg_Mode,
    input [1:0]zero,
    input [4:0]IMD_20_16,
    input [4:0]IMD_15_11,
    output reg [4:0]WriteAddr,
    
    input [31:0]WD_ALU,
    input [31:0]WD_DMRD,
    input [31:0]WD_NPC,
    output reg [31:0]WD,
    output reg WD_sel
    );

    always@*
        begin
            case(Reg_Mode)
                `Reg_Mode0: 
                    begin 
                        WriteAddr = IMD_15_11; 
                        WD = WD_ALU; 
                        WD_sel = 1; 
                    end
                `Reg_Mode1: 
                    begin 
                        WriteAddr = IMD_20_16; 
                        WD_sel = 1; 
                        if (zero == 2'b10)
                            begin
                                WD = 32'b1;
                            end
                        else
                            begin
                                WD = 32'b0;
                            end
                    end
                `Reg_Mode2: 
                begin 
                    WriteAddr = IMD_15_11;
                    if (zero == 2'b10)
                        begin
                            WD = 32'b1;
                        end
                    else
                        begin
                            WD = 32'b0;
                        end                    
                    WD_sel = 1; 
                end
                `Reg_Mode3: 
                    begin 
                        WriteAddr = IMD_20_16; 
                        WD = WD_ALU;
                        WD_sel = 1; 
                    end
                `Reg_Mode4: 
                    begin 
                        WriteAddr = IMD_20_16; 
                        WD = WD_DMRD; 
                        WD_sel = 1; 
                    end 
                `Reg_Mode5: 
                    begin 
                        WriteAddr = 5'b11111; 
                        WD = WD_NPC;
                        WD_sel = 1; 
                    end
                `Reg_Mode6: 
                    begin 
                        WD_sel = 0;
                    end
            endcase
        end

endmodule
