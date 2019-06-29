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
//    integer PC_WRITE;
	 // IF/ID
	 reg[31:0] S1_PC_ADD4;
	 reg[31:0] S1_INST;
	 // ID/EX
	 reg S2_REG_WRITE, S2_MEM_TO_REG;	// WB
	 reg S2_BRANCH, S2_MEM_READ, S2_MEM_WRITE;		// M
	 reg S2_REG_DST, S2_ALU_SRC;
	 reg [1:0] S2_ALU_OP;	// EX
	 reg[31:0] S2_PC_ADD4;
	 reg[31:0] S2_READ_DATA1;
	 reg[31:0] S2_READ_DATA2;
	 reg[31:0] S2_SIGNEXT_IMME;
	 reg[5:0] S2_REG_ADDR_HIGH;	//inst[20:16]
	 reg[5:0] S2_REG_ADDR_LOW;	//inst[15:11]
	 // EX/MEM
	 reg S3_REG_WRITE, S3_MEM_TO_REG;	// WB
	 reg S3_BRANCH, S3_MEM_READ, S3_MEM_WRITE;		// M
	 reg[31:0] S3_BRANCH_ADDR;
	 reg[31:0] S3_ALU_RES;
	 reg[31:0] S3_ALU_ZERO;
	 reg[31:0] S3_MEM_WRITE_DATA;	//read_data2
	 reg[5:0]  S3_REG_ADDR;
	 // MEM/WB
	 reg S4_REG_WRITE, S4_MEM_TO_REG;	// WB
	 reg[31:0] S4_MEM_READ_DATA;
	 reg[31:0] S4_ALU_RES;
	 reg[5:0]  S4_REG_ADDR;
	 // IF
	 wire PC_SRC;
	 wire[31:0] IF_INST;
	 // ID
	 wire ID_REG_DST;
	 wire ID_ALU_SRC;
	 wire ID_MEM_TO_REG;
	 wire ID_REG_WRITE;
	 wire ID_MEM_READ;
	 wire ID_MEM_WRITE;
	 wire ID_BRANCH;
	 wire[1:0] ID_ALU_OP;
	 wire[31:0] ID_READ_DATA1;
	 wire[31:0] ID_READ_DATA2;
	 wire[31:0] ID_SIGNEXT_IMME;
	 wire JUMP;
	 
	 wire[31:0] MEM_MEM_READ_DATA;
	 
     //EX
	 wire[3:0] EX_ALU_CTR;
	 wire EX_ALU_ZERO;
	 wire[31:0] EX_ALU_RES;

    
    //PC init
    initial begin
    PC=0;
//    PC_WRITE=0;
    end    
    
    //Instruction Memory
    InstMemory u2(
        .INST(IF_INST),
        .PC(PC),
        .reset(reset)
    );
        
    //Control unit
    Ctr mainCtr(
        .OpCode(S1_INST[31:26]),
        .RegDst(ID_REG_DST),
        .Jump(JUMP),
        .Branch(ID_BRANCH),
        .MemRead(ID_MEM_READ),
        .MemToReg(ID_MEM_TO_REG),
        .ALUOp(ID_ALU_OP),
        .MemWrite(ID_MEM_WRITE),
        .ALUSrc(ID_ALU_SRC),
        .RegWrite(ID_REG_WRITE)
    );
                  
    //signext    
    signext u1(
        .inst(S1_INST[15:0]),
        .data(ID_SIGNEXT_IMME)
    );    
    
    //register
    registers u0(
        .readReg1(S1_INST[25:21]),
        .readReg2(S1_INST[20:16]),
        .writeReg(S4_REG_ADDR),
        .writeData(S4_MEM_TO_REG ? S4_MEM_READ_DATA : S4_ALU_RES),
        .regWrite(S4_REG_WRITE),
        .Clk(Clk),
        
        .readData1(ID_READ_DATA1),
        .readData2(ID_READ_DATA2)
    );
    
    //alu Control
    ALUctr u3(
        .Funct(S2_SIGNEXT_IMME[5:0]),
        .ALUOp(S2_ALU_OP),
        .ALUCtrOut(EX_ALU_CTR)   
    );
        
    //alu
    ALU u4(
        .input1(S2_READ_DATA1),
        .input2(S2_ALU_SRC ? S2_SIGNEXT_IMME : S2_READ_DATA2),
        .aluCtr(EX_ALU_CTR),
        .aluRes(EX_ALU_RES),
        .zero(EX_ALU_ZERO)
    );   
        
    //data memory
    dataMemory u5(
        .Clk(Clk),
        .address(S3_ALU_RES),
        .writeData(S3_MEM_WRITE_DATA),
        .memWrite(S3_MEM_WRITE),
        .memRead(S3_MEM_READ),
        .readData(MEM_MEM_READ_DATA)
    );
                  
     assign PC_SRC=S3_ALU_ZERO & S3_BRANCH;  
    //update PC
     always @ (posedge Clk)
        begin
		if (reset) 
		    begin
		    PC<=0;
			// IF/ID
			S1_PC_ADD4=0;
			S1_INST=32'b00000011111111111111100000100000;
			
			// ID/EX
			S2_REG_WRITE=0;
			S2_MEM_TO_REG=0;
				 
			S2_BRANCH=0;
			S2_MEM_READ=0;
			S2_MEM_WRITE=0;
				 
			S2_REG_DST=0;
			S2_ALU_SRC=0;
			S2_ALU_OP=0;
			
			S2_PC_ADD4=0;
			S2_READ_DATA1=0;
			S2_READ_DATA2=0;
			S2_SIGNEXT_IMME=0;
			S2_REG_ADDR_HIGH=0;	//inst[20:16]
			S2_REG_ADDR_LOW=0;	//inst[15:11]
			
			
			// EX/MEM
			S3_REG_WRITE=0;
			S3_MEM_TO_REG=0;	// WB
			S3_BRANCH=0;
			S3_MEM_READ=0;
			S3_MEM_WRITE=0;		// M
			
			S3_BRANCH_ADDR=0;
			S3_ALU_RES=0;
			S3_ALU_ZERO=0;
			S3_MEM_WRITE_DATA=0;	//read_data2
			S3_REG_ADDR=0;
			
			
			// MEM/WB
			S4_REG_WRITE=0;
			S4_MEM_TO_REG=0;	// WB
			
			S4_MEM_READ_DATA=0;
			S4_ALU_RES=0;
			S4_REG_ADDR=0;		
		    end
		else 		
		begin
