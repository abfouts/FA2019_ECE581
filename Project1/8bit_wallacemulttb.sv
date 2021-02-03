// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 1; Problem 5tb

module wallaceTB();

logic [7:0] IN1, IN2;
logic [15:0] OUT; 
int product;
int write_file;

wallace uut(
.IN1(IN1), 
.IN2(IN2), 
.OUT(OUT)
);

initial begin
#100
	write_file = $fopen("log.txt", "a");
	$fwrite(write_file, "\n\nPROBLEM 5\n\n");
forever begin
 	IN1 = $random;
	IN2 = $random;
#400 	product = IN1 * IN2;
	$fwrite(write_file, "time=",$time,, "IN1 = %b or %d :: IN2 = %b or %d OUT(WALLACE) = %b or %d :: Product(IN1 * IN2) = %d\n",IN1, IN1, IN2, IN2, OUT, OUT, product);
end

//$display("IN1 = %b or %d, IN2 = %b or %d :: product = %d", IN1, IN1, IN2, IN2, product);
//$display("OUT = %b or %d", OUT, OUT);
$fclose(write_file);
end

initial begin
//$monitor("IN1 = %b or %d :: IN2 = %b or %d OUT(WALLACE) = %b or %d :: Product(IN1 * IN2) = %d",IN1, IN1, IN2, IN2, OUT, OUT, product);
end
endmodule
