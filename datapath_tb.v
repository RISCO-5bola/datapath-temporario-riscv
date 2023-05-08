`timescale 1ns/1ns

module datapath_tb ();
    /*
        Declaracao dos inputs.
        Como nao ha outputs no circuito, os sinais
        serao analisados no GTKWave.
    */
    reg [4:0] readRegister1, readRegister2, writeRegister;
    reg [63:0] immediate;
    reg writeEnable_DataMemory, writeEnable_Registers,
        muxSelect_SumVsReadData, muxSelect_ImmVsDataout2, SumOrSub, clk;

    index UUT (.readRegister1(readRegister1), .readRegister2(readRegister2),
               .writeRegister(writeRegister), .writeEnable_DataMemory(writeEnable_DataMemory),
               .writeEnable_Registers(writeEnable_Registers), .immediate(immediate),
               .muxSelect_SumVsReadData(muxSelect_SumVsReadData), .muxSelect_ImmVsDataout2(muxSelect_ImmVsDataout2),
                .SumOrSub(SumOrSub),.clk(clk)); //instaciado devidamente para soma, sub, load e store.
    
    /*
        Seta o clock, comecando de 0 e posteriormente
        tem bordas a cada 10ns
    */
    initial begin
        clk = 1'b0;
        writeRegister = 5'd0;
        writeEnable_Registers = 1'b0;
        immediate = 64'd0;
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
        $monitor ("[%t] clk = %d, readRegister1 = %d, readRegister2 = %d, writeRegister = %d, immediate = %d, writeEnable_DataMemory = %d, writeEnable_Registers = %d, muxSelect_SumVsReadData = %d", 
                  $time, clk, readRegister1, readRegister2, writeRegister, immediate, writeEnable_DataMemory, writeEnable_Registers, muxSelect_SumVsReadData);
        #10

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
        
        readRegister1 = 5'd0;
        readRegister2 = 5'dx;
        writeRegister = 5'd1;
        writeEnable_Registers = 1'b1;
        immediate = 64'd0;
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
        
        readRegister1 = 5'd0;
        readRegister2 = 5'dx;
        writeRegister = 5'd2;
        writeEnable_Registers = 1'b1;
        immediate = 64'd8;
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

        readRegister1 = 5'd1;
        readRegister2 = 5'd2;
        writeRegister = 5'd3;
        writeEnable_Registers = 1'b1;
        immediate = 64'd0;
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

        readRegister1 = 5'd3;
        readRegister2 = 5'd1;
        writeRegister = 5'd4;
        writeEnable_Registers = 1'b1;
        immediate = 64'd0;
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
        readRegister1 = 5'd0;
        readRegister2 = 5'd3;
        writeRegister = 5'dx;
        writeEnable_Registers = 1'b0;
        immediate = 64'd24;
        writeEnable_DataMemory = 1'b1;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b0;
        #10

        /*
            sw x4, 32(x0)
            guarda o valor de x3 na posição 4 (bit 32) da DM
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
                data4: 6
                data5
                ...
        */
        readRegister1 = 5'd0;
        readRegister2 = 5'd4;
        writeRegister = 5'dx;
        writeEnable_Registers = 1'b0;
        immediate = 64'd32;
        writeEnable_DataMemory = 1'b1;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b0;
        #10

        /* AGORA, SAO FEITOS LOADS PARA PODER
           VERIFICAR A VALIDADE DOS STORAGES */
        /*
            lw x5, 24(x0)
            carrega o valor de 24+x0 no reg x5
        */

        /*
            Condicoes esperadas:

            Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3: 14
                reg4: 6
                reg5: 14
                reg6:
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
        
        readRegister1 = 5'd0;
        readRegister2 = 5'dx;
        writeRegister = 5'd5;
        writeEnable_Registers = 1'b1;
        immediate = 64'd24;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b0;
        #10

        /*
            lw x6, 32(x0)
            carrega o valor de 32+x0 no reg x5
        */

        /*
            Condicoes esperadas:

            Registers
                reg0: 0
                reg1: 8
                reg2: 6
                reg3: 14
                reg4: 6
                reg5: 14
                reg6: 6
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
        
        readRegister1 = 5'd0;
        readRegister2 = 5'dx;
        writeRegister = 5'd6;
        writeEnable_Registers = 1'b1;
        immediate = 64'd32;
        writeEnable_DataMemory = 1'b0;

        muxSelect_SumVsReadData = 1'b0;
        muxSelect_ImmVsDataout2 = 1'b0; 
        SumOrSub = 1'b0;
        #10

        $finish;
    end
endmodule
