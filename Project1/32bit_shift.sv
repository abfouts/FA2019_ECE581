// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu

//Problem 7

module problem7_1
	(input bit [31:0] x,
	output bit [31:0] y);
	
	always_comb
		if (x[31]) begin
			y = x>>3;
			y[31] = 1;
			y[30] = 1;
			y[29] = 1;
		end else begin
			y = x>>3;
			y[31] = 0;
			y[30] = 0;
			y[29] = 0;
		end
	
endmodule: problem7_1

module problem7_2(in, out);
input [31:0] in;
output [31:0] out;

assign out = in << 3;

endmodule

