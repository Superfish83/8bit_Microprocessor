`timescale 1ns / 1ps

module freqDivider(
    input clr,
	 input HALT,
    input CLK,
    output reg CLKout,
	 output reg haltCLKout
    );

	reg[31:0] cnt;
	reg[31:0] haltCnt;
	
	always @(posedge CLK) begin
		if (clr) begin
			cnt <= 32'd0;
			haltCnt <= 32'd0;
			
			CLKout <= 1'b1;
			haltCLKout <= 1'b1;
		end
		else if(HALT == 0) begin // ordinary clock
			//if (cnt == 32'd0) begin // for simulation test
			if (cnt >= 32'd25000000) begin
				cnt <= 32'd0;
				CLKout <= ~CLKout;
			end
			else begin
				cnt <= cnt + 1;
			end
		end
		else begin // clock for events when HALT is given
			if (haltCnt >= 32'd7500000) begin
				haltCnt <= 32'd0;
				haltCLKout <= ~haltCLKout;
			end
			else begin
				haltCnt <= haltCnt + 1;
			end
		end
	end
endmodule
