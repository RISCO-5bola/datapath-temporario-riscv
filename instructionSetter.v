`include "PC.v"
`include "./Memory/InstructionMemory.v"
// `include "Adder64b_mod.v"
`include "immediateGenerationUnit.v"
`include "./Mux/mux_2x1_64bit.v"
/* vide figura index.png */

module instructionSetter (instruction, clk, immediate, selectedFlag, reset);
    input clk, selectedFlag, reset;

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
    /* verifica se e do tipo B */ 
    and (isBType, instruction[6], instruction[5], ~instruction[4], ~instruction[3], ~instruction[2], instruction[1], instruction[0]);
    /* and que controla se a branch sera realizada ou nao */
    and (branch, isBType, selectedFlag);

    /* seleciona o que soma no somador, podendo ser branch
       ou a proxima instrucao (somando +4) */
    mux_2x1_64bit muxSelectBranchOrNextInstr (.A(64'd4), .B(immediate), .S(branch), .X(resultMuxBranchOrNextInstr));

    PC PC(.clk(clk), .load(1'b1), .in_data(sumOutput), .out_data(instructionAddr), .reset(reset));
    InstructionMemory InstructionMemory (.endereco(instructionAddr), .read_data(memoryOutput));
    
    /* calcula a proxima instrucao recebendo o resultado do mux */
    Adder64b_mod adderInstructionSetter(.A(instructionAddr), .B(resultMuxBranchOrNextInstr), .SUB(1'b0), .S(sumOutput));
    immediateGenerationUnit immediateGenerationUnit(.instruction(memoryOutput), .immediate(immediate));
endmodule