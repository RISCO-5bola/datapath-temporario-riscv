`timescale 1ns/1ns

module index_tb ();
    /*
        Declaracao dos inputs.
        Como nao ha outputs no circuito, os sinais
        serao analisados no GTKWave.
    */
    reg writeEnable_DataMemory, writeEnable_Registers,
        muxSelect_SumVsReadData, muxSelect_ImmVsDataout2, SumOrSub, clk, reset;

    index UUT (.writeEnable_DataMemory(writeEnable_DataMemory), .writeEnable_Registers(writeEnable_Registers),
               .muxSelect_SumVsReadData(muxSelect_SumVsReadData), .muxSelect_ImmVsDataout2(muxSelect_ImmVsDataout2),
               .SumOrSub(SumOrSub),.clk(clk), .reset(reset)); //instaciado devidamente para soma, sub, load e store.
    
    /*
        Seta o clock, comecando de 0 e posteriormente
        tem bordas a cada 10ns
    */
    initial begin
        clk = 1'b0;
        reset = 1'b0;
        writeEnable_Registers = 1'b0;
        writeEnable_DataMemory = 1'b0;
        muxSelect_SumVsReadData = 1'b0; //Quando 0, manda readDatamemory e quando 1, manda Soma.
        muxSelect_ImmVsDataout2 = 1'b0; //0 - immediate, 1 - Dataout2 (operacao S vs aritmetica)
        SumOrSub = 1'b0; //0 quando soma, 1 quando subtrai
        forever #5 clk = ~clk;
    end

    /*
        Com o clock setado, sao feitas as operacoes    
    */
    /*
            Condicoes iniciais:

            Registers
                reg0: 0
                reg1: 
                reg2: 
                reg3:
                reg4:
                reg5:
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3:
                data4:
                data5
                ...
        */
    initial begin
        #5
        reset = 1'b1;
        #10
        $monitor ("[%t] clk = %d, writeEnable_DataMemory = %d, writeEnable_Registers = %d, muxSelect_SumVsReadData = %d", 
                  $time, clk, writeEnable_DataMemory, writeEnable_Registers, muxSelect_SumVsReadData);

        /*
            lw x1, 0(x0)
            carrega o valor de 0+x0 no reg x1
        */

        /*
            Condicoes iniciais:

            Registers
                reg0: 0
                reg1: 8
                reg2: 
                reg3:
                reg4:
                reg5:
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3:
                data4:
                data5
                ...
        */
        
        writeEnable_Registers = 1'b1;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b0;
        #10

        /*
            lw x2, 8(x0)
            carrega o valor de 8+x0 no reg x2
        */

        /*
            Condicoes iniciais:

            Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3:
                reg4:
                reg5:
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3:
                data4:
                data5
                ...
        */
        
        writeEnable_Registers = 1'b1;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b0;
        #10
        
        /*
        add x3, x2, x1
        soma o valor do registrador 2 e do registrador 1 e salva no registrador 3

            Condicoes esperadas:

            Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3: 14
                reg4:
                reg5:
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3:
                data4:
                data5
                ...

        */

        writeEnable_Registers = 1'b1;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b1;//O zero escolhe o ReadData, entao vamos usar 1
        muxSelect_ImmVsDataout2 = 1'b1;//E Esse valor será 1, pois estamos escolhendo DataOut2
        SumOrSub = 1'b0; //0, pois é soma
        #10

                /*
        sub x4, x3, x1 //
        subtrai o valor do registrador 3 e do registrador 1 e salva no registrador 4!

            Condicoes esperadas:

            Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3: 14
                reg4: 6
                reg5:
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3:
                data4:
                data5
                ...

        */

        writeEnable_Registers = 1'b1;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b1;//O zero escolhe o ReadData, entao vamos usar 1
        muxSelect_ImmVsDataout2 = 1'b1;//E Esse valor será 1, pois estamos escolhendo DataOut2
        SumOrSub = 1'b1; //1, pois eh subtracao
        #10

        /*
            sw x3, 24(x0)
            guarda o valor de x3 na posição 3 (bit 24) da DM
        */

        /*
            Condicoes esperadas:

                Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3: 14
                reg4: 6
                reg5:
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3: 14
                data4:
                data5
                ...
        */
        writeEnable_Registers = 1'b0;
        writeEnable_DataMemory = 1'b1;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b0;
        #10

        /*
            addi x5, x1, 3
            soma 3 a x1 e carrega em x5
        */

        /*
            Condicoes esperadas:

                Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3: 14
                reg4: 6
                reg5: 11
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3: 14
                data4: 6
                data5
                ...
        */
        
        writeEnable_Registers = 1'b1;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b1;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b0;
        #10

        /*
            subi x6, x2, 3
            subtrai 3 de x2 e carrega em x6
        */

        /*
            Condicoes esperadas:

                Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3: 14
                reg4: 6
                reg5: 11
                reg6: 3
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3: 14
                data4: 6
                data5
                ...
        */
        
        writeEnable_Registers = 1'b1;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b1;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b1;
        #10

        /*
            addi x7, x1, -1
            soma -1 a x1 e carrega em x7
        */

        /*
            Condicoes esperadas:

                Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3: 14
                reg4: 6
                reg5: 11
                reg6: 3
                reg7: 7
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3: 14
                data4: 6
                data5
                ...
        */
        
        writeEnable_Registers = 1'b1;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b1;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b0;
        #10
        

        /* AGORA, SAO FEITOS LOADS PARA PODER
           VERIFICAR A VALIDADE DOS STORAGES */
        /*
            lw x8, 24(x0)
            carrega o valor de 24+x0 no reg x8
        */

        /*
            Condicoes esperadas:

                Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3: 14
                reg4: 6
                reg5: 11
                reg6: 3
                reg7: 7
                reg8: 14
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3: 14
                data4: 6
                data5
                ...
        */
        
        writeEnable_Registers = 1'b1;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b0;
        
        #10

        /* AGORA, DO TIPO B */

         /*
            Condicoes iniciais para o tipo B:

                Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3: 14
                reg4: 6
                reg5: 11
                reg6: 3
                reg7: 7
                reg8: 14
                ...

            Data memory:
                data0: 8
                data1: 6 
                data2: 16
                data3: 14
                data4: 6
                data5
                ...
        */
        /*
            beq x2, x4, 4
            deve pular duas instrucoes no pc
        */
        writeEnable_Registers = 1'b0;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b1; 
        SumOrSub = 1'b1;

        #10
        /*
            bne x0, x1, 4
            deve pular duas instrucoes no pc
        */
        writeEnable_Registers = 1'b0;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b1; 
        SumOrSub = 1'b1;
        
        #10
        /*
            blt x0, x1, 4
            deve pular duas instrucoes no pc
        */
        writeEnable_Registers = 1'b0;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b1; 
        SumOrSub = 1'b1;
        
        #10
        /*
            bge x1, x0, 4
            deve pular duas instrucoes no pc
        */
        writeEnable_Registers = 1'b0;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b1; 
        SumOrSub = 1'b0;
        
        #10
        /*
            bltu x0, x1, 4
            deve pular duas instrucoes no pc
        */
        writeEnable_Registers = 1'b0;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b1; 
        SumOrSub = 1'b0;
        
        #10
        /*
            bgeu x1, x0, 4
            deve pular duas instrucoes no pc
        */
        writeEnable_Registers = 1'b0;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b1; 
        SumOrSub = 1'b0;
        
        
        #20

        

        $finish;
    end
endmodule
