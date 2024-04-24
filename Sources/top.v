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
    input Trace,            //User based switch that will enable tracing
    //KnobX = PmodJA w/ inA and inB being used from the PmodENC   //KnobY = PmodJB w/ inA and inB being used from the PmodENC
    input [5:4] KnobX, KnobY,   
    input [6:0] sw,
    //LED [3] = Left/ LED[2] = Right / LED[1] = Up / LED[0] Down
    output [3:0] LED,
    output hsync, vsync,
    output [11:0] rgb       //VGA connectors    
    );
    
    //signals
    wire [9:0] w_x, w_y;
    wire w_vid_on, w_p_tick;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    //Initialize the VGA Controller
    vga_controller vga(
        .clk_100MHz(clk), 
        .reset(reset), 
        .video_on(w_vid_on),
        .hsync(hsync), 
        .vsync(vsync), 
        .p_tick(w_p_tick), 
        .x(w_x),
        .y(w_y)
        );
    
    //Initialize the Trace Generation Circuit
    dot_trace_gen Etch(
        .clk_100MHz(clk),
        .reset(reset),
        .video_on(w_vid_on),
        .Trace(Trace),
        .KnobX(KnobX),
        .KnobY(KnobY),
        .sw(sw),
        .x(w_x),
        .y(w_y),
        .LED(LED),
        .rgb(rgb_next)
        ); 

    // rgb buffer
    always @(posedge clk)
        if(w_p_tick)
            rgb_reg <= rgb_next;  
            
    // output
    assign rgb = rgb_reg;
    
endmodule
