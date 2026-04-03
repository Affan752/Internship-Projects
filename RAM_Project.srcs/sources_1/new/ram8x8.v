`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2026 15:52:15
// Design Name: 
// Module Name: ram8x8
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


module ram8x8(
    input clk, rst, wr_enb,
    input [2:0] wr_addr, input [7:0] d_in,
    input rd_enb, input [2:0] rd_addr, 
    output reg [7:0] d_out
    );
    
    // creating internal memory
    reg [7:0] mem[7:0];
    
    // write logic and read logic
    integer i;
    always@(posedge clk )
        begin
            if(rst) begin
                for(i=0; i<8; i=i+1)
                    mem[i] <= 0;
                    end
                 else
                    if(wr_enb == 1) // write operation
                        mem[wr_addr] <= d_in;
                    else if(wr_enb == 0) // read operation
                        d_out <= mem[wr_addr];
          end
                    
    
endmodule
