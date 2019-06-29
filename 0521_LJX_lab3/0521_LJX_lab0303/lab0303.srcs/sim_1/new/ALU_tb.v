`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/29 08:47:22
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb(

    );
    
    reg [31:0] input1;
    reg [31:0] input2;
    reg [3:0] aluCtr;
    wire [31:0] aluRes;
    wire zero;
    
    ALU u0(
        .input1(input1),
        .input2(input2),
        .aluCtr(aluCtr),
        .aluRes(aluRes),
        .zero(zero)
    );
    
    initial begin
    
//    input1=32'b00000000000000000000000000001111;
//    input2=32'b00000000000000000000000011111111;
    
    input1=15;
    input2=10; 
    
    //and
    aluCtr=4'b0000;
    #100;
    
    //or
    aluCtr=4'b0001;
    #100;
    
    //add
    aluCtr=4'b0010;
    #100;

    //substract
    aluCtr=4'b0110;
    #100;
    
    //set on less than
    aluCtr=4'b0111;
    #100;
    
    //NOR
    aluCtr=4'b1100;
    #100;
 
    input1=10;
    input2=10;     
    //substract
    aluCtr=4'b0110;
    #100;
    
    //add
    aluCtr=4'b0010;
    #100;
        
    end
endmodule
