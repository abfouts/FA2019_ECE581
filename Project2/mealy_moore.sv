// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 2; Problem 1

module mealy_elevator(clk, r1, r2, r3, d2, d1, n, u1, u2);
input clk, r1, r2, r3;			// input request for floor change and clock for the FF
output logic d2, d1, n, u1, u2; 	//di = down i floors, n = no change, ui = up i floors

enum logic [2:0] {	FLOOR1 = 3'b001,
			FLOOR2 = 3'b010,
			FLOOR3 = 3'b100} state = FLOOR1, nextstate = FLOOR1; //Sets initial floor to floor 1

always_comb
begin
unique case(state)					//unique case
	FLOOR1: begin
		if(r2) begin 
			nextstate <= FLOOR2;		//Floor 2 has been requested
			{d2, d1, u2, n} <= 4'b0000;	//outputs
			u1 <= 1'b1;
		end 
		else if(r3) begin
			nextstate <= FLOOR3;		//Floor 3 has been requested
			{d2, d1, u1, n} <= 4'b0000;	//outputs
			u2 <= 1'b1;
		end 
		else begin
			nextstate <= FLOOR1;		//Floor 1 has been requested but on floor 1
			n = 1'b1;
			{d2, u1, u2, d1} <= 4'b0000;	//outputs
		end
	end

	FLOOR2: begin
		if(r1) begin
			nextstate <= FLOOR1;		//Floor 1 has been requested
			{d2, u1, u2, n} <= 4'b0000;	//outputs
			d1 <= 1'b1;
		end 
		else if(r3) begin
			nextstate <= FLOOR3;		//Floor 3 has been requested
			{d2, d1, u2, n} <= 4'b0000;	//outputs
			u1 <= 1'b1;
		end 
		else begin
			nextstate <= FLOOR2;		//Floor 2 has been requested but on floor 2
			n <= 1'b1;
			{d2, u1, u2, d1} <= 4'b0000;	//outputs
		end
	end
	
	FLOOR3: begin
		if(r2) begin
			nextstate <= FLOOR2;		//Floor 2 has been requested
			{d2, u1, u2, n} <= 4'b0000;	//outputs
			d1 <= 1'b1;
		end else if(r1) begin
			nextstate <= FLOOR1;		//Floor 1 has been requested
			{d1, u1, u2, n} <= 4'b0000;	//outputs
			d2 <= 1'b1;
		end else begin
			nextstate <= FLOOR3;		//Floor 3 has been requested but on floor 3
			n <= 1'b1;
			{d2, u1, u2, d1} <= 4'b0000;	//outputs
		end
	end
endcase
end

always_ff@(posedge clk)
begin
//$display("time=",$time,, "INPUT = r1 = %b, r2 = %b, r3 = %b\n", r1, r2, r3);
//$display("time=",$time,, "state = %b, nextstate = %b\n",state, nextstate);
//$display("time=",$time,, "OUTPUT = d2 = %b, d1 = %b, n = %b, u1 = %b, u2 = %b \n", d2, d1, n, u1, u2);
state <= nextstate;
end

endmodule


module moore_elevator(clk, r1, r2, r3, d2, d1, n, u1, u2);
input clk, r1, r2, r3;			// input request for floor change and clock for the FF
output logic d2, d1, n, u1, u2; 	//di = down i floors, n = no change, ui = up i floors

enum logic [8:0] {	S11 = 9'b000000001,
			S21 = 9'b000000010,
			S31 = 9'b000000100,
			S12 = 9'b000001000,
			S22 = 9'b000010000,
			S32 = 9'b000100000,
			S13 = 9'b001000000,
			S23 = 9'b010000000,
			S33 = 9'b100000000} state = S11, nextstate = S11; //Sets initial floor to S11


always_comb begin
unique case (state)

S11: begin
{d2, d1, n, u1, u2} <= 5'b01111;
if(r1) begin
	nextstate <= S13;
end
if(r2) begin
	nextstate <= S23;
end
if(r3) begin
	nextstate <= S33;
end
end

S21: begin
{d2, d1, n, u1, u2} <= 5'b10111;
if(r1) begin
	nextstate <= S12;
end
if(r2) begin
	nextstate <= S22;
end
if(r3) begin
	nextstate <= S32;
end
end

S31: begin
{d2, d1, n, u1, u2} <= 5'b11011;
if(r1) begin
	nextstate <= S11;
end
if(r2) begin
	nextstate <= S21;
end
if(r3) begin
	nextstate <= S31;
end
end

S12: begin
{d2, d1, n, u1, u2} <= 5'b10111;
if(r1) begin
	nextstate <= S13;
end
if(r2) begin
	nextstate <= S23;
end
if(r3) begin
	nextstate <= S33;
end
end

S22: begin
{d2, d1, n, u1, u2} <= 5'b11011;
if(r1) begin
	nextstate <= S12;
end
if(r2) begin
	nextstate <= S22;
end
if(r3) begin
	nextstate <= S32;
end
end

S32: begin
{d2, d1, n, u1, u2} <= 5'b11101;
if(r1) begin
	nextstate <= S11;
end
if(r2) begin
	nextstate <= S21;
end
if(r3) begin
	nextstate <= S31;
end
end

S13: begin
{d2, d1, n, u1, u2} <= 5'b11011;
if(r1) begin
	nextstate <= S13;
end
if(r2) begin
	nextstate <= S23;
end
if(r3) begin
	nextstate <= S33;
end
end

S23: begin
{d2, d1, n, u1, u2} <= 5'b11101;
if(r1) begin
	nextstate <= S12;
end
if(r2) begin
	nextstate <= S22;
end
if(r3) begin
	nextstate <= S32;
end
end

S33: begin
{d2, d1, n, u1, u2} <= 5'b11110;
if(r1) begin
	nextstate <= S11;
end
if(r2) begin
	nextstate <= S21;
end
if(r3) begin
	nextstate <= S31;
end
end


endcase
end

always_ff@(posedge clk) begin
state <= nextstate;
end

endmodule
