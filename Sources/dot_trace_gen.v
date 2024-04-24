`timescale 1ns / 1ps

module dot_trace_gen(
    input clk_100MHz,
    input reset,
    input video_on,
    //In our case set should always be on because the dot tracing is always on in the real life Etch A Sketch
    //But we can change it to allow the user to turn it on or off at any given moment
    input Trace,            //Trace Assignment will be left as an On: Trace, Off: No Trace  
    //KnobX will direct Right and Left / KnobY will direct Up and Down
    //KnobX = PmodJA w/ inA and inB being used from the PmodENC   //KnobY = PmodJB w/ inA and inB being used from the PmodENC
    input [1:0] KnobX, KnobY,
    input [6:0] sw,       
    input [9:0] x, y,
    //Implement LED so that it can indicate direction for feedback
    //LED [3] = Left/ LED[2] = Right / LED[1] = Up / LED[0] Down
    output [3:0] LED,      
    output reg [11:0] rgb   //RGB for signals
    );
    
    
    // signal declaration
    // ascii ROM
    wire [10:0] rom_addr;
    wire [6:0] char_addr;
    wire [3:0] row_addr;
    wire [2:0] bit_addr;
    wire [7:0] font_word;
    wire ascii_bit;
    
    
    //tile RAM
    wire we;                //write enable to RAM
    wire [11:0] addr_r, addr_w;         //Read and write
    wire [6:0] din, dout;              
    
    //80 by 30 tile map
    parameter MAX_X = 80;   //640 pixels / 8 data bits = 80
    parameter MAX_Y = 30;   //480 pixels / 16 data bits = 30
    
    // cursor
    reg [6:0] cur_x_reg;
    wire [6:0] cur_x_next;
    reg [4:0] cur_y_reg;
    wire [4:0] cur_y_next;
    wire move_x_Left, move_x_Right, move_y_Up, move_y_Down, cursor_on;
    // delayed pixel count
    reg [9:0] pix_x1_reg, pix_y1_reg;
    reg [9:0] pix_x2_reg, pix_y2_reg;
    // object output signals
    wire [11:0] text_rgb, text_rev_rgb;
    
    //internal wires
    //wire [4:0] w_enc1, w_enc2;
    
    //Body
    // Initialize debounce for buttons if used
    //Initialize Debounce/Encoder for Rotary Encoder if used
    
    //Debounce Module for both rotary encoder which contain two inputs
    debounce KnobX_db(.clk(clk_100MHz), .Ain(KnobX[0]), .Bin(KnobX[1]), .Aout(w_Knob_Down), .Bout(w_Knob_Up));         
    debounce KnobY_db(.clk(clk_100MHz), .Ain(KnobY[0]), .Bin(KnobY[1]), .Aout(w_Knob_Left), .Bout(w_Knob_Right));
    
    debounce_chu KnobUp(.clk(clk_100MHz), .reset(reset), .sw(w_Knob_Up), .db_level(), .db_tick(move_y_Up));
    debounce_chu KnobDown(.clk(clk_100MHz), .reset(reset), .sw(w_Knob_Down), .db_level(), .db_tick(move_y_Down));
    debounce_chu KnobLeft(.clk(clk_100MHz), .reset(reset), .sw(w_Knob_Left), .db_level(), .db_tick(move_x_Left));
    debounce_chu KnobRight(.clk(clk_100MHz), .reset(reset), .sw(w_Knob_Right), .db_level(), .db_tick(move_x_Right));
    
    //Encoder module for both rotary encoders which works on an FSM
    //encoder  KnobY_enc(.clk(clk_100MHz), .A(w_Knob_Right), .B(w_Knob_Left), .BTN(), .EncOut(w_enc2), .LED(LED[3:2]));
    //encoder  KnobX_enc(.clk(clk_100MHz), .A(w_Knob_Up), .B(w_Knob_Down), .BTN(), .EncOut(w_enc1), .LED(LED[1:0]));
    
    
    ascii_rom ascrom(.clk(clk_100MHz), .addr(rom_addr), .data(font_word));
    
    //instatiate the dual-port video RAM
    dual_port_ram dp_ram(.clk(clk_100MHz), .we(we), .addr_a(addr_w), .addr_b(addr_r),
                             .din_a(din), .dout_a(), .dout_b(dout));

    // registers
    //I believe that this operation will save the location of the cursor 
    //to where it corresponds on the display
    always @(posedge clk_100MHz or posedge reset)
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
    //Will write the x and y location of the cursor to the RAM
    assign addr_w = {cur_y_reg, cur_x_reg};  
    assign we = Trace;
    assign din = sw;   
    // tile RAM read
    // use nondelayed coordinates to form tile RAM address
    assign addr_r = {y[8:4], x[9:3]};
    
    
    //BELOW IS FOR USING ASCII ROM BUT WE WILL NOT BE USING ASCII ROM
    assign char_addr = dout;
    //font ROM
    assign row_addr = y[3:0];
    assign rom_addr = {char_addr, row_addr};
    // use delayed coordinate to select a bit
    assign bit_addr = pix_x2_reg[2:0];
    assign ascii_bit = font_word[~bit_addr];
    
    
    // new cursor position
    assign cur_x_next = (move_x_Right && (cur_x_reg == MAX_X - 1)) || (move_x_Left && (cur_x_reg == 0)) ? 0 :    
                        (move_x_Right) ? cur_x_reg + 1 :    // move right
                        (move_x_Left) ? cur_x_reg - 1 :    // move left
                        cur_x_reg;                          // no move
                                           
    assign cur_y_next = (move_y_Up && (cur_y_reg == 0)) || (move_y_Down && (cur_y_reg == MAX_Y - 1)) ? 0 :    
                        (move_y_Up) ? cur_y_reg - 1 :    // move up                        
                        (move_y_Down) ? cur_y_reg + 1 :    // move down
                        cur_y_reg;                          // no move           

    // object signals
    
    //Below is irrelevant and applies to ASCII ROM
    // green over black and reversed video for cursor

    assign text_rgb = (ascii_bit) ? 12'h000 : 12'hFFF;
    assign text_rev_rgb = (ascii_bit) ? 12'hAAA : 12'hFFF;
    // use delayed coordinates for comparison
    
    assign cursor_on = (pix_y2_reg[8:4] == cur_y_reg) &&
                       (pix_x2_reg[9:3] == cur_x_reg);
// rgb multiplexing circuit
   always @*
       if(~video_on)
           rgb = 12'h000;     // blank
       else
           if(cursor_on)
               rgb = text_rev_rgb;
           else
               rgb = text_rgb;
     
endmodule