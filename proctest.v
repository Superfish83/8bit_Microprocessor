`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:52:22 06/05/2025
// Design Name:   Processor
// Module Name:   /csehome/dazingdays/Gimalguajae/proctest.v
// Project Name:  Gimalguajae
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Processor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module proctest;

	// Inputs
	reg CLK;
	reg RST;
	reg HALT = 0;

	// Outputs
	wire [7:0] inst;
	wire [7:0] readAddr;
	wire [6:0] segOut16;
	wire [6:0] segOut1;
	wire [6:0] segPc16;
	wire [6:0] segPc1;

	wire [6:0] segOpcode;
	
	wire negLED;

	// Instantiate the Unit Under Test (UUT)
	Proc uut (
		.inst(inst), 
		.readAddr(readAddr), 
		.segOut16(segOut16),
		.segOut1(segOut1), 
		.segPc16(segPc16),
		.segPc1(segPc1), 
		.segOpcode(segOpcode),
		.negLED(negLED),
		.CLK_osc(CLK),
		.HALT(HALT),
		.RST(RST)
	);
	
	imem memory(
		.Read_Address(readAddr),
		.instruction(inst)
	);
	always #20 CLK = !CLK;
	initial begin
		// Initialize Inputs
		
		CLK = 1;
		RST = 1;
		
		#110;
		RST = 0;
	end
      
endmodule

