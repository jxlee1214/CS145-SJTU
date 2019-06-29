`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/22 09:33:31
// Design Name: 
// Module Name: Ctr_tb
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


module Ctr_tb(

    );
    reg [5:0] OpCode;
    
    Ctr u0(
    .OpCode(OpCode)
    );
    
    initial begin
    //Initialize Inputs
    OpCode=0;
    
    //Wait 100nm for global reset to finish
    #100;
    
    #100
    OpCode=6'b000000; //R-type
    
    #100
    OpCode=6'b100011; //lw
    
    #100
    OpCode=6'b101011; //sw
    
    #100
    OpCode=6'b000100; //beq
    
    #100
    OpCode=6'b000010; //J
    
    end
endmodule
