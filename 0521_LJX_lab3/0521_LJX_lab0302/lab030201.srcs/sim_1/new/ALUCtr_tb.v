`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/22 11:13:37
// Design Name: 
// Module Name: ALUCtr_tb
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


module ALUCtr_tb(
    );
    
reg [5:0] Funct;
reg [1:0] ALUOp;
wire [3:0] ALUCtrOut;

ctr u0(
    .Funct(Funct),
    .ALUOp(ALUOp),
    .ALUCtrOut(ALUCtrOut)
);

    initial begin
    
    //Initialize Inputs
    Funct=6'b000000;
    
    //Wait 100nm for global reset to finish
    #100;
    
    #100;
    //R-type
    ALUOp=2'b10;
    //add
    Funct=6'b100000;
    #100;
    //subtract
    Funct=6'b100010;
    #100;
    //and
    Funct=6'b100100;
    #100;
    //or
    Funct=6'b100101;
    #100;
    //set on less than
    Funct=6'b101010;
    #100;
    
    //lw sw
    ALUOp=2'b00;
    #100;
    //bew
    ALUOp=2'b01;
    #100;

    end

endmodule
