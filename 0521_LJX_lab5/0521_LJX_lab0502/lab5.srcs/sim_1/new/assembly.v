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
    //input
    reg clk;
    wire Clkin;
    reg reset;
    reg [2:0] regnum;
    //output
    wire Clk;
	wire [7:0] LED;
	wire [31:0] R0;
	wire [31:0] R1;
	wire [31:0] R2;
	wire [31:0] R3;
	wire [31:0] R4;
	wire [31:0] R5;
	wire [31:0] R6;
	wire [31:0] R7;
//	wire [31:0] PC;

    Top u(
    .clk_p(clk),
    .clk_n(~clk),
    .regnum(regnum),
    .Clk(Clk),
    .reset(reset),
    .Clkin(Clkin),
    .R0(R0),
    .R1(R1),
    .R2(R2),
    .R3(R3),
    .R4(R4),
    .R5(R5),
    .R6(R6),
    .R7(R7),
    .LED(LED)
    );
    
    parameter PERIOD = 100;

    always begin
        clk = 1'b0;
        #(PERIOD/2) clk = 1'b1;
        #(PERIOD/2);
    end
    
    initial begin
    //reset
    reset<=1;
    regnum=3'b001;    
    #50
    //stimulate
       reset <= 0;

       #10000; 
    end
endmodule
