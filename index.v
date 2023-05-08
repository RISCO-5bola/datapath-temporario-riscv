`include "datapath.v"
`include "instructionSetter.v"

module index (
    input writeEnable_DataMemory,
    input writeEnable_Registers,
    input muxSelect_SumVsReadData,
    input muxSelect_ImmVsDataout2, //Sinal mandando para o mux2 selecionar entre immediate (operacao S) ou dataout2 (na operacao aritmetica)
    input SumOrSub, //Sinal mandando para o somador/subtrador. - quando 1 indica a subtracao
    input clk
);
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, index);
    end
    wire [31:0] instruction;
    wire [63:0] immediate;

    instructionSetter instructionSetter (.clk(clk), .instruction(instruction), .immediate(immediate));
    datapath datapath (.clk(clk), .immediate(immediate), .readRegister1(instruction[19:15]), .readRegister2(instruction[24:20]),
                       .writeRegister(instruction[11:7]), .writeEnable_Registers(writeEnable_Registers),
                       .writeEnable_DataMemory(writeEnable_DataMemory), .muxSelect_ImmVsDataout2(muxSelect_ImmVsDataout2),
                       .muxSelect_SumVsReadData(muxSelect_SumVsReadData), .SumOrSub(SumOrSub));
endmodule