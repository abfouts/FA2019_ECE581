// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 2; Problem 1 Testbench

module elevatorTB();
logic r1, r2, r3; 		//ins
logic d2, d1, n, u1, u2;	//outs for uut1
logic d2_1, d1_1, n_1, u1_1, u2_1;	//outs for uut2
logic clk;

int write_file;

mealy_elevator uut1(
.clk(clk),
.r1(r1), 
.r2(r2), 
.r3(r3), 
.d2(d2), 
.d1(d1), 
.n(n), 
.u1(u1), 
.u2(u2)
);

moore_elevator uut2(
.clk(clk),
.r1(r1), 
.r2(r2), 
.r3(r3), 
.d2(d2_1), 
.d1(d1_1), 
.n(n_1), 
.u1(u1_1), 
.u2(u2_1)
);

initial begin
forever begin
#5 clk = ~clk;
end
end

initial begin
write_file = $fopen("log.txt", "a");
$fwrite(write_file, "\n\nPROBLEM 1\n\n");

clk = 0;

#20
r1 <= 0;
r2 <= 0;
r3 <= 0;

#10

for(int i = 0; i < 25; i = i + 1) begin
#10 {r1, r2, r3} <= $random;
end
$fclose(write_file);
#30 $finish;
end

always_ff@(posedge clk)
begin
$display("time=",$time,, "INPUT = r1 = %b, r2 = %b, r3 = %b\n", r1, r2, r3);
$display("time=",$time,, "OUTPUT(mealy) = d2 = %b, d1 = %b, n = %b, u1 = %b, u2 = %b \n", d2, d1, n, u1, u2);
$display("time=",$time,, "OUTPUT(moore) = d2 = %b, d1 = %b, n = %b, u1 = %b, u2 = %b \n", d2_1, d1_1, n_1, u1_1, u2_1);
$fwrite(write_file, "time=",$time,, "INPUT = r1 = %b, r2 = %b, r3 = %b\n", r1, r2, r3);
$fwrite(write_file, "time=",$time,, "OUTPUT = d2 = %b, d1 = %b, n = %b, u1 = %b, u2 = %b \n", d2, d1, n, u1, u2);
$fwrite(write_file, "time=",$time,, "OUTPUT(moore) = d2 = %b, d1 = %b, n = %b, u1 = %b, u2 = %b \n", d2_1, d1_1, n_1, u1_1, u2_1);
end
endmodule

