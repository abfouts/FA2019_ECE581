// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 2; Problem 2 TB
// Last 2 digits: 95 = 1001_0101

module sequencerTB();
logic [7:0] data;
logic clk = 0;
logic sent = 0;
logic ready;
logic match;

int write_file;

sequencer uut(
.clk(clk), 
.data(data), 
.sent(sent), 
.ready(ready), 
.match(match)
);

initial begin
clk = 0;
forever begin
#5 clk = ~clk; // clock period = 10, at least 80 to get through the code
end
end

initial begin
#50

forever begin
#20 if(ready) begin
	data = $random;
	sent = 1'b1;
	$display("data = %b", data);
end
end
end

endmodule
