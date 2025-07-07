`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:21:38 06/06/2025 
// Design Name: 
// Module Name:    Opcode2Seg 
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


// *Additional Feature* display opcode to 7seg

module Opcode2Seg(
    input [1:0] opcode,
    output [6:0] seg
    );
	 
	 assign seg =
		(opcode == 2'b00) ? 7'b1110111 : 	// 'A' (add)
		(opcode == 2'b01) ? 7'b0001110 : 	// 'L' (lw)
		(opcode == 2'b10) ? 7'b1011011 :		// 'S' (sw)
		(opcode == 2'b11) ? 7'b0111000 : 0; // 'J' (j)


endmodule
