`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:44:25 06/05/2025 
// Design Name: 
// Module Name:    HexTo7Seg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module HexTo7Seg(
    input [3:0] hex,			// 4-bit hex imput
    output reg [6:0] seg	// 7-seg output (a~g)
    );
	 
	 always @(*) begin
		case(hex)
			4'h0: seg = 7'b111_1110; // abc_defg
			4'h1: seg = 7'b011_0000;
			4'h2: seg = 7'b110_1101;
			4'h3: seg = 7'b111_1001;
			
			4'h4: seg = 7'b011_0011;
			4'h5: seg = 7'b101_1011;
			4'h6: seg = 7'b101_1111;
			4'h7: seg = 7'b111_0000;
			
			4'h8: seg = 7'b111_1111;
			4'h9: seg = 7'b111_1011;
			4'hA: seg = 7'b111_0111;
			4'hB: seg = 7'b001_1111;
			
			4'hC: seg = 7'b100_1110;
			4'hD: seg = 7'b011_1101;
			4'hE: seg = 7'b100_1111;
			4'hF: seg = 7'b100_0111;
			default: seg = 7'b000_0000; // all segments off
		endcase
	 end

endmodule
