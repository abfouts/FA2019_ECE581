// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu

// Problem 6 TB

module hammingTB();
//Testing data to hamming module
logic [6:0] hamming;
logic [3:0] dataOnly;
logic parity;

logic [6:0] hamming_in;
logic [3:0] data_out;
logic [6:0] hamming_fix;

hamming_encode uut(
.dataI(dataOnly),
.dataO(hamming)
);

hamming_decode uut2(
.dataI(hamming_in),
.parity(parity),
.dataO(data_out),
.correct(hamming_fix)
);

integer write_file;

initial begin
#100

write_file = $fopen("log.txt", "a");
$fwrite(write_file, "\n\nPROBLEM 6\n\n");

hamming <= 0;
dataOnly <= 0;
parity <= 0;
hamming_in <= 0;
data_out <= 0;
hamming_fix <= 0;
#10

for(int i = 0; i< 2**4; i= i+1) begin
#10
dataOnly <= dataOnly + 1'b1;
$display("time=",$time,, "4 Bit data in = %b : encode(7 bit) = %b\n", dataOnly, hamming); //data to hamming module
$fwrite(write_file,"time=",$time,, "4 Bit data in = %b : encode(7 bit) = %b\n", dataOnly, hamming); //print to file
end

for(int i = 0; i< 2**7; i= i+1) begin
#20
hamming_in <= hamming_in + 1'b1;
$display("time=",$time,, "4 Bit data out = %b : Hamming_in(7 bit) = %b, corrected Hamming = %b, parity=%b\n", data_out, hamming_in, hamming_fix, parity); 	//hamming to 4 bit
$fwrite(write_file,"time=",$time,, "4 Bit data out = %b : Hamming_in(7 bit) = %b, corrected Hamming = %b, parity=%b\n", data_out, hamming_in, hamming_fix, parity);
end

parity <= 1;
hamming_in <= 0;

for(int i = 0; i< 2**7; i= i+1) begin
#20
hamming_in <= hamming_in + 1'b1;
$display("time=",$time,, "4 Bit data out = %b : Hamming_in(7 bit) = %b, corrected Hamming = %b, parity=%b\n", data_out, hamming_in, hamming_fix, parity); 	//hamming to 4 bit
$fwrite(write_file, "time=",$time,, "4 Bit data out = %b : Hamming_in(7 bit) = %b, corrected Hamming = %b, parity=%b\n", data_out, hamming_in, hamming_fix, parity);
end
$fclose(write_file);

end
endmodule
