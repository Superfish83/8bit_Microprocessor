`timescale 1ns / 1ps

module Alu(
    input [7:0] val1,
    input [7:0] val2,
    input aluOp,
    output [7:0] result
    );

	wire [7:0] res;
	wire [7:0] v1, v2;
	
	assign v1 = val1;
	assign v2 = val2;
	assign result = res;
	
	assign res = v1 + v2;
	
	always@(res) begin
		//$display("%d+ %d = %d", v1, v2, res);
	end
endmodule
