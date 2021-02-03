// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 2; Problem 5

/////////////////////////////////////////////////////////////////////////////
// Design Unit: 	memoryController
// File Name:		problem5.sv
// Description:		A FIFO Memory Controller module
// Inputs of Wire types
// Limitations: 
// System:
// Author: 		Abram Fouts & Zoe Defreitas
// Revision: 		1
/////////////////////////////////////////////////////////////////////////////

module memoryController(rst, clk, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
input rst;
input clk;
input wr;
input rd;
output logic wr_en;		//Active High: when WR is asserted and full is deasserted
output logic rd_en;		//Active High: when RD is asserted and emp is deasserted
output logic [4:0] rd_ptr; 	//Next read location: Starts at 0
output logic [4:0] wr_ptr;	//Next write location: Starts at 0
output logic emp;		//FIFO empty? Active High : Starts at 1
output logic full;		//FIFO full? Active High : Starts at 0

assign full = ~emp;
assign wr_en = wr & ~full;						//wr_en high if wr is high and full is low
assign rd_en = rd & ~(rd_ptr + 1'b1 == wr_ptr);	//rd_en high if rd is high and emp is low
assign emp = (rd_ptr == wr_ptr + 1'b1) ? 1'b0 : 1'b1; 			//emp will need to be controlled elsewhere. How do you know if they are == is empty or full? 

enum logic [3:0] {	INIT = 4'b0001,
			IDLE = 4'b0010,
			WR = 4'b0100,
			RD = 4'b1000} 	state = INIT, nextstate = INIT;
always_comb begin
unique case(state)
INIT: begin				//Initial state, reset rd and wr pointers
	rd_ptr = 0;
	wr_ptr = 0;
	nextstate = IDLE;
end
IDLE: begin				//Idle state, waits for a WR or RD, WR has priority
	if(wr)
		nextstate = WR;
	else if(rd)
		nextstate = RD;
	else
		nextstate = IDLE;
end
WR: begin				//WR state, if buffer is full don't write
	if(full)
		nextstate = IDLE;
	else begin
		wr_ptr = wr_ptr + 1'b1;
		nextstate = IDLE;	
	end
end
RD: begin				//RD, if rd_en is low or rd nad wr pointers are == don't read
	if(~rd_en | (rd_ptr == wr_ptr))
		nextstate = IDLE;
	else begin
		rd_ptr = rd_ptr + 1'b1;
		nextstate = IDLE;
	end
end
endcase
end

always_ff @(posedge clk, posedge rst) begin
	if (rst)
	state <= INIT;
	else
	state <= nextstate;
end
endmodule
