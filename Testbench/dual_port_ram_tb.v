`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 09:37:15 PM
// Design Name: 
// Module Name: dual_port_ram_tb
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


module dual_port_ram_tb;

    reg clk_tb;
    reg we_tb;
    reg [11:0] addr_a_tb;
    reg [11:0] addr_b_tb;
    reg [6:0] din_a_tb;
    wire [6:0] dout_b_tb;
    
    dual_port_ram uut(
        .clk(clk_tb), 
        .we(we_tb), 
        .addr_a(addr_a_tb), 
        .addr_b(addr_b_tb),
        .din_a(din_a_tb), 
        .dout_b(dout_b_tb)
        );
        
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
    end
    
    initial begin
        
        we_tb = 0;
        addr_a_tb = 0;
        addr_b_tb = 0;
        din_a_tb = 0;
        //Write operations
        #10 we_tb = 1'b1;
        #10 addr_a_tb =12'b000000000001; din_a_tb = 7'b0000001;
        #10 addr_a_tb =12'b000000000010; din_a_tb = 7'b0000010;
        #10 addr_a_tb =12'b000000000011; din_a_tb = 7'b0000011;
        #10 addr_a_tb =12'b000000000100; din_a_tb = 7'b0000100;
        #10 addr_a_tb =12'b000000000101; din_a_tb = 7'b0000101;
        #10 addr_a_tb =12'b000000000110; din_a_tb = 7'b0000110;
        #10 addr_a_tb =12'b000000000111; din_a_tb = 7'b0000111;
        //#10 addr_a_tb =12'bxxxxxxxxxxxx; din_a_tb = 7'bxxxxxxx;
        //Read operations
        #10 we_tb = 1'b0;
        #10 addr_b_tb = 12'b000000000001;
        #10 addr_b_tb = 12'b000000000010;
        #10 addr_b_tb = 12'b000000000011;
        #10 addr_b_tb = 12'b000000000100;
        #10 addr_b_tb = 12'b000000000101;
        
       
        
        $finish;
    end             
endmodule
