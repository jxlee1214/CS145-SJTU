`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/29 08:20:47
// Design Name: 
// Module Name: ALU
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


module ALU (
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] aluCtr,
    output reg zero,
    output reg [31:0] aluRes    
);

    initial begin
    zero=0;
    aluRes=0;
    end
    
    always @ (input1 or input2 or aluCtr)
    begin        
        casex (aluCtr)  
            4'b0010://add
            begin
                zero=0;
                aluRes = input1 + input2;
            end
            4'b0110:  //sub
            begin
                aluRes = input1 - input2;
                if(aluRes==0)
                    zero =1;
                else
                    zero=0;
            end
            4'b0000:  //and 
            begin
                zero=0;
                aluRes=input1&input2;
            end
            4'b0001:    //or
            begin
                zero=0;
                aluRes=input1|input2;
            end
            4'b0111:    //set on less than
            begin
                zero=0;
                if(input1<input2)
                    aluRes=1;
                else aluRes=0;
            end
            4'b1100:    //NOR
            begin
            zero=0;
                aluRes=input1|input2;
                aluRes=~aluRes;
            end
        endcase
    end
endmodule
