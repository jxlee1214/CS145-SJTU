`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/05 11:20:02
// Design Name: 
// Module Name: Mux
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


module Mux_5(
    input [4:0] INPUT1,
    input [4:0] INPUT2,
    input [4:0] SEL,
    output [4:0] OUT    
    );    
    assign OUT= SEL ? INPUT1:INPUT2;
endmodule

module Mux_32(
    input [31:0] INPUT1,
    input [31:0] INPUT2,
    input [31:0] SEL,
    output [31:0] OUT  
);
    assign OUT= SEL ? INPUT1:INPUT2;
endmodule
