`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: fir_filter
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


module fir_filter(clk, rst, d_in, d_out);
input clk, rst;

parameter N = 16;
input [N-1:0] d_in;
output reg [N-1:0] d_out;

// coefficients:- 
//Moving average filter of 3rd order
// it has 4 coefficients:- 1/4 = 0.25, 0.25 x 128 = 32 = 6'b100000
wire [5:0] b0 = 6'b100000;
wire [5:0] b1 = 6'b100000;
wire [5:0] b2 = 6'b100000;
wire [5:0] b3 = 6'b100000;


// creating delays
wire [N-1:0] x1,x2,x3;
DFF DFF0(clk, rst, d_in, x1); // x[n-1]
DFF DFF1(clk, rst, x1, x2);   // x[n-2]
DFF DFF2(clk, rst, x2, x3);   // x[n-3]


//multiplication
wire [N-1:0] mul0, mul1, mul2, mul3;
assign mul0 = d_in * b0;
assign mul1 = x1 * b1;
assign mul2 = x2 * b2;
assign mul3 = x3 * b3;


// addition
wire [N-1:0] sum;
assign sum = mul0 + mul1 + mul2 + mul3;

// Final output
always@(posedge clk)
    d_out <= sum;

endmodule

module DFF(clk, rst, d_in, d_delayed);
input clk, rst;
parameter N = 16;
input [N-1:0] d_in;
output reg [N-1:0] d_delayed;

always@(posedge clk or posedge rst)
    begin
        if(rst)
            d_delayed <= 0;
        else    
            d_delayed <= d_in;
    end
    
    
endmodule
