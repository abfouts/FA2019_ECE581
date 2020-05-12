////////////////////////////////////////////
// Design Unit:
// File name: Problem3.sv
// Description: 
// Limitations:
// System:
// Author: Zoe DeFreitas
// Revision: 1.0
////////////////////////////////////////////



module Problem3
	(input logic [7:0] in,
	input logic [2:0] op,
	input logic clk,
	output logic [7:0] out);

	logic [7:0] temp = 8'd0;

	always_ff @(posedge clk) begin
		temp <= in;
		
		case (op)
			3'b000: begin	//Reset all registers to 0
				temp <= 8'd0;
				out <= temp;
				end
			3'b001: begin		//Arithmetic Shift Right
				temp <= in >>> 1;	
				out <= temp;
				end
			3'b010:	begin		//Arithmetic Shift Left
				temp <= in <<< 1;
				out <= temp;
				end
			3'b011: begin		//Shift Right
				temp <=	in >> 1;	
				temp[0] <= in[7];
				out <= temp;
				end
			3'b100: begin		//Shift Left
				temp <= in << 1;	
				temp[7] <= in[0];
				out <= temp;
				end				
			3'b101: begin 		//Keep current register's data
				temp <= in;
				out <= temp;
				end	
			default begin		//Add 1 to shift register and wrap around when largest value is reached
				if (in == 8'b11111111) begin
					temp <= 8'd0;
					out <= temp;
					end
				else begin
					temp <= in + 1;
					out <= temp;
					end
				end

		endcase
	end
endmodule 