`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2026 16:01:55
// Design Name: 
// Module Name: Proc_design_tb
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


module Proc_design_tb(

    );
    
    // Declaring I/O
    reg clk, rst;
    
    
    // design instantiation
    Proc_design dut(clk, rst);
    
    // initialising inputs
    initial
        begin
            {clk, rst} = 0;
        end
        
    // clock generation
    always #50 clk = ~clk;
    
    
        // providing stimulus
        initial 
            begin
                rst = 1'b1;
                #200;
                rst = 1'b0;
                
                #1000;
                $finish;
            end
endmodule
