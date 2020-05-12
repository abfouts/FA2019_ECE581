////////////////////////////////////////////
// Design Unit:Problem42
// File name: Problem4-2.sv
// Description: Program to save each input bit separately and then combine the results into the output string 
// Limitations: I did not understand the wording of the instructions for 4.2 and was unable to get any clarification
//	when I asked via email.
// System:
// Author: Zoe DeFreitas and Abram Fouts
// Revision: 1.0
////////////////////////////////////////////


module Problem42
	(input logic [7:0] in,
	input logic [2:0] op,
	input logic clk,
	output logic [7:0] out);

	logic t0,t1,t2,t3,t4,t5,t6,t7;


	always_comb begin
	
		case (op)		//Mux
			3'b000: t0 = in[0];
			3'b001: t1 = in[1];
			3'b010: t2 = in[2];
			3'b011: t3 = in[3];
			3'b100: t4 = in[4];
			3'b101: t5 = in[5];
			3'b110: t6 = in[6];
			3'b111: t7 = in[7];
		endcase					

	end


	always_ff @(posedge clk) begin		
		
		out[0] <= t0;
		out[1] <= t1;
		out[2] <= t2;
		out[3] <= t3;
		out[4] <= t4;
		out[5] <= t5;
		out[6] <= t6;
		out[7] <= t7;
	end


endmodule
