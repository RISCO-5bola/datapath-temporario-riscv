module immediateGenerationUnit_tb ();
    reg [31:0] instruction;
    wire signed [63:0] immediate;

    immediateGenerationUnit UUT(.instruction(instruction), .immediate(immediate));

    /* funcionando */
    initial begin
        /* addi -> imm = 2*/
        instruction = 64'b000000000010_00000_000_00000_0010011;        
        #10
        $display("Imm = %d", immediate);

        /* addi -> imm = -2*/
        instruction = 64'b111111111110_00000_000_00000_0010011;
        #10
        $display("Imm = %d", immediate);

        /* lw -> imm = 2*/
        instruction = 64'b000000000010_00000_010_00000_0000011;
        #10
        $display("Imm = %d", immediate);
            
        /* lw -> imm = -2*/
        instruction = 64'b111111111110_00000_010_00000_0000011;
        #10
        $display("Imm = %d", immediate);
            
        /* sw -> imm = 4*/
        instruction = 64'b0000000_00000_00000_010_00100_0100011;
        #10
        $display("Imm = %d", immediate);
            
        /* sw -> imm = -2*/
        instruction = 64'b1111111_00000_00000_010_11110_0100011;
        #10
        $display("Imm = %d", immediate);
            
    end
endmodule