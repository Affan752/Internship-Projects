`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 12:32:28
// Design Name: 
// Module Name: fir_filter_tb
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


`timescale 1ns/1ps

module fir_filter_tb;

parameter N = 16;

// DUT signals
reg clk;
reg rst;
reg [N-1:0] d_in;
wire [N-1:0] d_out;

// Instantiate DUT
fir_filter uut (
    .clk(clk),
    .rst(rst),
    .d_in(d_in),
    .d_out(d_out)
);

// Clock generation (10 ns period)
always #5 clk = ~clk;

initial begin
    // Initialize
    clk = 0;
    rst = 1;
    d_in = 0;

    // Hold reset
    #20;
    rst = 0;

    // Apply inputs
    #10 d_in = 10;
    #10 d_in = 20;
    #10 d_in = 30;
    #10 d_in = 40;
    #10 d_in = 50;
    #10 d_in = 60;
    #10 d_in = 70;

    // Constant input
    #10 d_in = 100;
    #80;

    // End simulation
    $stop;   // Important for Vivado
end

endmodule