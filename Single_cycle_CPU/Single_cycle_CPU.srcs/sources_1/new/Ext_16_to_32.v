`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/08 16:50:31
// Design Name: 
// Module Name: Ext_16_to_32
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


module Ext_16_to_32(
    input [15:0]Immediation,
    input Signed_sign,
    output  [31:0]Extend_number
    );
	reg [31:0]Unsigned_number;
	reg [31:0]Signed_number;
    assign Extend_number = Signed_sign ? Signed_number :Unsigned_number;
    always@ *
        begin
            Unsigned_number = {16'h0000,Immediation};
            if(Immediation[15])
                begin
                    Signed_number = {16'hffff,Immediation};
                end
            else
                begin
                    Signed_number = {16'h0000,Immediation};
                end
        end
endmodule
