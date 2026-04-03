`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2026 11:19:40
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A,B, input [2:0] ctrl,
    output [31:0] result,
    output Z, N, V, C      // flags:- Zero, Negative, Overflow, Carry respectively
    );
    
    // AND and OR operations
    wire [31:0] a_and_b, a_or_b;
    
    assign a_and_b = A & B;
    assign a_or_b = A | B;
    
    // addition and subtraction
    wire [31:0] B_bar;
    assign B_bar = ~B;
    
    wire [31:0] mux_1;
    assign mux_1 = (ctrl[0] == 0) ? B : B_bar;
    
    wire [31:0] sum;
    wire cout;     // carry generated during operations
    assign {cout,sum} = A + mux_1 + ctrl[0]; // result of operation is stored in sum, 
                                             //  and carry is stored in cout
    
    // Zero extension
    wire slt;
    assign slt = {{31{1'b0}},sum[31]};
    
    // assigning final result
    assign result = (ctrl[2:0] == 3'b000) ? sum : 
                    (ctrl[2:0] == 3'b001) ? sum : 
                    (ctrl[2:0] == 3'b010) ? a_and_b :
                    (ctrl[2:0] == 3'b011) ? a_or_b :
                    (ctrl[2:0] == 3'b101) ? slt: 32'h0000_0000;
     
    // flags assignment 
    assign Z = &(~result); // Zero flag
    
    assign N = result[31]; // Negative flag --> 0 means positive , 1 means negative
    
    assign C = cout & (~ctrl[1]); // carry flag
    
    assign V = (~ctrl[1]) & (A[31] ^ sum[31]) & (~(A[31] ^ B[31] ^ ctrl[0])); // Overflow flag
     
endmodule
