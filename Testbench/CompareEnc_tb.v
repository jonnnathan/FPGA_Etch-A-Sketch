`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 06:33:21 PM
// Design Name: 
// Module Name: CompareEnc_tb
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


module CompareEnc_tb;
    reg clk_tb;
    reg reset_tb;
    reg [4:0] Encout_tb;    //Value ranges from 0 to 20 from the encoderout
    wire decrease_tb;
    wire increase_tb;
    
    CompareEnc uut(
        .clk(clk_tb), 
        .reset(reset_tb), 
        .Encout(Encout_tb), 
        .decrease(decrease_tb), 
        .increase(increase_tb)
        );
    
    initial begin
        clk_tb = 5;
        forever #5 clk_tb = ~clk_tb;
    end
    
    
    initial begin
        reset_tb = 0;
        Encout_tb = 0;
        #10;
        Encout_tb = 1;
        #10;
        Encout_tb = 0;
        #10;
        Encout_tb = 3;
        #10;
        Encout_tb = 2;
        #10;
        Encout_tb = 5;
        #10;
        Encout_tb = 6;
        #10;
        Encout_tb = 6;
        #10;
        Encout_tb = 5;
        #10;
        Encout_tb = 4;
        #10;
        Encout_tb = 3;
        #10;
        Encout_tb = 2;
        #10;
        Encout_tb = 1;
        #10;
        Encout_tb = 1;
        #10;
        Encout_tb = 0;
        #10;
        
        $finish;
    end
        
        

                
        
        
    
    

    
    
    
endmodule
