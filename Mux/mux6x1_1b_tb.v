`timescale 1ns/1ns

module mux6x1_1b_tb;

    // Entradas
    reg BEQ, BNE, BLT, BGE, BLTU, BGEU;
    reg [2:0] funct3;

    wire selectedFlag;

    mux6x1_1b UUT (.BEQ(BEQ), .BNE(BNE), .BLT(BLT), .BGE(BGE), .BLTU(BLTU), .BGEU(BGEU), 
                    .funct3(funct3), .selectedFlag(selectedFlag));

    initial begin
        $monitor ("[%t] BEQ = %b BNE = %b BLT = %b BGE = %b BLTU = %b BGEU = %b funct3 = %d selectedFlag = %b", 
                  $time, BEQ, BNE, BLT, BGE, BLTU, BGEU, funct3, selectedFlag);

                // Inicializar os inputs 
        funct3 <= 3'b000; 
        BEQ <=1'b0; BNE <=1'b0; BLT <=1'b0;
        BGE <= 1'b0; BLTU <= 1'b0; BGEU <= 1'b0;
        #10

        // Teste 1:
        funct3 <= 3'b000; 
        BEQ <=1'b1; BNE <=1'b0; BLT <=1'b0;
        BGE <= 1'b0; BLTU <= 1'b0; BGEU <= 1'b0;
        // BEQ = 1
        #10

        // Teste 2:
        funct3 <= 3'b001; 
        BEQ <=1'b0; BNE <=1'b1; BLT <=1'b0;
        BGE <= 1'b0; BLTU <= 1'b0; BGEU <= 1'b0;
        // BNE = 1
        #10

        // Teste 3:
        funct3 <= 3'b100; 
        BEQ <=1'b0; BNE <=1'b0; BLT <=1'b1;
        BGE <= 1'b0; BLTU <= 1'b0; BGEU <= 1'b0;
        // BLT = 1
        #10

        // Teste 4:
        funct3 <= 3'b101; 
        BEQ <=1'b0; BNE <=1'd0; BLT <=1'd0;
        BGE <= 1'b1; BLTU <= 1'b0; BGEU <= 1'b0;
        // BGE = 1
        #10

        // Teste 5:
        funct3 <= 3'b110; 
        BEQ <=1'b0; BNE <=1'b0; BLT <=1'b0;
        BGE <= 1'b0; BLTU <= 1'b1; BGEU <= 1'b0;
        // BLTU = 1
        #10

        // Teste 6:
        funct3 <= 3'b111; 
        BEQ <=1'b0; BNE <=1'b0; BLT <=1'b0;
        BGE <= 1'b0; BLTU <= 1'b0; BGEU <= 1'b1;
        // BGEU = 1
        #10
        
        $finish;
    end
endmodule

