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
    input clk_100MHz, 
    input reset,
    input video_on,
    //In our case set should always be on because the dot tracing is always on in the real life Etch A Sketch
    //But we can change it to allow the user to turn it on or off at any given moment
    input Trace,            //Trace Assignment will be left as an On: Trace, Off: No Trace           
    input Knob_Up,          //Rotary Encoder (Right): Up Motion 
    input Knob_Down,        //Rotary Encoder (Right): Down Motion
    input Knob_Left,        //Rotary Encoder (Left): Left Motion
    input Knob_Right,       //Rotary Encoder (Left): Right Motion
    //input [6:0] sw,         //Is Supposed to be used for ascii according to Example but will not be used like that
    input [9:0] x, y,       //
    output reg [11:0] rgb   //RGB for signals
    );
    
    //tile RAM
    wire we;
    wire [11:0] addr_r, addr_w;
    wire [6:0] din, dout;
    
    //80 by 30 tile map
    parameter MAX_X = 80;   //640 pixels / 8 data bits = 80
    parameter MAX_Y = 30;   //480 pixels / 16 data bits = 30
    
    // cursor
    reg [6:0] cur_x_reg;
    wire [6:0] cur_x_next;
    reg [4:0] cur_y_reg;
    wire [4:0] cur_y_next;
    wire move_xl_tick, move_yu_tick, move_xr_tick, move_yd_tick, cursor_on;
    // delayed pixel count
    reg [9:0] pix_x1_reg, pix_y1_reg;
    reg [9:0] pix_x2_reg, pix_y2_reg;
    // object output signals
    wire [11:0] text_rgb, text_rev_rgb;
    
    //internal wires
    wire [4:0] w_enc1, w_enc2;
    
    //Body
    // Initialize debounce for buttons if used
    //Initialize Debounce/Encoder for Rotary Encoder if used
    debounce RotaryEncoder1_db(.clk(clk_100MHz), .Ain(Knob_Up), .Bin(Knob_Down), .Aout(w_Knob_Up), .Bout(w_Knob_Down));
    debounce RotaryEncoder2_db(.clk(clk_100MHz), .Ain(Knob_Right), .Bin(Knob_Left), .Aout(w_Knob_Right), .Bout(w_Knob_Left));
    encoder  RotaryEncoder1_enc(.clk(clk_100MHz), .A(w_Knob_Up), .B(w_Knob_Down), .BTN(), .EncOut(w_enc1), .LED());
    encoder  RotaryEncoder2_enc(.clk(clk_100MHz), .A(w_Knob_Right), .B(w_Knob_Left), .BTN(), .EncOut(w_enc2), .LED());
    
    
    //instatiate the dual-port video RAM
    dual_port_ram dp_ram(.clk(clk), .we(we), .addr_a(addr_w), .addr_b(addr_r),
                             .din_a(din), .dout_a(), .dout_b(dout));
    
    
    // registers
    always @(posedge clk or posedge reset)
        if(reset) begin
            cur_x_reg <= 0;
            cur_y_reg <= 0;
            pix_x1_reg <= 0;
            pix_x2_reg <= 0;
            pix_y1_reg <= 0;
            pix_y2_reg <= 0;
        end    
        else begin
            cur_x_reg <= cur_x_next;
            cur_y_reg <= cur_y_next;
            pix_x1_reg <= x;
            pix_x2_reg <= pix_x1_reg;
            pix_y1_reg <= y;
            pix_y2_reg <= pix_y1_reg;
        end    

    //tile RAM write
    assign addr_w = {cur_y_reg, cur_x_reg};
    assign we = Trace;
    //assign din = sw;   

    // tile RAM read
    // use nondelayed coordinates to form tile RAM address
    assign addr_r = {y[8:4], x[9:3]};
    assign char_addr = dout;
    // font ROM
    assign row_addr = y[3:0];
    assign rom_addr = {char_addr, row_addr};
    // use delayed coordinate to select a bit
    assign bit_addr = pix_x2_reg[2:0];
    //assign ascii_bit = font_word[~bit_addr];
    // new cursor position
    assign cur_x_next = (move_xr_tick && (cur_x_reg == MAX_X - 1)) || (move_xl_tick && (cur_x_reg == 0)) ? 0 :    
                        (move_xr_tick) ? cur_x_reg + 1 :    // move right
                        (move_xl_tick) ? cur_x_reg - 1 :    // move left
                        cur_x_reg;                          // no move
                                           
    assign cur_y_next = (move_yu_tick && (cur_y_reg == 0)) || (move_yd_tick && (cur_y_reg == MAX_Y - 1)) ? 0 :    
                        (move_yu_tick) ? cur_y_reg - 1 :    // move up                        
                        (move_yd_tick) ? cur_y_reg + 1 :    // move down
                        cur_y_reg;                          // no move   

endmodule
