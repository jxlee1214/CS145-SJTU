`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/29 10:37:40
// Design Name: 
// Module Name: dataMemory_tb
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


module dataMemory_tb(    );

    reg Clk;
    
    reg [31:0] address;
    reg [31:0] writeData;
    reg memWrite;
    reg memRead;
    wire [31:0] readData;

    dataMemory u0( 
        .Clk(Clk),
        .address(address),
        .writeData(writeData),
        .memWrite(memWrite),
        .memRead(memRead),
        .readData(readData)
    );

    parameter PERIOD = 200;

    always begin
        Clk = 1'b0;
        #(PERIOD/2) Clk = 1'b1;
        #(PERIOD/2);
    end

    initial begin
    
    address=0;
    writeData=0;
    memWrite=0;
    memRead=0;

        
    //current time:185    
    #185;
    memWrite=1'b1;
    address=32'h00000007;
    writeData=32'hE0000000;
    
    //current time:285        
    #100;
    memWrite=1'b1;
    address=32'h00000006;    
    writeData=32'hffffffff;
   
    //current time:470        
    #185;
    memRead=1;
    memWrite=1;
    
    //current time:550
    #80
    memRead=0;
    memWrite=1'b1;
    address=32'h00000008;    
    writeData=32'haaaaaaaa;   

    //current time:630        
    #80;
    memRead=1;
    memWrite=0;
    
    //current time:710
    #80;
    address=32'h00000006;    
       
    //current time:790
    #80;
    memWrite=1;
    writeData=32'h00000000;
    
    end

endmodule
