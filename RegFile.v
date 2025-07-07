`timescale 1ns / 1ps

module RegFile(
    input [1:0] rIdx1,
    input [1:0] rIdx2,
	 input write, // write enable
    input [1:0] wIdx,
    input [7:0] wData,
    output [7:0] read1,
    output [7:0] read2,
	 input CLK,
	 input RST
    );
	 
	 reg [7:0] regFile [3:0];
	 
	 assign read1 = regFile[rIdx1];
	 assign read2 = regFile[rIdx2];
	 
	 // Initialize Register File	 
	 always @ (posedge CLK or posedge RST) begin
		if(RST == 1) begin
			regFile[0] = 8'b0;
			regFile[1] = 8'b0;
			regFile[2] = 8'b0;
			regFile[3] = 8'b0;
		end
		else begin
			if(write) begin
				$display("wData = %d, wIdx = %d", wData, wIdx);
				regFile[wIdx] = wData;
			end
		end
	 end

endmodule
