`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/22 10:48:21
// Design Name: 
// Module Name: ctr
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


module ALUctr(
    input [5:0] Funct,
    input [1:0] ALUOp,
    output reg [3:0] ALUCtrOut
    );    
    
    always @ (ALUOp or Funct)
    begin 
        casex ( {ALUOp, Funct} )
            8'b00xxxxxx: //lw
            ALUCtrOut=4'b0010;
            
            8'b00xxxxxx:   //sw
            ALUCtrOut=4'b0010;
            
            8'b01xxxxxx: //beq
            ALUCtrOut=4'b0110;
            
            8'b10100000:    //add
            ALUCtrOut=4'b0010;
            
            8'b10100010:    //subtract
            ALUCtrOut=4'b0110;
            
            8'b10100100:    //and
            ALUCtrOut=4'b0000;
            
            8'b10100101:    //or
            ALUCtrOut=4'b0001;
            
            8'b10101010:    //set on less htan
            ALUCtrOut=4'b0111;
            
        endcase
    end
    
endmodule
