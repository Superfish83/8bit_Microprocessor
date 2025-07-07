
`timescale 1ns / 1ps

module Proc(
    input [7:0] inst,
    output [7:0] readAddr,
    output [6:0] segOut16,
    output [6:0] segOut1,
    output [6:0] segPc16,
    output [6:0] segPc1,
    output [6:0] segOpcode,
	 output negLED,
    input CLK_osc,
    input RST,
	 input HALT
    );
	 
	 // 내장 iMem (시뮬레이터, TA보드 없이 테스트하는 용도)
	 // !!! 이제 더 이상 사용하지 않는 부분임 !!!
	 
	 /*
	 wire [7:0] inst;
	 wire [7:0] readAddr;
	 imem memory(
		.Read_Address(readAddr),
		.instruction(inst)
	 );
	 */
		 
	
	 
	 // *** Clock (Frequency Divider) ***
	 wire CLK;
	 wire haltCLK;
	 freqDivider fDiv (
		.clr(RST),
		.HALT(HALT),
		.CLK(CLK_osc),
		.CLKout(CLK),
		.haltCLKout(haltCLK)
	 );
	 
	 // *** Variables / Submodules ***
	 // (0) PC and segment output
	 reg [7:0] pc;
	 assign readAddr =  pc;
	 
	 wire [6:0] sOut16;
	 wire [6:0] sOut1;
	 wire [6:0] sPc16;
	 wire [6:0] sPc1;
	 wire [6:0] op2seg;
	 
	 
	 assign segOut16 = 	(HALT == 0) ? sOut16 : ((haltCLK) ? 7'b1001110 : 0); // C
	 assign segOut1 = 	(HALT == 0) ? sOut1 	: ((haltCLK) ? 7'b1011110 : 0); // G
	 assign segPc16 = 	(HALT == 0) ? sPc16 	: ((haltCLK) ? 7'b0001110 : 0); // L
	 assign segPc1 = 		(HALT == 0) ? sPc1 	: ((haltCLK) ? 7'b1001111 : 0); // E
	 assign segOpcode = 	(HALT == 0) ? op2seg : ((haltCLK) ? 7'b1001111 : 0); // E
	 
	 // (1) Decoded instruction
	 wire [1:0] iOpcode;
	 wire [1:0] iRs;
	 wire [1:0] iRt;
	 wire [1:0] iRd;
	 wire [7:0] iImm;
	 
	 assign iOpcode = inst[7:6];
	 assign iRs = inst[5:4];
	 assign iRt = inst[3:2];
	 assign iRd = inst[1:0];
	 assign iImm = {{6{inst[1]}}, inst[1:0]}; // imm = signExtend(inst[1:0])
	 
	 // (2) Control Signals
	 wire [7:0] control;
	 wire cRegDst;
	 wire cRegWrite;
	 wire cALUSrc;
	 wire cBranch;
	 wire cMemRead;
	 wire cMemWrite;
	 wire cMemtoReg;
	 wire cALUOp;
	 assign {cRegDst, cRegWrite, cALUSrc, cBranch,
			cMemRead, cMemWrite, cMemtoReg, cALUOp} = control;
	 assign control =
		(iOpcode == 2'b00) ? 8'b11000001 :     // add
		(iOpcode == 2'b01) ? 8'b01101010 :     // lw
		(iOpcode == 2'b10) ? 8'b00100100 :     // sw
		(iOpcode == 2'b11) ? 8'b00010000 : 0;  // j
		
	 // (3) Register File
	 wire [7:0] read1;
	 wire [7:0] read2;
	 wire [1:0] wIdx;
	 wire [7:0] wData;
	 
	 // * Additional Feature *
	 //Connecting MSB of wData to negLED, describing whether wData is negative.
	 assign negLED = wData[7];
	 
	 RegFile rFile(
		.rIdx1(iRs),
		.rIdx2(iRt),
		.write(cRegWrite),
		.wIdx(wIdx),
		.wData(wData),
		.read1(read1),
		.read2(read2),
		.CLK(CLK),
		.RST(RST)
	 );
	 
	 
	 // (4) ALU
	 wire [7:0] aluIn1;
	 wire [7:0] aluIn2;
	 wire [7:0] aluOut;
	 
	 assign aluIn1 = read1;
	 assign aluIn2 = (cALUSrc == 0) ? read2 : iImm;
	 
	 Alu alu(
		.val1(aluIn1),
		.val2(aluIn2),
		.aluOp(cALUOp),
		.result(aluOut)
	 );
	 
	 
	 // (5) Data Memory
	 wire [7:0] memAddr;
	 wire [7:0] memWData;
	 wire [7:0] memRData;
	 
	 assign memWData = read2;
	 assign memAddr = aluOut;
	 
	 DMem dMem(
		.Address(memAddr),
		.writeData(memWData),
		.readData(memRData),
		.MemRead(cMemRead),
		.MemWrite(cMemWrite),
		.CLK(CLK),
		.RST(RST)
	 );
	 
	 // (6-1) Write Back
	 assign wIdx = (cMemtoReg == 0) ?
			iRd : 	// (op == add) rd
			iRt; 		// (op == lw) rt
	 assign wData = 
			(iOpcode == 2'b00) ? aluOut :    // (op == add) rs+rt
			(iOpcode == 2'b01) ? memRData :  // (op == lw)  Mem[rs+imm]
			8'b0;  // (op == sw) or (op == j)
	 
	 
	 // (6-2) 7Seg output converter
	 RegWriteTo7Seg to7segOut (
		.reg_data(wData),
		.seg_high(sOut16),
		.seg_low(sOut1)
	 );
	 
	 // (6-3) *Additional Feature* display PC to 7seg
	 RegWriteTo7Seg to7segPc (
		.reg_data(pc),
		.seg_high(sPc16),
		.seg_low(sPc1)
	 );
	 
	 // (6-3) *Additional Feature* output opcode to 7seg
	 Opcode2Seg opcode2seg (
 		.opcode(iOpcode),
		.seg(op2seg)
	 );
	
	
	 // *** Behavior ***
	 
	 always @(posedge CLK or posedge RST) begin
 		if(RST == 1) begin
		// Initialize / Reset processor
			pc <= 8'b0;
		end
		else begin
		// Update PC
			$display("pc: %d", pc);
			pc <= (cBranch==0) ?
				(pc+1) :			// (op != j)
				(pc+1 + iImm);	// (op == j)
		end
	 end 
	 
endmodule