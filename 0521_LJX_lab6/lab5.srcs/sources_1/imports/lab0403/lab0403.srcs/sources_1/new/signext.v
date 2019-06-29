`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/05 09:01:45
// Design Name: 
// Module Name: signext
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


module signext(
    input [15:0] inst,
    output reg [31:0] data
    );
        
    always@(inst)
    begin
        if(inst[15]==1)
        begin
            data[31:16]=16'hffff;
        end
        else
        begin
            data[31:16]=16'h0000;
        end
        data[15:0]=inst[15:0];        
    end    
    
endmodule
