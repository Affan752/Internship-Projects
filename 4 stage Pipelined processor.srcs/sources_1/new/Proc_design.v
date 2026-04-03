`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2026 15:09:43
// Design Name: 
// Module Name: Proc_design
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


module Proc_design(
    input clk, rst
    );
    
    // Defining opcoodes for instructions
    parameter ADD = 4'b0001;
    parameter SUB = 4'b0010;
    parameter LOAD = 4'b0011;
    
    // Instruction Memory for 8 instructions
    reg [15:0] instr_mem[0:7];
    
    // Data memory (for LOAD Instruction)
    reg [7:0] data_mem [0:15];
    
    // Register file of 8 registers
    reg [7:0] regfile [0:7];
    
    // Program counter
    reg [2:0] pc;
    
    // Instruction fetch and Instruction decode register
    reg [15:0] IF_ID_instr;
    
    // Instruction decode and Instruction execute register
    reg [3:0] ex_op;
    reg [2:0] ex_rd, ex_rs1, ex_rs2;
    reg [7:0] ex_val1, ex_val2;
    
    // Execute and Writeback register
    reg [3:0] wb_op;
    reg [2:0] wb_rd;
    reg [7:0] wb_result;
    
    // memory initialization
    integer i;
    initial
         begin
            for(i=0; i<8; i=i+1)
                regfile[i] = 0;
                
            // preload memory
            data_mem[3] = 8'd32;
            
        end
        
        
     // Instruction Fetch (IF)
    always @(posedge clk or posedge rst)
         begin
             if (rst)
                 pc <= 0;
             else
                 IF_ID_instr <= instr_mem[pc];
          end
              
              
    // Instruction Decode Cycle 
    always@(posedge clk)
       begin
         ex_op <= IF_ID_instr[15:12];
         ex_rd <= IF_ID_instr[11:9];
         ex_rs1 <= IF_ID_instr[8:6];
         ex_rs2 <= IF_ID_instr[5:3];
         ex_val1 <= regfile[IF_ID_instr[8:6]];
         ex_val2 <= regfile[IF_ID_instr[5:3]];
         pc <= pc + 1;
     end
     
     
     // Execute cycle
     always@(posedge clk)
        begin
            wb_op <= ex_op;
            wb_rd <= ex_rd;
            
            case(ex_op)
                ADD : wb_result <= ex_val1 + ex_val2;
                SUB : wb_result <= ex_val1 - ex_val2;
                LOAD: wb_result <= data_mem[ex_val1];  // here ex_val is used as address for memory location
                default : wb_result <= 8'h00;
            endcase
        end
        
        
        // Writeback cycle
        always@(posedge clk)
            begin
                if(wb_op == ADD | wb_op == SUB | wb_op == LOAD)
                    regfile[wb_rd] <= wb_result;
            end
            
            
        // loading instructions       
          initial
              begin
                  // ADD r1 = r2 + r3
                  instr_mem[0] = {ADD, 3'b001, 3'b010, 3'b011};
                
                  // SUB r4 = r1 - r2
                  instr_mem[1] = {SUB, 3'b100, 3'b001, 3'b011};
                
                  // LOAD r5 = mem[r6]
                  instr_mem[2] = {LOAD, 3'b101, 3'b110, 3'b000};
              end
    
endmodule
