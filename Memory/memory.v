module data_memory(input clk,      
                   input mem_read,
                   input mem_write,
                   input [7:0] endereco, //saida da ula
                   input [63:0] write_data, //data out b
                   output [63:0] read_data // write data
                   );
   reg [7:0] Memory [255:0];

   /*
    Memoria 64x32
    Neste caso, foi instanciado em bytes, por isso sao 256 posicoes
   */
   initial begin
     /* condicoes iniciais do datapath */
     Memory[0] = 8'd0;
     Memory[1] = 8'd0;
     Memory[2] = 8'd0;
     Memory[3] = 8'd0;
     Memory[4] = 8'd0;
     Memory[5] = 8'd0;
     Memory[6] = 8'd0;
     Memory[7] = 8'd8;
     
     Memory[8] = 8'd0;
     Memory[9] = 8'd0;
     Memory[10] = 8'd0;
     Memory[11] = 8'd0;
     Memory[12] = 8'd0;
     Memory[13] = 8'd0;
     Memory[14] = 8'd0;
     Memory[15] = 8'd6;
     
     Memory[16] = 8'd0;
     Memory[17] = 8'd0;
     Memory[18] = 8'd0;
     Memory[19] = 8'd0;
     Memory[20] = 8'd0;
     Memory[21] = 8'd0;
     Memory[22] = 8'd0;
     Memory[23] = 8'd16;
   end
   
   assign read_data = {Memory[endereco], Memory[endereco + 1], 
                       Memory[endereco + 2], Memory[endereco + 3],
                       Memory[endereco + 4], Memory[endereco + 5], 
                       Memory[endereco + 6], Memory[endereco + 7]}; 
   
   // sincrono
   always @(negedge clk) begin
        
        if (mem_write) begin
          Memory[endereco + 7] <= write_data[7:0];
          Memory[endereco + 6] <= write_data[15:8];
          Memory[endereco + 5] <= write_data[23:16];
          Memory[endereco + 4] <= write_data[31:24];
          Memory[endereco + 3] <= write_data[39:32];
          Memory[endereco + 2] <= write_data[47:40];
          Memory[endereco + 1] <= write_data[55:48];
          Memory[endereco] <= write_data[63:56];
        end
   end      
                   
           
endmodule
