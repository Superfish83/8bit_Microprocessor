`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:55:28 06/05/2025 
// Design Name: 
// Module Name:    imem 
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
module imem(
    output [7:0] instruction,
    input [7:0] Read_Address
    );

	wire [7:0] MemByte[31:0];
	
	// *** test program 1 ***
	
	/*
	assign MemByte[0] = 8'b01001001;
	assign MemByte[1] = 8'b11000001;
	assign MemByte[2] = 8'b00011000;
	assign MemByte[3] = 8'b10101001;
	assign MemByte[4] = 8'b01001101;
	*?
	
	// *** test program 2 ***
	
	/*
	assign MemByte[0]  = 8'b01000001;
	assign MemByte[1]  = 8'b00000000;
	assign MemByte[2]  = 8'b00000000;
	assign MemByte[3]  = 8'b01000110;
	assign MemByte[4]  = 8'b00000110;
	assign MemByte[5]  = 8'b10111001;
	assign MemByte[6]  = 8'b01111101;
	assign MemByte[7]  = 8'b01111111;
	assign MemByte[8]  = 8'b00101101;
	assign MemByte[9]  = 8'b01010001;
	assign MemByte[10] = 8'b00001110;
	assign MemByte[11] = 8'b01100101;
	*/
	
	// *** test program 3***
	
	/*
	assign MemByte[0]  = 8'b01000001;
	assign MemByte[1]  = 8'b11000001;
	assign MemByte[2]  = 8'b11000001;
	assign MemByte[3]  = 8'b00000000;
	assign MemByte[4]  = 8'b11000001;
	assign MemByte[5]  = 8'b11000001;
	assign MemByte[6]  = 8'b00000000;
	assign MemByte[7]  = 8'b11000001;
	assign MemByte[8]  = 8'b11000001;
	assign MemByte[9]  = 8'b00000000;
	assign MemByte[10] = 8'b11000010;
	*/
	
	// *** test program 4 ***
	
	assign MemByte[0]  = 8'b01000001;
	assign MemByte[1]  = 8'b11000001;
	assign MemByte[2]  = 8'b11000001;
	assign MemByte[3]  = 8'b01011001;
	assign MemByte[4]  = 8'b00101010;
	assign MemByte[5]  = 8'b00101010;
	assign MemByte[6]  = 8'b00101010;
	assign MemByte[7]  = 8'b00101010;
	assign MemByte[8]  = 8'b00101110;
	assign MemByte[9]  = 8'b01101101;
	assign MemByte[10] = 8'b00001100;
	assign MemByte[11] = 8'b11000010;

	
	assign instruction = MemByte[Read_Address];

endmodule
