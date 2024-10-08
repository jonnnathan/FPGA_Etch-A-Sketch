`timescale 1ns / 1ps

module vga_test(
	input clk_100MHz,      // from board
	input reset,
	input [11:0] sw,       // 12 bits for color
	output hsync, 
	output vsync,
	output [11:0] rgb      // 12 pins for RGB(4 per color)
);
	
	// Signal Declaration
	reg [11:0] rgb_reg;    // register12-bit RGB DAC 
	wire video_on;         // Same signal as in controller

    // Instantiate VGA Controller
    vga_controller vga_c(.clk_100MHz(clk_100MHz), .reset(reset), .hsync(hsync), .vsync(vsync),
                         .video_on(video_on), .p_tick(), .x(), .y());
    // RGB Buffer
    always @(posedge clk_100MHz or posedge reset)
    if (reset)
       rgb_reg <= 0;
    else
       rgb_reg <= sw;
    
    // Output
    assign rgb = (video_on) ? rgb_reg : 12'b0;   // while in display area RGB color = sw, else all OFF
        
endmodule
