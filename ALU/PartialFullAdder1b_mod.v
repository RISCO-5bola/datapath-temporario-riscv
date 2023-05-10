module PartialFullAdder1b_mod (
    input A, B, CIN,
    output S, P, G
);
wire W1;

    xor U1 (W1, A, B);
    xor U2 (S, W1, CIN);
    or U3 (P, A, B);
    and U4 (G, A, B);

endmodule
