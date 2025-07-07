`timescale 1ns / 1ps

module DMem(
    input [7:0] Address,
    input [7:0] writeData,
    output [7:0] readData,
    input MemRead,
    input MemWrite,
	 input CLK,
	 input RST
    );
	 
	 reg [7:0] mem [0:31];
	 wire [7:0] wD;
	 wire [7:0] rD;
	 wire [7:0] addr;
	 
	 assign addr = Address;
	 assign wD = writeData;
	 assign readData = rD;
	 
	 assign rD = (MemRead==1) ? mem[addr] : 0;
	 
	 integer i = 0;
	 always @(posedge CLK or posedge RST) begin
		if (RST == 1) begin
			for(i = 0; i < 16; i = i+1) begin
				mem[i] = i;
				mem[16+i] = -i;
				//$display("%d", mem[16+i]);
			end
		end
		else begin
			if(MemWrite == 1) begin
				$display("wData: %d", wD);
				mem[addr] = wD;
			end
		end
	 end


endmodule
