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
    input Clk,
    input reset
);
    
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
    
    //PC init
    initial begin
    PC=0;
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
        .readData2(readData2)
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
