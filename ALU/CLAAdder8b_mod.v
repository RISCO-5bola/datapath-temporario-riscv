`include "./ALU/PartialFullAdder1b_mod.v"

module CLAAdder8b_mod(A, B, CIN, S, COUT);
    input [7:0] A, B;
    input CIN;
    output [7:0] S;
    output COUT;

    wire C1, C2, C3, C4, C5, C6, C7;
    wire P0, P1, P2, P3, P4, P5, P6, P7;
    wire PC1, PC2, PC3, PC4, PC5, PC6, PC7, PC8;
    wire G1, G2, G3, G4, G5, G6, G7, G8;
    
    and P01 (PC1,P0,CIN);
    or C01 (C1, G1, PC1);

    and P02 (PC2,P1, C1);
    or C02 (C2, G2, PC2);

    and P03 (PC3, P2, C2);
    or C03 (C3, G3, PC3);

    and P04 (PC4, P3, C3);
    or C04 (C4, G4, PC4);

    and P05 (PC5, P4, C4);
    or C05 (C5, G5, PC5);

    and P06 (PC6, P5, C5);
    or C06 (C6, G6, PC6);

    and P07 (PC7, P6, C6);
    or C07 (C7, G7, PC7);

    and P08 (PC8, P7, C7);
    or C08 (COUT, G8, PC8);

    PartialFullAdder1b_mod U0 (.A(A[0]), .B(B[0]), .CIN(CIN), .S(S[0]), .P(P0), .G(G1));
    PartialFullAdder1b_mod U1 (.A(A[1]), .B(B[1]), .CIN(C1), .S(S[1]), .P(P1), .G(G2));
    PartialFullAdder1b_mod U2 (.A(A[2]), .B(B[2]), .CIN(C2), .S(S[2]), .P(P2), .G(G3));
    PartialFullAdder1b_mod U3 (.A(A[3]), .B(B[3]), .CIN(C3), .S(S[3]), .P(P3), .G(G4));
    PartialFullAdder1b_mod U4 (.A(A[4]), .B(B[4]), .CIN(C4), .S(S[4]), .P(P4), .G(G5));
    PartialFullAdder1b_mod U5 (.A(A[5]), .B(B[5]), .CIN(C5), .S(S[5]), .P(P5), .G(G6));
    PartialFullAdder1b_mod U6 (.A(A[6]), .B(B[6]), .CIN(C6), .S(S[6]), .P(P6), .G(G7));
    PartialFullAdder1b_mod U7 (.A(A[7]), .B(B[7]), .CIN(C7), .S(S[7]), .P(P7), .G(G8));

endmodule