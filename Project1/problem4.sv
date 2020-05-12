// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 1; Problem 4

module CLA_16bit(A, B, cin, cout, out);

input [15:0] A;
input [15:0] B;
input cin;
output cout;
output [15:0] out;

//interconnects
wire c4, c8, c12, c16;

assign cout = c16;

// Using 4 4bit CLA to create a 16 bit CLA
CLA_4bit uut1(
.in1(A[3:0]), 
.in2(B[3:0]), 
.cin(cin), 
.cout(c4), 
.sum(out[3:0])
);

CLA_4bit uut2(
.in1(A[7:4]), 
.in2(B[7:4]), 
.cin(c4), 
.cout(c8), 
.sum(out[7:4])
);

CLA_4bit uut3(
.in1(A[11:8]), 
.in2(B[11:8]), 
.cin(c8), 
.cout(c12), 
.sum(out[11:8])
);

CLA_4bit uut4(
.in1(A[15:12]), 
.in2(B[15:12]), 
.cin(c12), 
.cout(c16), 
.sum(out[15:12])
);

endmodule

// 4 bit CLA
module CLA_4bit(in1, in2, cin, cout, sum);
input [3:0] in1;
input [3:0] in2;
input cin;
output cout;
output [3:0] sum;

wire [3:0] p,g, carry;
wire c4;

// C4 = g3 + p3g2 + p3p2g1 + p3p2p1g0 + p3p2p1p0c0

assign p = in1 ^ in2; //XOR both inputs for propagate value
assign g = in1 & in2; //AND both inputs for generate value, for given formula in class

assign carry[0] = cin;
assign carry[1] = g[0] + (p[0] & carry[0]);
assign carry[2] = g[1] + (g[0] & p[1]) + (p[1] & p[0] & carry[0]);
assign carry[3] = g[2] + (g[1] & p[2]) + (g[0] & p[1] & p[2]) + (p[2] & p[1] & p[0] & carry[0]);				

assign c4 = g[3] + (g[2] & p[3]) + (g[1] & p[2] & p[3]) + (g[0] & p[1] & p[2] & p[3]) + (p[3] & p[2] & p[1] & p[0] & carry[0]);	//From lecture 10/22/19

assign sum = p ^ carry;	//IN1 XOR IN2 XOR CARRY
assign cout = c4;  	//C4
endmodule