//		    if( S2_MEM_READ && 
//		    ((S2_REG_ADDR_LOW==S1_INST[25:21]) ||
//		    (S2_REG_ADDR_LOW==S1_INST[20:16])))
//		    begin
//		    // WB
//	        S2_REG_WRITE=0;
//	        S2_MEM_TO_REG=0;	
//	        // M
//	        S2_BRANCH=0;
//	        S2_MEM_READ=0;
//	        S2_MEM_WRITE=0;		
//	        S2_REG_DST=0;
//	        S2_ALU_SRC=0;	        
	        
//	        // EX
//	        S2_ALU_OP=0;	
//		    end
		    
		
			// MEM/WB
			S4_REG_WRITE = S3_REG_WRITE;
			S4_MEM_TO_REG = S3_MEM_TO_REG;
		
			S4_MEM_READ_DATA = MEM_MEM_READ_DATA;
			S4_ALU_RES = S3_ALU_RES;
			S4_REG_ADDR = S3_REG_ADDR;
			
			
			// PC
//			if(PC_WRITE==0)
//			begin
			PC = PC_SRC ? S3_BRANCH_ADDR: PC+4;
		    PC =PC % (14<<2);//14<<2=32'b111000
//		    end
//		    else
//		    begin
//		    PC_WRITE=PC_WRITE-1;
//		    end
		    
			// EX/MEM
			S3_REG_WRITE = S2_REG_WRITE;
			S3_MEM_TO_REG = S2_MEM_TO_REG;
			S3_BRANCH = S2_BRANCH;
			S3_MEM_READ = S2_MEM_READ;
			S3_MEM_WRITE = S2_MEM_WRITE;
		
			S3_BRANCH_ADDR = S2_PC_ADD4 + (S2_SIGNEXT_IMME<<2);
			S3_ALU_RES = EX_ALU_RES;
			S3_ALU_ZERO = EX_ALU_ZERO;
			S3_MEM_WRITE_DATA = S2_READ_DATA2;
			S3_REG_ADDR = S2_REG_DST ? S2_REG_ADDR_LOW : S2_REG_ADDR_HIGH;
		 
			
			// ID/EX
			S2_REG_DST = ID_REG_DST;
			S2_ALU_SRC = ID_ALU_SRC;
			S2_MEM_TO_REG = ID_MEM_TO_REG;
			S2_REG_WRITE = ID_REG_WRITE;
			S2_MEM_READ = ID_MEM_READ;
			S2_MEM_WRITE = ID_MEM_WRITE;
			S2_BRANCH = ID_BRANCH;
			S2_ALU_OP = ID_ALU_OP;
			
			S2_PC_ADD4 = S1_PC_ADD4;
			S2_READ_DATA1 = ID_READ_DATA1;
			S2_READ_DATA2 = ID_READ_DATA2;
			S2_SIGNEXT_IMME = ID_SIGNEXT_IMME;
			S2_REG_ADDR_HIGH = S1_INST[20:16];
			S2_REG_ADDR_LOW = S1_INST[15:11];
			
			
			// IF/ID
			S1_PC_ADD4 = PC+4;
			S1_INST = IF_INST;
		end
        end


endmodule
