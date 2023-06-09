module InstructionMemory(input [63:0] endereco,
                         output [31:0] read_data
                        );
   reg [7:0] Memory [255:0];

   /*
    Memoria 64x32
    Neste caso, foi instanciado em bytes, por isso sao 256 posicoes
   */
   initial begin
    // instrucao teste lw x0, 0(x0)
     Memory[0] = 8'b0_0000011;
     Memory[1] = 8'b0_010_0000;
     Memory[2] = 8'b0000_0000;
     Memory[3] = 8'b00000000;

    //lw x1, 0(x0)
     Memory[4] = 8'b1_0000011;
     Memory[5] = 8'b0_010_0000;
     Memory[6] = 8'b0000_0000;
     Memory[7] = 8'b00000000;

    // lw x2, 8(x0)
     Memory[8] = 8'b0_0000011;
     Memory[9] = 8'b0_010_0001;
     Memory[10] = 8'b1000_0000;
     Memory[11] = 8'b00000000;

    // add x3, x2, x1
     Memory[12] = 8'b1_0110011;
     Memory[13] = 8'b1_000_0001;
     Memory[14] = 8'b0010_0000;
     Memory[15] = 8'b0000000_0;

    // sub x4, x3, x1
     Memory[16] = 8'b0_0110011;
     Memory[17] = 8'b1_000_0010;
     Memory[18] = 8'b0001_0001;
     Memory[19] = 8'b0100000_0;

    // sw x3, 24(x0)
     Memory[20] = 8'b0_0100011;
     Memory[21] = 8'b0_010_1100;
     Memory[22] = 8'b0011_0000;
     Memory[23] = 8'b0000000_0;

    // addi x5, x1, 3
     Memory[24] = 8'b1_0010011;
     Memory[25] = 8'b1_000_0010;
     Memory[26] = 8'b0011_0000;
     Memory[27] = 8'b00000000;
    
    // subi x6, x2, 3
     Memory[28] = 8'b0_0010011;
     Memory[29] = 8'b0_000_0011;
     Memory[30] = 8'b0011_0001;
     Memory[31] = 8'b00000000;
    
    // addi x7, x1, -1
     Memory[32] = 8'b1_0010011;
     Memory[33] = 8'b1_000_0011;
     Memory[34] = 8'b1111_0000;
     Memory[35] = 8'b11111111;
    
    // lw x8, 24(x0)
     Memory[36] = 8'b0_0000011;
     Memory[37] = 8'b0_010_0100;
     Memory[38] = 8'b1000_0000;
     Memory[39] = 8'b00000001;

      // x imm[12|10:5] x4 x2 000 imm[4:1|11] 1100011 BEQ imm = 4
     Memory[40] = 8'b0_1100011; 
     Memory[41] = 8'b0_000_0100;
     Memory[42] = 8'b0100_0001;
     Memory[43] = 8'b0000000_0;
      // x imm[12|10:5] x1 x0 001 imm[4:1|11] 1100011 BNE imm = 4
     Memory[48] = 8'b0_1100011;
     Memory[49] = 8'b0_001_0100;
     Memory[50] = 8'b0001_0000;
     Memory[51] = 8'b0000000_0; 
      // imm[12|10:5] x1 x0 100 imm[4:1|11] 1100011 BLT imm = 4
     Memory[56] = 8'b0_1100011;
     Memory[57] = 8'b0_100_0100;
     Memory[58] = 8'b0001_0000;
     Memory[59] = 8'b0000000_0; 
      // x imm[12|10:5] x0 x1 101 imm[4:1|11] 1100011 BGE imm = 4
     Memory[64] = 8'b0_1100011;
     Memory[65] = 8'b1_101_0100;
     Memory[66] = 8'b0000_0000;
     Memory[67] = 8'b0000000_0;
      // x imm[12|10:5] x1 x0 110 imm[4:1|11] 1100011 BLTU imm = 4
     Memory[72] = 8'b0_1100011; 
     Memory[73] = 8'b0_110_0100;
     Memory[74] = 8'b0001_0000;
     Memory[75] = 8'b0000000_0;
      // x imm[12|10:5] x0 x1 111 imm[4:1|11] 1100011 BGEU imm = 4
     Memory[80] = 8'b0_1100011;  
     Memory[81] = 8'b1_111_0100; 
     Memory[82] = 8'b0000_0000;
     Memory[83] = 8'b0000000_0;

   end
   
   //  assincrono
   assign read_data = {Memory[endereco + 3], Memory[endereco + 2], 
                       Memory[endereco + 1], Memory[endereco + 0]};  
endmodule