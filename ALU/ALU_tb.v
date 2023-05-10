`timescale 1ns/1ns

module testbench ();
    reg signed [63:0] A;
    reg signed [63:0] B;
    reg SUM_SUB;

    wire [63:0] result;
    wire equal, not_equal, lesser_than, greater_or_equal, unsigned_lesser, unsigned_greater_equal;
    
    ALU UUT (.A(A), .B(B), .SUM_SUB(SUM_SUB), .result(result), .equal(equal), .not_equal(not_equal),
     .lesser_than(lesser_than), .greater_or_equal(greater_or_equal), .unsigned_lesser(unsigned_lesser),
     .unsigned_greater_equal(unsigned_greater_equal));

    integer i, errors = 0;
    task Check ;
        input [63:0] expect;
        if (result !== expect) begin
                $display ("Error : A: %b B: %b expect: %b got: %b", A, B, expect, result);
                errors = errors + 1;
        end
    endtask

    initial begin
        //testes básicos de adicao e subtracao com valores signed 1
        //10 + 10 = 20 ------1
        A = 64'd10;
        B = 64'd10;
        SUM_SUB = 0;
        #10
        Check(64'd20);
        
        //30 + (-10) = 20 ------2
        A = 64'd30;
        B = -64'd10;
        SUM_SUB = 0;
        #10
        Check(64'd20);
        
        //30 - 40 = -10 ------3
        A = 64'd30;
        B = 64'd40;
        SUM_SUB = 1;
        #10
        Check(-64'd10);

        //40 - (-30) = 70 ------4
        A = 64'd40;
        B = -64'd30;
        SUM_SUB = 1;
        #10
        Check(64'd70);

        //testes com flags

        //A equal B; check ------5
        A = 64'd7;
        B = 64'd7;
        SUM_SUB = 1;
        #10
        if (equal)
            $display ("Equal test 1 passed! :)");
        else
            $display ("Equal test 1 failed! :(");

        //A equal B; check ------6
        A = -64'd7;
        B = -64'd7;
        SUM_SUB = 1;
        #10
        if (equal)
            $display ("Equal test 2 passed! :)");
        else
            $display ("Equal test 2 failed! :(");

        //A not equal B; check ------7
        A = 64'd7;
        B = 64'd8;
        SUM_SUB = 1;
        #10
        if (not_equal)
            $display ("Not equal test 1 passed! :)");
        else
            $display ("Not equal test 1 failed! :(");

        //A not equal B; check ------8
        A = 64'd7;
        B = -64'd8;
        SUM_SUB = 1;
        #10
        if (not_equal)
            $display ("Not equal test 2 passed! :)");
        else
            $display ("Not equal test 2 failed! :(");

        //A < B; //check ------9
        A = 64'd5;
        B = 64'd10;
        SUM_SUB = 1;
        #10
        if (lesser_than)
            $display ("Lesser than test 1 passed! :)");
        else
            $display ("Lesser than  test 1 failed! :(");

        //A < B; //check ------10
        A = -64'd15;
        B = -64'd10;
        SUM_SUB = 1;
        #10
        if (lesser_than)
            $display ("Lesser than test 2 passed! :)");
        else
            $display ("Lesser than  test 2 failed! :(");

        //A >= B; check ------11
        A = 64'd15;
        B = 64'd10;
        SUM_SUB = 1;
        #10
        if (greater_or_equal)
            $display ("Greater or equal test 1 passed! :)");
        else
            $display ("Greater or equal test 1 failed! :(");

        //A >= B; check ------12
        
        A = -64'd5;
        B = -64'd10;
        SUM_SUB = 1;
        #10
        if (greater_or_equal)
            $display ("Greater or equal test 2 passed! :)");
        else
            $display ("Greater or equal test 2 failed! :(");
 
        //A >= B; check ------13
        A = -64'd10;
        B = -64'd10;
        SUM_SUB = 1;
        #10
        if (greater_or_equal)
            $display ("Greater or equal test 3 passed! :)");
        else
            $display ("Greater or equal test 3 failed! :(");

        //uA < uB; ------14
        A = 64'd80;
        B = -64'd8;
        SUM_SUB = 1;
        #10
        if (unsigned_lesser)
            $display ("Unsigned less than test 1 passed! :)");
        else
            $display ("Unsigned less than test 1 failed! :(");

        //uA < uB; ------15
        A = 64'd7;
        B = 64'd8;
        SUM_SUB = 1;
        #10
        if (unsigned_lesser)
            $display ("Unsigned less than test 2 passed! :)");
        else
            $display ("Unsigned less than test 2 failed! :(");

        //uA >= uB; ------16
        A = -64'd9;
        B = 64'd80;
        SUM_SUB = 1;
        #10
        if (unsigned_greater_equal)
            $display ("Unsigned Greater than or equal to test 1 passed! :)");
        else
            $display ("Unsigned Greater than or equal to test 1 failed! :(");

        //uA >= uB; ------17
        A = 64'd9;
        B = 64'd8;
        SUM_SUB = 1;
        #10
        if (unsigned_greater_equal)
            $display ("Unsigned Greater than or equal to test 2 passed! :)");
        else
            $display ("Unsigned Greater than or equal to test 2 failed! :(");
        
        $display("Test finished. Erros: %d", errors);
        $finish;
    end
endmodule