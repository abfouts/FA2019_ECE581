////////////////////////////////////////////
// Design Unit:
// File name: Problem4.sv
// Description: Select an input bit to be saved in a register and output
// Limitations:
// System:
// Author: Zoe DeFreitas and Abram Fouts
// Revision: 1.0
////////////////////////////////////////////


module Problem4
	(input logic [7:0] in,
	input logic [2:0] op,
	input logic clk,
	output logic out);

	logic temp;

	always_comb begin
		case (op)		//Mux
			3'b000: temp = in[0];
			3'b001: temp = in[1];
			3'b010: temp = in[2];
			3'b011: temp = in[3];
			3'b100: temp = in[4];
			3'b101: temp = in[5];
			3'b110: temp = in[6];
			3'b111: temp = in[7];
		endcase	
	end


	always_ff @(posedge clk) begin		
		out <= temp;
	end


endmodule
