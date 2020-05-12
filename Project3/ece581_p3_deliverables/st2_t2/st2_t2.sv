// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 3; Stage 2 : Task 2

module st2_t2(A, B, C, D, clk, Y);
input A, B, C, D, clk;
output Y;

//reg D1, D2, D3, Q1, Q2, Q3, NOR4_OUT;
reg Q1, Q2, Q3;
wire D1, D2, D3, NOR4_OUT;
wire NOR3_OUT, AND1_OUT, OR1_OUT, OR2_OUT, NAND1_OUT;
//wire NOR4_OUT, NOR3_OUT, AND1_OUT, OR1_OUT, OR2_OUT, NAND1_OUT;
wire NOR1_OUT, NOR2_OUT;

assign Y = ~NOR4_OUT;
//assign D1 = NOR2_OUT;
//assign D2 = NOR1_OUT;
//assign D3 = NOR4_OUT;

//awlays_ff @(posedge clk) begin
always @(posedge clk) begin
	Q1 <= D1;
	Q2 <= D2;
	Q3 <= NOR4_OUT;
end

nor nor1(D2, B, NOR3_OUT);
nor nor2(D1, ~D, NOR4_OUT);
nor nor3(NOR3_OUT, A, Q2);
nor nor4(NOR4_OUT, Q1, NAND1_OUT);
and and1(AND1_OUT, ~D, Q3);
or or1(OR1_OUT, NOR3_OUT, AND1_OUT);
or or2(OR2_OUT, C, AND1_OUT);
nand nand1(NAND1_OUT, OR1_OUT, OR2_OUT);

/*
nor nor1(NOR1_OUT, B, NOR3_OUT);
nor nor2(NOR2_OUT, ~D, NOR4_OUT);
nor nor3(NOR3_OUT, A, Q2);
nor nor4(NOR4_OUT, Q1, NAND1_OUT);
and and1(AND1_OUT, ~D, Q3);
or or1(OR1_OUT, NOR3_OUT, AND1_OUT);
or or2(OR2_OUT, C, AND1_OUT);
nand nand1(NAND1_OUT, OR1_OUT, OR2_OUT);
*/

endmodule
