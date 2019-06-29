`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/12 09:07:04
// Design Name: 
// Module Name: assembly
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


module assembly( );

    reg Clk;
    reg reset;
//    wire [31:0] PC;
    Top u(
    .Clk(Clk),
    .reset(reset)
//    .PC(PC)
    );
    
    parameter PERIOD = 50;

    always begin
        Clk = 1'b0;
        #(PERIOD/2) Clk = 1'b1;
        #(PERIOD/2);
    end
    
    initial begin
    //reset
//    Clk<=0;
    reset<=1;
    #66
    //stimulate
       reset <= 0;
       #30000; 
    end
endmodule
