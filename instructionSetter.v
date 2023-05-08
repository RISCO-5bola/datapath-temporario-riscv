`include "PC.v"
`include "InstructionMemory.v"
// `include "Adder64b_mod.v"
`include "immediateGenerationUnit.v"

/* vide figura index.png */

module instructionSetter (instruction, clk, immediate);
    input clk;
    output [31:0] instruction;
    output [63:0] immediate;
    
    wire [63:0] sumOutput;
    wire [63:0] instructionAddr;

    wire [31:0] memoryOutput;

    assign instruction = memoryOutput;

    PC PC(.clk(clk), .load(1'b1), .in_data(sumOutput), .out_data(instructionAddr));
    InstructionMemory InstructionMemory (.endereco(instructionAddr), .read_data(memoryOutput));
    Adder64b_mod adderInstructionSetter(.A(instructionAddr), .B(64'd4), .SUB(1'b0), .S(sumOutput));
    immediateGenerationUnit immediateGenerationUnit(.instruction(memoryOutput), .immediate(immediate));
endmodule