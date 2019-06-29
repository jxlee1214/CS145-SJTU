`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/05 09:44:57
// Design Name: 
// Module Name: InstMemory
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


module InstMemory(
    input [31:0] PC,
    input reset,
    output reg [31:0] INST
    );
    
    reg [31:0] InstFile [0:255];
    initial begin
//        $readmemb("E:/mem_inst.txt", InstFile);

    end
    always @ (reset)
    begin
		InstFile[0]=32'b10001100000000010000000000000001;//lw $1,1($0)
		InstFile[1]=32'b10001100000000100000000000000011;//lw $2,3($0)
		InstFile[2]=32'b11111000000000000000000000000001;//nop
		InstFile[3]=32'b11110000000000000000000000000000;//nop
		InstFile[4]=32'b11110000000000000000000000000000;//nop
		InstFile[5]=32'b00000000001000100001100000100000;//add $3,$1,$2
		InstFile[6]=32'b00000000010000010010000000100010;//sub $4,$2,$1
		InstFile[7]=32'b11111000000000000000000000000001;//nop
		InstFile[8]=32'b11110000000000000000000000000000;//nop
		InstFile[9]=32'b00000000011001000010100000101010;//slt $5,$3,$4
		InstFile[10]=32'b00000000001000100011000000100100;//and $6,$1,$2
		InstFile[11]=32'b00000000001000100011100000100101;//or $7,$1,$2
		InstFile[12]=32'b10101100000000110000000000000001;//sw $3,1($0)
		InstFile[13]=32'b10101100000001000000000000000010;//sw $4,3($0)
		InstFile[14]=32'b11110000000000000000000000000000;//nop
		InstFile[15]=32'b11110000000000000000000000000000;//nop
		InstFile[16]=32'b00000000101001110001100000100000;//add $7,$3,$5
		InstFile[17]=32'b00000000100001100100000000100000;//add $8,$4,$6
		InstFile[18]=32'b00010000000000001111111111101100;//beq $0,$0,#-20
		InstFile[19]=32'b11110000000000000000000000000000;//nop
		InstFile[20]=32'b11110000000000000000000000000000;//nop
		InstFile[21]=32'b11110000000000000000000000000000;//nop 
    end
    always @(PC) 
    begin
    INST=InstFile[PC>>2];
    end
endmodule
