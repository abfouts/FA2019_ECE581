// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu

//Problem 8

module Problem8
	(input a,b,c,
	output logic f);
	
	always_comb
		case({c,b,a}) //if a,b,c is less than 3 then  f=1
		 3'b000: f=1;
		 3'b001: f=1;
		 3'b010: f=1;
		 default f=0;
		endcase
	
endmodule
