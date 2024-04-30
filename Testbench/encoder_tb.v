`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 09:11:59 PM
// Design Name: 
// Module Name: encoder_tb
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


module encoder_tb;
    reg clk_tb;
    reg A_tb;
    reg B_tb;
    wire [4:0] EncOut_tb;
    wire [1:0] LED_tb;
    
    encoder uut (
        .clk(clk_tb),
        .A(A_tb),
        .B(B_tb),
        .EncOut(EncOut_tb),
        .LED(LED_tb)
    );
    
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
    end
    //For A_tb
    initial begin
        //clk_tb = 0;
        A_tb = 1;
        #100;
        //Incrementing
        A_tb = 1;
        #10;
        A_tb = 1;
        #10;
        A_tb = 0;
        #10;
        A_tb = 0;
        #10;
        A_tb = 1;
        #10;

        //Decrementing
        A_tb = 1;
        #10;
        A_tb = 0;
        #10;
        A_tb = 0;
        #10;
        A_tb = 1;
        #10;
        A_tb = 1;
        #10;
        
                //Incrementing
        A_tb = 1;
        #10;
        A_tb = 1;
        #10;
        A_tb = 0;
        #10;
        A_tb = 0;
        #10;
        A_tb = 1;
        #10;
        
        //Decrementing
        A_tb = 1;
        #10;
        A_tb = 0;
        #10;
        A_tb = 0;
        #10;
        A_tb = 1;
        #10;
        A_tb = 1;
        #10;
        
        //Decrementing
        A_tb = 1;
        #10;
        A_tb = 0;
        #10;
        A_tb = 0;
        #10;
        A_tb = 1;
        #10;
        A_tb = 1;
        #10;
        $finish;
    end
    
    //For B_tb
    initial begin
        //clk_tb = 0;
        B_tb = 1;
        #100;
        //Incrementing
        B_tb = 1;
        #10;
        B_tb = 0;
        #10;
        B_tb = 0;
        #10;
        B_tb = 1;
        #10;
        B_tb = 1;
        #10;
        
        //Decrementing
        B_tb = 1;
        #10;
        B_tb = 1;
        #10;
        B_tb = 0;
        #10;
        B_tb = 0;
        #10;
        B_tb = 1;
        #10;

        //Incrementing
        B_tb = 1;
        #10;
        B_tb = 0;
        #10;
        B_tb = 0;
        #10;
        B_tb = 1;
        #10;
        B_tb = 1;
        #10;
        
        
                
        //Decrementing
        B_tb = 1;
        #10;
        B_tb = 1;
        #10;
        B_tb = 0;
        #10;
        B_tb = 0;
        #10;
        B_tb = 1;
        #10;
        
        //Decrementing
        B_tb = 1;
        #10;
        B_tb = 1;
        #10;
        B_tb = 0;
        #10;
        B_tb = 0;
        #10;
        B_tb = 1;
        #10;
        
        $finish;
    end
    
endmodule
