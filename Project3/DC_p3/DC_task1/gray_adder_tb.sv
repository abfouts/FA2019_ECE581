
`timescale 1ns/10ps
module gray_adder_tb;

logic [3:0] a, b;
logic [4:0] x;

gray_adder adder( //Initializing gray_adder to add 2 graycode numbers
    .x(x),
    .a(a),
    .b(b)
);

initial
begin
$monitor(,$time,"x=%b,a=%b,b=%b",x,a,b); //This monitor statement prints anytime these values change
#1 a = 4'b0000; b = 4'b0000; //Covers 16 combinations of adding 2 graycode numbers
#1 a = 4'b0001; b = 4'b0000;
#1 a = 4'b0010; b = 4'b0000;
#1 a = 4'b0011; b = 4'b0000;
#1 a = 4'b0000; b = 4'b0000;
#1 a = 4'b0000; b = 4'b0001;
#1 a = 4'b0000; b = 4'b0010;
#1 a = 4'b0000; b = 4'b0011;
#1 a = 4'b0000; b = 4'b0000;
#1 a = 4'b0001; b = 4'b0100;
#1 a = 4'b0010; b = 4'b1000;
#1 a = 4'b0011; b = 4'b1100;
#1 a = 4'b0100; b = 4'b0000;
#1 a = 4'b1000; b = 4'b0001;
#1 a = 4'b1100; b = 4'b0010;
#1 a = 4'b1000; b = 4'b0011;
#10 $finish;
end

endmodule: gray_adder_tb
