`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/24 17:36:00
// Design Name: 
// Module Name: registers_tb
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


module registers_tb(
    );
    
    reg [25:21] readReg1;
    reg [20:16] readReg2;
    reg [4:0] writeReg;
    reg [31:0] writeData;
    reg regWrite;
    reg Clk;
    
    wire [31:0] readData1;
    wire [31:0] readData2;   
    
    registers u0(
        .readReg1(readReg1),
        .readReg2(readReg2),
        .writeReg(writeReg),
        .writeData(writeData),
        .regWrite(regWrite),
        .Clk(Clk),
        
        .readData1(readData1),
        .readData2(readData2)
    );
 
    parameter PERIOD = 200;
    
   always begin
      Clk = 1'b0;
      #(PERIOD/2) Clk = 1'b1;
      #(PERIOD/2);
   end
 
    
    initial begin
       //initialize input 
        regWrite=0;
        readReg1=0;
        readReg2=0;
        writeData=0;
        writeReg=0;

    
        //current time:285ns
        #285;
        regWrite=1'b1;
        writeReg=5'b10101;
        writeData=32'b11111111111111110000000000000000;

        //current time:485ns
        #200;
        writeReg=5'b01010;
        writeData=32'b00000000000000001111111111111111;
                
        //current time:685ns
        #200;
        regWrite=1'b0;
        writeReg=5'b00000;
        writeData=32'b00000000000000000000000000000000;
        
        //current time: 735ns
        #50;
        readReg1=5'b10101;
        readReg2=5'b01010;
        
                
    end
endmodule
