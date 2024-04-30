`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 05:43:19 PM
// Design Name: 
// Module Name: CompareEnc
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


module CompareEnc(
    input clk,
    input reset,
    input [4:0] Encout,         //Provided from the debouncer
    output reg decrease,        //Decrease meaning that the value is less than before and will return a 1
    output reg increase         //Increase meaning that the value is greater and will return a 1
    );
    
    reg [4:0] prev_Encout;
    
    always @(posedge clk) begin
        if (Encout > prev_Encout) begin
            increase <= 1; // Encout has increased
            decrease <= 0;
        end else if (Encout < prev_Encout) begin
            increase <= 0;
            decrease <= 1; // Encout has decreased
        end else begin
            increase <= 0; // Encout remains the same
            decrease <= 0;
        end
    
        prev_Encout <= Encout;
    end
endmodule
