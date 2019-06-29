`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/22 09:01:57
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [5:0] OpCode,
    output regDst,
    output aluSrc,
    output memToReg,
    output regWrite,
    output memRead,
    output memWrite,
    output branch,
    output [1:0] aluOp,
    output jump
    
    );
    
    reg RegDst;
    reg ALUSrc;
    reg MemToReg;
    reg RegWrite;
    reg MemWrite;
    reg MemRead;
    reg Branch;
    reg [1:0] ALUOp;
    reg Jump;
    
    always @ (OpCode)
    begin
        case (OpCode)
        6'b000000: //R type
        begin
            RegDst=1;
            ALUSrc=0;
            MemToReg=0;
            RegWrite=1;
            MemRead=0;
            MemWrite=0;
            Branch=0;
            ALUOp=2'b10;
            Jump=0;
        end
        
        6'b100011: //lw
        begin
            RegDst=0;
            ALUSrc=1;
            MemToReg=1;
            RegWrite=1;
            MemRead=1;
            MemWrite=0;
            Branch=0;
            ALUOp=2'b00;
            Jump=0;
        end        
        
        6'b101011: //sw
         begin
//            RegDst=0;
            ALUSrc=1;
//            MemToReg=1;
            RegWrite=0;
            MemRead=0;
            MemWrite=1;
            Branch=0;
            ALUOp=2'b00;
            Jump=0;
        end           
                
        6'b000100: //beq
        begin
//            RegDst=1;
            ALUSrc=0;
//            MemToReg=0;
            RegWrite=0;
            MemRead=0;
            MemWrite=0;
            Branch=1;
            ALUOp=2'b01;
            Jump=0;
        end
          
        6'b000010: //Jump
        begin
            RegDst=0;
            ALUSrc=0;
            MemToReg=0;
            RegWrite=0;
            MemRead=0;
            MemWrite=0;
            Branch=0;
            ALUOp=2'b00;
            Jump=1;
        end         
        
        default:
        begin
            RegDst=0;
            ALUSrc=0;
            MemToReg=0;
            RegWrite=0;
            MemRead=0;
            MemWrite=0;
            Branch=0;
            ALUOp=2'b00;
            Jump=0;
        end
    endcase
    end
endmodule
