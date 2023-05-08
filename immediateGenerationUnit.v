// `include "mux_2x1_64bit.v"

module immediateGenerationUnit (instruction, immediate);
    input [31:0] instruction;
    output [63:0] immediate;

    wire [11:0] LWandITypeImmediate;
    wire [11:0] SWTypeImmediate;

    wire [51:0] sign;

    wire isSW;

    /* 
        Estes sao os sinais para o sinal,
        Transforma para complemento de 2
    */
    assign sign = {instruction[31], instruction[31], instruction[31], instruction[31], instruction[31],
                   instruction[31], instruction[31], instruction[31], instruction[31], instruction[31],
                   instruction[31], instruction[31], instruction[31], instruction[31], instruction[31],
                   instruction[31], instruction[31], instruction[31], instruction[31], instruction[31],
                   instruction[31], instruction[31], instruction[31], instruction[31], instruction[31],
                   instruction[31], instruction[31], instruction[31], instruction[31], instruction[31],
                   instruction[31], instruction[31], instruction[31], instruction[31], instruction[31],
                   instruction[31], instruction[31], instruction[31], instruction[31], instruction[31],
                   instruction[31], instruction[31], instruction[31], instruction[31], instruction[31],
                   instruction[31], instruction[31], instruction[31], instruction[31], instruction[31],
                   instruction[31], instruction[31]};

    /* seta os outputs dependendo das instrucoes */
    assign LWandITypeImmediate = instruction[31:20];
    assign SWTypeImmediate = {instruction[31:25], instruction[11:7]};

    /* reconhece se a instrucao e sw */
    and (isSW, ~instruction[6], instruction[5], ~instruction[4], ~instruction[3],
               ~instruction[2], instruction[1], instruction[0]);

    /* mux para escolher output */
    mux_2x1_64bit muxImmeadite (.A({sign, LWandITypeImmediate}), .B({sign, SWTypeImmediate}),
                                .S(isSW), .X(immediate));
endmodule