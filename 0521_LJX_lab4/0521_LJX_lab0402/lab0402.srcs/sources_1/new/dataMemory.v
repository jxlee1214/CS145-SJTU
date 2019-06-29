`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/29 10:22:48
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input Clk,
    
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    output reg [31:0] readData=0
    );
    
    reg [31:0] memFile [0:63];
    
    always @ (address or readData or memRead )
        begin
            if(memRead==1)
            begin
                readData=memFile[address];
            end
        end
        
     always @ (negedge Clk)
        begin
            if(memWrite==1)
            begin
                memFile[address]=writeData;
            end
        end   
    
    
    
endmodule
