// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 2; Problem 5

/////////////////////////////////////////////////////////////////////////////
// Design Unit: 	memoryControllerTB
// File Name:		problem5.sv
// Description:		A FIFO Memory Controller module test bench
// Inputs of Wire types
// Limitations: 
// System:
// Author: 		Abram Fouts & Zoe Defreitas
// Revision: 		1
/////////////////////////////////////////////////////////////////////////////

module memoryControllerTB();
logic rst;
logic clk = 0;
logic wr;
logic rd;
logic wr_en;		//Active High: when WR is asserted and full is deasserted
logic rd_en;		//Active High: when RD is asserted and emp is deasserted
logic [4:0] rd_ptr; 	//Next read location: Starts at 0
logic [4:0] wr_ptr;	//Next write location: Starts at 0
logic emp;		//FIFO empty? Active High : Starts at 1
logic full;		//FIFO full? Active High : Starts at 0

int write_file;

memoryController uut(.rst(rst), .clk(clk), .wr(wr), .rd(rd), .wr_en(wr_en), .rd_en(rd_en), .rd_ptr(rd_ptr), .wr_ptr(wr_ptr), .emp(emp), .full(full));

initial begin
forever begin
#5 clk = ~clk;
end
end

initial begin
write_file = $fopen("log.txt", "a");
$fwrite(write_file, "\n\nPROBLEM 5\n\n");

rst = 0;
$display("time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
$fwrite(write_file, "time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b\n", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);

for (int i = 0; i < 2**5 + 3; i = i + 1) begin
#20 wr = 1'b1;
$display("time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
$fwrite(write_file, "time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b\n", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
end

#20 wr = 1'b0;

for (int i = 0; i < 2**5 + 3; i = i + 1) begin
#20 rd = 1'b1;
$display("time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
$fwrite(write_file, "time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b\n", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
end

for (int i = 0; i < 2**4; i = i + 1) begin
#20 wr = 1'b1;
$display("time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
$fwrite(write_file, "time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b\n", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
end

#20 rst = 1'b1;
$display("time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
$fwrite(write_file, "time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b\n", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
#20 rst = 1'b0;
$display("time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
$fwrite(write_file, "time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b\n", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);

forever begin
#20 wr = $random;
rd = $random;
$display("time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
$fwrite(write_file, "time=",$time,, "rst = %b, wr = %b, rd = %b, wr_en = %b, rd_en = %b, rd_ptr = %b, wr_ptr = %b, emp = %b, full = %b\n", rst, wr, rd, wr_en, rd_en, rd_ptr, wr_ptr, emp, full);
end

$fclose(write_file);
end
endmodule
