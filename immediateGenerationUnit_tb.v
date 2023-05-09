module immediateGenerationUnit_tb ();
    reg [31:0] instruction;
    wire signed [63:0] immediate;

    immediateGenerationUnit UUT(.instruction(instruction), .immediate(immediate));

    /* funcionando */
    initial begin
        #10
        /* addi -> imm = 2*/
        instruction = 32'b000000000010_00000_000_00000_0010011;        
        #10
        $display("Imm (addi) = %d", immediate);

        /* addi -> imm = -2*/
        instruction = 32'b111111111110_00000_000_00000_0010011;
        #10
        $display("Imm (addi) = %d", immediate);

        /* lw -> imm = 4*/
        instruction = 32'b000000000100_00000_010_00000_0000011;
        #10
        $display("Imm (lw) = %d", immediate);
            
        /* lw -> imm = -4*/
        instruction = 32'b111111111100_00000_010_00000_0000011;
        #10
        $display("Imm (lw) = %d", immediate);
            
        /* sw -> imm = 8*/
        instruction = 32'b0000000_00000_00000_010_01000_0100011;
        #10
        $display("Imm (sw) = %d", immediate);
            
        /* sw -> imm = -8*/
        instruction = 32'b1111111_00000_00000_010_11000_0100011;
        #10
        $display("Imm (sw) = %d", immediate);

        /* b -> imm = 16*/
        instruction = 32'b0000000_00000_00000_000_1000_0_1100011;
        #10
        $display("Imm (b) = %d", immediate);
            
        /* b -> imm = -16*/
        instruction = 32'b1111111_00000_00000_000_1000_1_1100011;
        #10
        $display("Imm (b) = %d", immediate);

        $finish;
            
    end
endmodule