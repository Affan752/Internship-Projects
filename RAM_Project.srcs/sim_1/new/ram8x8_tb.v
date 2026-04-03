`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2026 16:03:55
// Design Name: 
// Module Name: ram8x8_tb
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


module ram8x8_tb(

    );
    reg clk, rst, wr_enb, rd_enb;
    reg [2:0] wr_addr, rd_addr;
    reg [7:0] d_in;
    wire [7:0] d_out;
    
    ram8x8 dut(clk, rst, wr_enb, wr_addr, d_in, rd_enb, rd_addr, d_out);
    
    initial 
        begin
            {clk, rst, wr_enb, rd_enb, wr_addr, rd_addr, d_in} = 0;
        end
        
     always #5 clk = ~clk;
     
     initial    
        begin   
            rst = 1;
            #10;
            rst = 0;
            wr_enb = 1;
            wr_addr = 3'b100;
            d_in = 5;
            
            #10;
            wr_enb = 1;
            wr_addr = 3'b101;
            d_in = 14;
            
            #10;
            wr_enb = 0;
            rd_addr = 3'b100;
            
            #10;
            rd_addr = 3'b101;
            #100;
            $finish;
        end
            
     
    
endmodule
