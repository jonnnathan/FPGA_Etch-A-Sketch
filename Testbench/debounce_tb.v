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
    //For Ain_tb
    initial begin
    /////////////////////////////////////////////////////////////////////////
        Ain_tb = 0;                                                        //
        #200;                                                              //This test cycle is to produce a 
        Ain_tb = 1;                                                        //clockwise rotation, since the
        #200;                                                              //following sequence produces
        Ain_tb = 1;                                                        //an increment rotation
        #200;                                                              //11, 10, 00, 01, 11
        Ain_tb = 1;                                                        //
        #200;                                                              //
        Ain_tb = 0;                                                        //
        #200;                                                              //
        Ain_tb = 0;                                                        //
        #200;                                                              //
        Ain_tb = 1;                                                        //
        #200;                                                              //
    /////////////////////////////////////////////////////////////////////////
    
    /////////////////////////////////////////////////////////////////////////
        Ain_tb = 0;                                                        //
        #200;                                                              //This test cycle is to produce a 
        Ain_tb = 1;                                                        //counterclockwise rotation, since the
        #200;                                                              //since the following sequence produces
        Ain_tb = 1;                                                        //an decrement rotation
        #200;                                                              //11, 01, 00, 10, 11
        Ain_tb = 0;                                                        //
        #200;                                                              //
        Ain_tb = 0;                                                        //
        #200;                                                              //
        Ain_tb = 1;                                                        //
        #200;                                                              //
        Ain_tb = 1;                                                        //
        #200;                                                              //
    /////////////////////////////////////////////////////////////////////////
        $finish;
        
    end
    //For Bin_tb
    initial begin
    /////////////////////////////////////////////////////////////////////////
        Bin_tb = 0;                                                        //
        #200;                                                              //Similar to test cases in A
        Bin_tb = 1;                                                        //Counter Clockwise Read
        #200;                                                              //
        Bin_tb = 1;                                                        //
        #200;                                                              //
        Bin_tb = 0;                                                        //
        #200;                                                              //
        Bin_tb = 0;                                                        //
        #200;                                                              //
        Bin_tb = 1;                                                        //
        #200;                                                              //
        Bin_tb = 1;                                                        //
        #200;                                                              //
     /////////////////////////////////////////////////////////////////////////
     
     /////////////////////////////////////////////////////////////////////////
         Bin_tb = 0;                                                        //
         #200;                                                              //Similar to test cases in A
         Bin_tb = 1;                                                        //Counter Clockwise Read
         #200;                                                              //
         Bin_tb = 1;                                                        //
         #200;                                                              //
         Bin_tb = 1;                                                        //
         #200;                                                              //
         Bin_tb = 0;                                                        //
         #200;                                                              //
         Bin_tb = 0;                                                        //
         #200;                                                              //
         Bin_tb = 1;                                                        //
         #200;                                                              //
      /////////////////////////////////////////////////////////////////////////
        $finish;
    end
    
endmodule