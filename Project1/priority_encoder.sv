// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 1; Problem 3
// N bit encoder

module encoder(enable, inVal, encode);
parameter n = 3;

input enable;
input [(2**n)-1:0] inVal;
output logic [n-1:0] encode;

always_comb
begin
encode = 0;
if (enable) begin

for(int i = 2**n - 1; i > -1; i = i - 1) begin	// loops through 2^n cases
if (inVal[i]) begin				// Checks priority
	encode = i;				// Encodes
	$display("i = %d", i);
	i = -1;					// ends the loop if bit found
	end
end
end


end
endmodule
