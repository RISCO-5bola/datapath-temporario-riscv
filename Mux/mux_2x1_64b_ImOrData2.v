module mux_2x1_64b_ImOrData2 (
    input SelectImOrData2,
    input [63:0] Immediate, DataOut2, //Escolheremos entre immediate e Data1 para fornecer ao somador.
    output reg [63:0] X
);

always @ (*) 
    begin
        if (SelectImOrData2 == 1'b0)
            X <= Immediate;
        else if (SelectImOrData2 == 1'b1)
            X <= DataOut2;
    end
endmodule