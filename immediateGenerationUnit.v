`include "./Mux/mux_3x1_64bit.v"
module immediateGenerationUnit (instruction, immediate);
    input [31:0] instruction;
    output [63:0] immediate;

    wire [11:0] LWandAddiTypeImmediate;
    wire [11:0] SWTypeImmediate;
    wire [11:0] BTypeImmediate;

    wire [50:0] sign;
    wire wire1, wire2, wire3;
    wire [1:0] type;

    /* Estes sao os sinais para o sinal,
        Transforma para complemento de 2 */
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
                   instruction[31]};

    /* seta os outputs dependendo das instrucoes */
    assign LWandAddiTypeImmediate = instruction[31:20];
    assign SWTypeImmediate = {instruction[31:25], instruction[11:7]};
    assign BTypeImmediate = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]};

    /* reconhece se a instrucao e lw */
    and (wire1, ~instruction[6], ~instruction[5], ~instruction[4], ~instruction[3],
               ~instruction[2], instruction[1], instruction[0]);

    /* reconhece se a instrucao e addi */
    and (wire2, ~instruction[6], ~instruction[5], instruction[4], ~instruction[3],
               ~instruction[2], instruction[1], instruction[0]);

    /* reconhece se a instrucao e sw */
    nand (wire3, ~instruction[6], instruction[5], ~instruction[4], ~instruction[3],
               ~instruction[2], instruction[1], instruction[0]);

    /* se a instrucao for addi ou lw nao importa porque as duas instrucoes tem o 
       immediate na mesma posicao da instrucao, entao se qualquer um deles for 1
       o nand retorna um 0 e esse sera o valor de type[0] se a instrucao for de
       sw, o and retornara 1 e o valor de type[0] sera 1 */
    nor (type[0], wire1, wire2, wire3);

    /* reconhece se a instrucao e b e coloca em type[2]*/
    and (type[1], instruction[6], instruction[5], ~instruction[4], ~instruction[3],
               ~instruction[2], instruction[1], instruction[0]);

    /* mux para escolher output 
       se type[1:0] = 00, sai o immediate do addi ou lw
       se type[1:0] = 01, sai o immediate do sw
       se type[1:0] = 10, sai o immediate do b */
    mux_3x1_64bit muxImmeadite (.A({sign, instruction[31], LWandAddiTypeImmediate}), .B({sign, instruction[31], SWTypeImmediate}), 
                                .C({sign, BTypeImmediate, 1'b0}), .S({type[1], type[0]}), .X(immediate));
endmodule