`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/05 09:49:19
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(
    input clk_p,
    input clk_n,
    output wire Clkin,
    input reset,
    input [2:0] regnum,
	output reg [7:0] LED,
	output wire Clk,
	 output wire [31:0] R0,
	 output wire [31:0] R1,
	 output wire [31:0] R2,
	 output wire [31:0] R3,
	 output wire [31:0] R4,
	 output wire [31:0] R5,
	 output wire [31:0] R6,
	 output wire [31:0] R7	
);
    //LED: clk, reset, regnum, reg least 3bits
    
    reg [31:0] PC;
    wire [31:0] INST;
    
    //register
    wire [25:21] readReg1;
    wire [20:16] readReg2;
    wire [4:0] writeReg;
    wire [31:0] writeData;
    wire [31:0] readData1;
    wire [31:0] readData2;     
//    reg [31:0] regFile [31:0];    
    
    //signext
    wire [15:0] inst;
    wire [31:0] data;
    
    //alu
    wire [3:0] ALUCtrOut;
    wire [31:0] aluRes;
    wire Zero;
    wire [31:0] input2;
    
    //control signal
    wire REG_DST;
    wire JUMP;
    wire BRANCH;
    wire MEM_READ;
    wire MEM_TO_REG;
    wire MEM_WRITE;
    wire [1:0] ALU_OP;
    wire ALU_SRC;
    wire REG_WRITE;
      
    //memory
    wire [31:0] readData;
    
    //for board
	 always @ (Clk)
	 begin
		case(regnum[2:0])
			3'b000: LED[2:0]<=R0[2:0];
			3'b001: LED[2:0]<=R1[2:0];
			3'b010: LED[2:0]<=R2[2:0];
			3'b011: LED[2:0]<=R3[2:0];
			3'b100: LED[2:0]<=R4[2:0];
			3'b101: LED[2:0]<=R5[2:0];
			3'b110: LED[2:0]<=R6[2:0];
			3'b111: LED[2:0]<=R7[2:0];
		endcase
		LED[6]<=reset;
		LED[5:3]<=regnum[2:0];
	 end    
	 always @ (posedge Clk) 
	 begin 
	 LED[7]=~LED[7];
	 end
	     
	IBUFGDS IBUFGDS_inst(
.O(Clkin),//50MHz
.I(clk_p),
.IB(clk_n));

    //time divider
    time_divider u6(
        .clock_in(Clkin),
        .clock_out(Clk)
    );
    
    //PC init
    initial begin
    PC=0;
    LED[7]=0;
    end    
    
    //Instruction Memory
    InstMemory u2(
        .INST(INST),
        .PC(PC),
        .reset(reset)
    );
        
    //Control unit
    Ctr mainCtr(
        .OpCode(INST[31:26]),
        .RegDst(REG_DST),
        .Jump(JUMP),
        .Branch(BRANCH),
        .MemRead(MEM_READ),
        .MemToReg(MEM_TO_REG),
        .ALUOp(ALU_OP),
        .MemWrite(MEM_WRITE),
        .ALUSrc(ALU_SRC),
        .RegWrite(REG_WRITE)
    );
    
    assign writeReg = REG_DST ? INST[15:11] : INST[20:16];
                  
    //signext    
    signext u1(
        .inst(INST[15:0]),
        .data(data)
    );    
    
    //register
    registers u0(
        .readReg1(INST[25:21]),
        .readReg2(INST[20:16]),
        .writeReg(writeReg),
        .writeData(writeData),
        .regWrite(REG_WRITE),
        .Clk(Clk),
        
        .readData1(readData1),
        .readData2(readData2),
        
        //get info of all registers
        .R0(R0),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .R4(R4),
        .R5(R5),
        .R6(R6),
        .R7(R7)
    );
    
    assign input2=ALU_SRC ? data:readData2;        
    
    //alu Control
    ALUctr u3(
        .Funct(INST[5:0]),
        .ALUOp(ALU_OP),
        .ALUCtrOut(ALUCtrOut)   
    );
        
    //alu
    ALU u4(
        .input1(readData1),
        .input2(input2),
        .aluCtr(ALUCtrOut),
        .aluRes(aluRes),
        .zero(Zero)
    );   
        
    //data memory
    dataMemory u5(
        .Clk(Clk),
        .address(aluRes),
        .writeData(readData2),
        .memWrite(MEM_WRITE),
        .memRead(MEM_READ),
        .readData(readData)
    );
    assign writeData= MEM_TO_REG ? readData : aluRes;   
                    
    //update PC
     always @ (posedge Clk)
        begin
		if (reset) PC<=0;
		else if (Zero && BRANCH) PC<=PC+4+(INST[15:0]<<2);
		else if (JUMP) PC<=(INST[25:0]<<2);
		else PC<=PC+4;
        PC=PC%32;
        end


endmodule
