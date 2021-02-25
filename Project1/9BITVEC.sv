// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 1; Problem 2
// 9 Bit Boolean Vector
// PSU ID first digit = 9

module detector1(M, outBit);

input [8:0] M;
output logic outBit;

always_comb
begin

if(M == 9'b111111111) 
	outBit = 1;
else
	outBit = 0;
end
endmodule



module detector2(M, outBit);

input [8:0] M;
output logic outBit;

assign outBit = (M == 9'b111111111) ? 1'b1 : 1'b0;

endmodule


