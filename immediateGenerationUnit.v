`include "mux_3x1_64bit.v"

module immediateGenerationUnit (instruction, immediate);
    input [31:0] instruction;
    output [63:0] immediate;

    wire [11:0] LWandITypeImmediate;
    wire [11:0] SWTypeImmediate;
    wire [11:0] BTypeImmediate;

    wire [51:0] sign;
    wire wire1, wire2;
    wire [1:0] type;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, immediateGenerationUnit);
    end

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
    assign BTypeImmediate = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]};

    /* reconhece se a instrucao e sw */
    nand (wire1, ~instruction[6], instruction[5], ~instruction[4], ~instruction[3],
               ~instruction[2], instruction[1], instruction[0]);

    /* reconhece se a instrucao e lw */
    and (wire2, ~instruction[6], ~instruction[5], ~instruction[4], ~instruction[3],
               ~instruction[2], instruction[1], instruction[0]);

    or (type[0], wire1, wire2);

    /* reconhece se a instrucao e b*/
    and (type[1], instruction[6], instruction[5], ~instruction[4], ~instruction[3],
               ~instruction[2], instruction[1], instruction[0]);

    /* mux para escolher output */
    mux_3x1_64bit muxImmeadite (.A({sign, LWandITypeImmediate}), .B({sign, SWTypeImmediate}), .C({sign, BTypeImmediate}),
                                .S({type[1], type[0]}), .X(immediate));
endmodule