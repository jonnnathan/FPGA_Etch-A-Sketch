`timescale 1ns / 1ps

module vga_controller_tb;

    // Inputs
    reg clk_100MHz_tb;
    reg reset_tb;

    // Outputs
    wire video_on_tb;
    wire hsync_tb;
    wire vsync_tb;
    wire p_tick_tb;
    wire [9:0] x_tb;
    wire [9:0] y_tb;

    // Instantiate the VGA controller
    vga_controller uut(
        .clk_100MHz(clk_100MHz_tb),
        .reset(reset_tb),
        .video_on(video_on_tb),
        .hsync(hsync_tb),
        .vsync(vsync_tb),
        .p_tick(p_tick_tb),
        .x(x_tb),
        .y(y_tb)
    );

    always begin
        clk_100MHz_tb = 0;
        forever #5 clk_100MHz_tb = ~clk_100MHz_tb;
    end
    
    initial begin
        reset_tb = 1;
        #100;
        reset_tb = 0;
        #20_000_000 $finish; //On top of this the simulation has to be set to be ran for around 16.8ms 
        //To do the whole screen refresh we would need to run the fimulation for 1s which takes a long time to load
        //In order to see 60 vertical syncs
    end

endmodule