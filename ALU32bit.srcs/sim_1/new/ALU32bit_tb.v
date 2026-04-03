`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2026 15:42:50
// Design Name: 
// Module Name: ALU32bit_tb
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


module ALU32bit_tb(

    );
    
    // ports declaration
    reg [31:0] A, B;
    reg [2:0] ctrl;
    wire [31:0] result;
    wire Z, N, V, C;
    
    // instantiation of design
    ALU dut(A, B, ctrl, result, Z, N, V, C);
    
    // initialization of inputs
    initial
        begin
            {A, B, ctrl} = 0;
        end
        
    // giving test inputs
    initial
        begin
            A = 32'h1010_0001;
            B = 32'h0010_0110;
            ctrl = 3'b000;
            #10;
            ctrl = 3'b010;
            #10;
            
            A = 32'h1101_1001;
            B = 32'h1010_1010;
            ctrl = 3'b000;
            #10;
            
            ctrl = 3'b011;
            
            #10;
            ctrl = 3'b101;
            
           #10;
            $finish;
       end
    
endmodule
