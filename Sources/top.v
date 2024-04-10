`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2024 02:54:06 PM
// Design Name: 
// Module Name: top
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


module top(
    input clk,              //100Mhz clock that will come from the Board
    input reset,            //Reset switch assigned to *SWITCH*
    input Knob_Up,          //Rotary Encoder (Right): Up Motion 
    input Knob_Down,        //Rotary Encoder (Right): Down Motion
    input Knob_Left,        //Rotary Encoder (Left): Left Motion
    input Knob_Right,       //Rotary Encoder (Left): Right Motion
    input [3:0] sw,
    output hsync,
    output vsync,
    output [11:0] rgb
    );
    
    //signals
    wire video_on;
    
    //Initialize the VGA Controller
    vga_controller vga(
        .clk_100MHz(clk), 
        .reset(reset), 
        .video_on(video_on),
        .hsync(hsync), 
        .vsync(vsync), 
        .p_tick(   ), 
        .x(   ),
        .y(   )
        );
    
    //Initialize the Trace Generation Circuit
    
    
    
    
    
endmodule
