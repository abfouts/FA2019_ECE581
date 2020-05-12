// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 2; Problem 2
// Last 2 digits: 95 = 1001_0101

/*	      SEQUENCER
	     ___________
---clk ---->|		|---ready--->
---data 8/->|		|
---sent---->|		|---match--->
	    |___________|
*/

module sequencer(clk, data, sent, ready, match);
input clk;			//Clock
input [7:0] data; 		//32 bit data in that will be compared
input sent;			//Send bit to go with data that was sent
output logic ready = 1'b1;	//Ready bit to latch more data
output logic match = 1'b0;	//1 matched, 0 not matched

logic [7:0] latchedData;

int write_file = $fopen("log.txt", "a");

localparam [7:0] DIGITS = 8'b1001_0101;

enum logic [8:0]{	BIT1 = 9'b000000001,
			BIT2 = 9'b000000010,
			BIT3 = 9'b000000100,
			BIT4 = 9'b000001000,
			BIT5 = 9'b000010000,
			BIT6 = 9'b000100000,
			BIT7 = 9'b001000000,
			BIT8 = 9'b010000000,
			MATCH = 9'b100000000} state = BIT1, nextstate = BIT1;

//////////////////////////////////
//	COMBINATIONAL		//
//////////////////////////////////

always_comb begin

unique case(state) //Case going through each case
BIT1: begin
	if(DIGITS[0] == latchedData[0]) begin		//Checks the first bit
		nextstate <= BIT2;			//If the same move to next state
		ready <= 1'b0;
	end else begin
		nextstate <= BIT1;			//Else go back to the first bit and get ready for more data
		match <= 0;
		ready <= 1'b1;
	end
end

BIT2: begin
	if(DIGITS[1] == latchedData[1]) begin		//Checks the second bit
		nextstate <= BIT3;			//If the same move to next state
		ready <= 1'b0;
	end else begin
		nextstate <= BIT1;			//Else go back to the first bit and get ready for more data
		match <= 0;
		ready <= 1'b1;
	end
end

BIT3: begin
	if(DIGITS[2] == latchedData[2]) begin		//Checks the third bit
		nextstate <= BIT4;			//If the same move to next state
		ready <= 1'b0;
	end else begin
		nextstate <= BIT1;			//Else go back to the first bit and get ready for more data
		match <= 0;
		ready <= 1'b1;
	end
end

BIT4: begin
	if(DIGITS[3] == latchedData[3]) begin		//Checks the fourth bit
		nextstate <= BIT5;			//If the same move to next state
		ready <= 1'b0;
	end else begin
		nextstate <= BIT1;			//Else go back to the first bit and get ready for more data
		match <= 0;
		ready <= 1'b1;
	end
end

BIT5: begin
	if(DIGITS[4] == latchedData[4]) begin		//Checks the fifth bit
		nextstate <= BIT6;			//If the same move to next state
		ready <= 1'b0;
	end else begin
		nextstate <= BIT1;			//Else go back to the first bit and get ready for more data
		match <= 0;
		ready <= 1'b1;
	end
end

BIT6: begin
	if(DIGITS[5] == latchedData[5]) begin		//Checks the sixth bit
		nextstate <= BIT7;			//If the same move to next state
		ready <= 1'b0;
	end else begin
		nextstate <= BIT1;			//Else go back to the first bit and get ready for more data
		match <= 0;
		ready <= 1'b1;
	end
end

BIT7: begin
	if(DIGITS[6] == latchedData[6]) begin		//Checks the seventh bit
		nextstate <= BIT8;			//If the same move to next state
		ready <= 1'b0;
	end else begin
		nextstate <= BIT1;			//Else go back to the first bit and get ready for more data
		match <= 0;
		ready <= 1'b1;
	end
end

BIT8: begin
	if(DIGITS[7] == latchedData[7]) begin		//Checks the eighth bit
		nextstate <= BIT1;			//If the same move to the first state
		match <= 1'b1;				//The sequencer matched the data to the sequence
		ready <= 1'b1;
	end else begin
		nextstate <= BIT1;			//Else go back to the first bit and get ready for more data
		match <= 0;
		ready <= 1'b1;
	end
end
endcase
end

//////////////////////////////////
//	SEQUENTIAL		//
//////////////////////////////////
always_ff@(posedge clk) begin
if (ready & sent) begin			//Latches new data if new data has been sent when it's ready to recieve
	latchedData = data;
end

state = nextstate;			//moves to the next state
end

always_ff@(posedge match) begin		//Writes MATCHED on the positive edge of match. This eliminated multiple writes in the combinational logic
$display("MATCHED");
$fwrite(write_file, "time=",$time,, "DATAIN = %b :: %b :: MATCHED\n", data, DIGITS);
end

always_ff@(posedge ready) begin
if(~match) begin
	$display("NOT MATCHED");	//Writes NOT MATCHED on pos edge of ready and when match is low
	$fwrite(write_file, "time=",$time,, "DATAIN = %b :: %b :: NOT MATCHED\n", data, DIGITS);
end
end
endmodule
