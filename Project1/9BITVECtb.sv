// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 1; Problem 2 test bench


module prob2_testbench(M, outBit1, outBit2);

input outBit1;
input outBit2;
output logic [8:0] M = 0;

integer write_file;

detector1 detector1tb(
.M(M),
.outBit(outBit1)
);

detector2 detector2tb(
.M(M),
.outBit(outBit2)
);

initial
begin

write_file = $fopen("log.txt", "a");
$fwrite(write_file, "\n\n PROBLEM 2 \n\n");

for(int i = 0; i < 512; i = i + 1) begin
	if(M != 511)
		#10 M <= M + 1'b1;
end

if(M == 511) //All bits high = 9
begin
$fwrite(write_file, "TIME = %d, M = %b, MATCHED\n", $time, M);
end

$fclose(write_file);

#100
$finish;
end
endmodule
