`include "PC.v"
`include "InstructionMemory.v"
// `include "Adder64b_mod.v"
`include "immediateGenerationUnit.v"
`include "mux_2x1_64bit.v"
/* vide figura index.png */

module instructionSetter (instruction, clk, immediate, selectedFlag);
    input clk, selectedFlag;

    output [31:0] instruction;
    output [63:0] immediate;
    
    wire [63:0] sumOutput;
    wire [63:0] instructionAddr;
    wire [31:0] memoryOutput;

    /* wires da branch, vide index.png */
    wire branch;
    wire isBType;
    wire [63:0] resultMuxBranchOrNextInstr;

    assign instruction = memoryOutput;

    /* faz a branch */
    and (isBType, instruction[6], instruction[5], ~instruction[4], ~instruction[3], ~instruction[2], instruction[1], instruction[0]);
    and (branch, isBType, selectedFlag);

    /* seleciona o que soma no somador, podendo ser branch
       ou a proxima instrucao */
    mux_2x1_64bit muxSelectBranchOrNextInstr (.A(64'd4), .B(immediate), .S(branch), .X(resultMuxBranchOrNextInstr));

    PC PC(.clk(clk), .load(1'b1), .in_data(sumOutput), .out_data(instructionAddr));
    InstructionMemory InstructionMemory (.endereco(instructionAddr), .read_data(memoryOutput));
    
    Adder64b_mod adderInstructionSetter(.A(instructionAddr), .B(resultMuxBranchOrNextInstr), .SUB(1'b0), .S(sumOutput));
    immediateGenerationUnit immediateGenerationUnit(.instruction(memoryOutput), .immediate(immediate));
endmodule