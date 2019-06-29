`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/24 17:26:18
// Design Name: 
// Module Name: registers
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


module registers(
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    input reset,
    
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    
    input Clk,
//	 output wire [31:0] R0,
//	 output wire [31:0] R1,
//	 output wire [31:0] R2,
//	 output wire [31:0] R3,
//	 output wire [31:0] R4,
//	 output wire [31:0] R5,
//	 output wire [31:0] R6,
//	 output wire [31:0] R7    
	 output reg [31:0] R0,
	 output reg [31:0] R1,
	 output reg [31:0] R2,
	 output reg [31:0] R3,
	 output reg [31:0] R4,
	 output reg [31:0] R5,
	 output reg [31:0] R6,
	 output reg [31:0] R7    
    );
    
    reg [31:0] regFile [31:0];
    integer i=0;
    
    initial begin
            for(i=0; i<32; i=i+1)
            begin
                regFile[i]=0;
            end    
    end
    
//	 assign R0=regFile[0];
//	 assign R1=regFile[1];
//	 assign R2=regFile[2];
//	 assign R3=regFile[3];
//	 assign R4=regFile[4];
//	 assign R5=regFile[5];
//	 assign R6=regFile[6];
//	 assign R7=regFile[7];	 
	 
    always@ (readReg1 or readReg2 or writeReg)
        begin 
            readData1=regFile [readReg1];
            readData2=regFile [readReg2];
           	 R0=regFile[0];
	 R1=regFile[1];
	  R2=regFile[2];
	 R3=regFile[3];
	 R4=regFile[4];
	  R5=regFile[5];
	 R6=regFile[6];
	 R7=regFile[7];	 
        end
        
    always @ (negedge Clk)
        begin
            if(reset==1)
            begin
            for(i=0; i<32; i=i+1)
            begin
                regFile[i]=0;
            end
            end
            if(regWrite==1)
                begin
                    regFile[writeReg]=writeData;
                end
        end
        
        
endmodule
