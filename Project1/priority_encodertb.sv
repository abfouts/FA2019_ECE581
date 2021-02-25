// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 1; Problem 3 test bench


module problem3tb(encode, inVal, enable);
input  [2:0] 		encode; 
output reg [2**3-1:0] 	inVal;
output logic 		enable;


initial begin

integer write_file;
write_file = $fopen("log.txt", "a");
$fwrite(write_file, "\n\nPROBLEM 3\n\n");

enable = 0;
#10;

$fwrite(write_file, "TIME = %d, inVal = %b, encode = %b, enable = %b \n", $time, inVal, encode, enable);

enable = 1;
#50;    
inVal = 0;
for(int i = 0; i < 2**8; i = i + 1) begin
	#10 inVal <= inVal + 1'b1;
	$fwrite(write_file, "TIME = %d, inVal = %b, encode = %b, enable = %b \n", $time, inVal, encode, enable);
end

#500 
$fclose(write_file);
$finish;
end

encoder #(3)
test1(
.enable(enable), 
.inVal(inVal), 
.encode(encode)
);

initial begin
$monitor("time=",$time,, "inVal=%b : encode=%b enable=%b",inVal,encode,enable); 

end

endmodule
