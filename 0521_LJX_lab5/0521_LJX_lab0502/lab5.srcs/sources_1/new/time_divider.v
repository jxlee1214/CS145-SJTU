`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/18 19:41:18
// Design Name: 
// Module Name: time_divider
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

module time_divider(
    input clock_in,
    output reg clock_out
    );
	 reg [20:0] buffer;
	 initial begin 
	 buffer=0; 
	 end

	 always@(posedge clock_in)
	 begin
		buffer<=buffer+1;
		clock_out<=buffer[1];
	 end
endmodule
