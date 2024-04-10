`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2024 07:23:36 PM
// Design Name: 
// Module Name: dot_trace_gen
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


module dot_trace_gen(
    input clk, 
    input reset,
    input video_on,
    //In our case set should always be on because the dot tracing is always on in the real life Etch A Sketch
    //But we can change it to allow the user to turn it on or off at any given moment
    input Trace,              
    input Knob_Up,          //Rotary Encoder (Right): Up Motion 
    input Knob_Down,        //Rotary Encoder (Right): Down Motion
    input Knob_Left,        //Rotary Encoder (Left): Left Motion
    input Knob_Right,       //Rotary Encoder (Left): Right Motion
    input [6:0] sw,         //Is Supposed to be used for ascii according to Example but will not be used like that
    input [9:0] x, y,       //
    output reg [11:0] rgb   //RGB for signals
    );
    
    
    
    
    
    
    
    
    
    // Initialize debounce for buttons if used
    
    
    //Initialize QuadratureDecoder for Rotary Encoder if used
    
    
    
endmodule
