module instructionSetter_tb ();
    reg clk;
    wire [31:0] instruction;
    wire signed [63:0] immediate;

    instructionSetter UUT(.clk(clk), .instruction(instruction), .immediate(immediate));

    /* testado pelo GTKWave e funcionou */
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        $monitor ("[%t] instruction = %b immediate = %d", 
                  $time, instruction, immediate);
        
        #100
        $finish;
    end
endmodule