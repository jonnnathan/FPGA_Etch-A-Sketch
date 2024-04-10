`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2024 03:09:28 PM
// Design Name: 
// Module Name: QuadratureDecoder-Xaxis
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

//Code is referenched from https://www.fpga4fun.com/QuadratureDecoder.html
//Will be interfaced with a rotary encoder
//Currently waiting for the rotary encoders to arrive otherwise program will be interfaced with buttons
module QuadratureDecoderYaxis(clk, quadA, quadB, count);
    input clk, quadA, quadB;
    output [7:0] count;


    reg quadA_delayed, quadB_delayed;
    always @(posedge clk) quadA_delayed <= quadA;
    always @(posedge clk) quadB_delayed <= quadB;

    wire count_enable = quadA ^ quadA_delayed ^ quadB ^ quadB_delayed;
    wire count_direction = quadA ^ quadB_delayed;

    reg [7:0] count;
    always @(posedge clk)
    begin
        if(count_enable)
        begin
            if(count_direction) count<=count+1; else count<=count-1;
        end
   end

endmodule;

