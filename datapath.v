// GRUPO 3 
// Celso Tadaki Sinoka
// Felipe Luis Korbes
// Lucas Suzin Bertan

`include "registradores.v"
`include "memory.v"
`include "Adder64b_mod.v"
`include "mux_2x1_64bit.v"
`include "mux_2x1_64b_ImOrData2.v"//O Mux que seleciona entre immediate e o data2 para mandar para o somador de 64 bits.

// a implementacao se baseou no fluxo de dados do
// proprio risc-v

module datapath (
    input [63:0] immediate, // uma constante setavel
    input [4:0] readRegister1, // o endereco do qual se lê o "x2"
    input [4:0] readRegister2, // o endereco do qual se tira o "x1"
    input [4:0] writeRegister, // o endereco no qual se salva o valor no registrador
    input writeEnable_DataMemory,
    input writeEnable_Registers,
    input muxSelect_SumVsReadData,
    input muxSelect_ImmVsDataout2, //Sinal mandando para o mux2 selecionar entre immediate (operacao S) ou dataout2 (na operacao aritmetica)
    input SumOrSub, //Sinal mandando para o somador/subtrador. - quando 1 indica a subtracao
    input clk
);
    //sinais e instanciacao do banco de registradores;

//    wire[63:0] writeData; //valor a ser salvo no banco de registradores;
    wire[63:0] dataOut1; //data tirada do readData1 do banco de registrador - teoricamente o valor do x2;
    wire[63:0] dataOut2; //data tirada do readData 2 do banco - teoricamente o valor do x1;
    wire[63:0] dataWriteOnRegisterBank;
    wire[63:0] result_soma; //endereco do data memory especificado pela soma obtida do somador.
    wire[63:0] result_selection_mux;
    wire[63:0] result_selection_mux_2;
    
    registradores registradores(.readRegister1(readRegister1), .readRegister2(readRegister2),
    .writeRegister(writeRegister), .writeData(result_selection_mux), .regWrite(writeEnable_Registers),
    .clk(clk), .readData1(dataOut1), .readData2(dataOut2));

    //sinais e instanciacao do datamemory
    //aqui a ideia eh salvar o valor de x1 no x2 + immediate;

    data_memory data_memory(.clk(clk), .mem_read(1'b1), .mem_write(writeEnable_DataMemory),
    .endereco(result_soma[7:0]), .write_data(dataOut2), .read_data(dataWriteOnRegisterBank));

    //instanciacao do somador de 64 bits;

    Adder64b_mod Adder64_mod(.A(dataOut1), .B(result_selection_mux_2), .SUB(SumOrSub), .S(result_soma));

    //instanciando o mux;
    mux_2x1_64bit mux_2x1_64bit(.S(muxSelect_SumVsReadData), .A(dataWriteOnRegisterBank),
    .B(result_soma), .X(result_selection_mux));

    //instanciando o mux2:
    mux_2x1_64b_ImOrData2 mux_2x1_64b_ImOrData2(.SelectImOrData2(muxSelect_ImmVsDataout2), .Immediate(immediate),
    .DataOut2(dataOut2), .X(result_selection_mux_2));

endmodule

