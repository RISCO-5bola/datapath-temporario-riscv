module InstructionMemory(input [63:0] endereco,
                         output [31:0] read_data
                        );
   reg [7:0] Memory [255:0];

   /*
    Memoria 64x32
    Neste caso, foi instanciado em bytes, por isso sao 256 posicoes
   */
   initial begin
    //lw x1, 0(x0)
     Memory[0] = 8'b1_0000011;
     Memory[1] = 8'b0_010_0000;
     Memory[2] = 8'b0000_0000;
     Memory[3] = 8'b00000000;

    // lw x2, 8(x0)
     Memory[4] = 8'b0_0000011;
     Memory[5] = 8'b0_010_0001;
     Memory[6] = 8'b1000_0000;
     Memory[7] = 8'b00000000;

    // add x3, x2, x1
     Memory[8] = 8'b1_0110011;
     Memory[9] = 8'b1_000_0001;
     Memory[10] = 8'b0010_0000;
     Memory[11] = 8'b0000000_0;

    // sub x4, x3, x1
     Memory[12] = 8'b0_0110011;
     Memory[13] = 8'b1_000_0010;
     Memory[14] = 8'b0001_0001;
     Memory[15] = 8'b0100000_0;

    // sw x3, 24(x0)
     Memory[16] = 8'b0_0100011;
     Memory[17] = 8'b0_010_1100;
     Memory[18] = 8'b0011_0000;
     Memory[19] = 8'b0000000_0;

    // addi x5, x1, 3
     Memory[20] = 8'b1_0010011;
     Memory[21] = 8'b1_000_0010;
     Memory[22] = 8'b0011_0000;
     Memory[23] = 8'b00000000;
    
    // subi x6, x2, 3
     Memory[24] = 8'b0_0010011;
     Memory[25] = 8'b0_000_0011;
     Memory[26] = 8'b0011_0001;
     Memory[27] = 8'b00000000;
    
    // addi x7, x1, -1
     Memory[28] = 8'b1_0010011;
     Memory[29] = 8'b1_000_0011;
     Memory[30] = 8'b1111_0000;
     Memory[31] = 8'b11111111;
    
    // lw x8, 24(x0)
     Memory[32] = 8'b0_0000011;
     Memory[33] = 8'b0_010_0100;
     Memory[34] = 8'b1000_0000;
     Memory[35] = 8'b00000001;

   end
   
   //  assincrono
   assign read_data = {Memory[endereco + 3], Memory[endereco + 2], 
                       Memory[endereco + 1], Memory[endereco + 0]};  
endmodule