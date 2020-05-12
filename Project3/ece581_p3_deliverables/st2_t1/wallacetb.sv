// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 1; Problem 5tb

`timescale 1ns/1ps

module wallacetb();

logic [7:0] IN1, IN2;
logic [15:0] OUT; 
int counter = 0;
int product;

wallace uut(
.IN1(IN1), 
.IN2(IN2), 
.OUT(OUT)
);

initial begin

forever begin
 	IN1 = $random;
	IN2 = $random;
	product = IN1 * IN2;
#400 counter = counter + 1;
$display("IN1 = %b or %d :: IN2 = %b or %d OUT(WALLACE) = %b or %d :: Product(IN1 * IN2) = %d",IN1, IN1, IN2, IN2, OUT, OUT, product);
if (counter == 20)
	$finish;
end

end
/*
initial begin
$monitor("IN1 = %b or %d :: IN2 = %b or %d OUT(WALLACE) = %b or %d :: Product(IN1 * IN2) = %d",IN1, IN1, IN2, IN2, OUT, OUT, product);
end*/
endmodule
