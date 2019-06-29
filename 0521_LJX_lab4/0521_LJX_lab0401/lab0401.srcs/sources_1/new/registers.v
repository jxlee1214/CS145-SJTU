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
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    
    input Clk
    );
    
    
    
    reg [31:0] regFile [31:0];
    
    always@ (readReg1 or readReg2 or writeReg)
        begin 
            readData1=regFile [readReg1];
            readData2=regFile [readReg2];
            
        end
        
    always @ (negedge Clk)
        begin
            if(regWrite==1)
                begin
                    regFile[writeReg]=writeData;
                end
        end
        
        
endmodule
