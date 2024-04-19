`timescale 1ns / 1ps

module debounce_tb;
    reg clk_tb;
    reg Ain_tb;
    reg Bin_tb;
    wire Aout_tb;
    wire Bout_tb;
    
    debounce uut(
        .clk(clk_tb), 
        .Ain(Ain_tb), 
        .Bin(Bin_tb), 
        .Aout(Aout_tb), 
        .Bout(Bout_tb)
    );
    
    initial begin
        clk_tb = 0;
        forever #1 clk_tb = ~clk_tb;
    end
    initial begin
        Ain_tb = 0;
        Bin_tb = 0;
        #10;
        Ain_tb = 1;
        Bin_tb = 1;
        #20;
        Ain_tb = 0;
        Bin_tb = 0;
        #10;
        Ain_tb = 1;
        Bin_tb = 1;
        #30; 
        Ain_tb = 0;
        Bin_tb = 0;
        #10;
        Ain_tb = 1;
        Bin_tb = 1;
        #40;
        Ain_tb = 0;
        Bin_tb = 0;
        #10;
        Ain_tb = 1;
        Bin_tb = 1;
        #30; 
        Ain_tb = 0;
        Bin_tb = 0;
        #10;
        Ain_tb = 1; 
        Bin_tb = 1;
        #60; 
        Ain_tb = 0;
        Bin_tb = 0;
        #100;
        Ain_tb = 0;
        Bin_tb = 1;
        #100;
        Ain_tb = 0;
        Bin_tb = 0;
        #300;
        
        Ain_tb = 0;
        Bin_tb = 0;
        #10;
        Ain_tb = 1;
        Bin_tb = 1;
        #20;
        Ain_tb = 0;
        Bin_tb = 0;
        #10;
        Ain_tb = 1;
        Bin_tb = 1;
        #30; 
        Ain_tb = 0;
        Bin_tb = 0;
        #10;
        Ain_tb = 1;
        Bin_tb = 1;
        #40;
        Ain_tb = 0;
        Bin_tb = 0;
        #10;
        Ain_tb = 1;
        Bin_tb = 1;
        #30; 
        Ain_tb = 0;
        Bin_tb = 0;
        #10;
        Ain_tb = 1; 
        Bin_tb = 1;
        #60; 
        Ain_tb = 0;
        Bin_tb = 0;
        #100;
        Ain_tb = 1;
        Bin_tb = 1;
        #100;
        Ain_tb = 0;
        Bin_tb = 0;
        #300;
        
             
        $finish;
    end
endmodule