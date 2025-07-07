`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:03:18 06/05/2025 
// Design Name: 
// Module Name:    RegWriteTo7Seg 
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
module RegWriteTo7Seg(
    input [7:0] reg_data,
    output [6:0] seg_high,
    output [6:0] seg_low
    );

	 wire [3:0] high = reg_data[7:4];
	 wire [3:0] low  = reg_data[3:0];
	 
	 HexTo7Seg high_display (
		.hex(high),
		.seg(seg_high)
	 );
	 
	 HexTo7Seg low_display (
		.hex(low),
		.seg(seg_low)
	 );

endmodule
