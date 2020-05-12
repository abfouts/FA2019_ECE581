module bin_to_gray
  (
    output logic [4:0] g,
	input logic [4:0] b
  );
  
  always_comb
  begin
    g[4] = b[4]; //The first bit of binary code is equal to the first bit of graycode
	for (int i = 3; i >= 0; i--)
	begin
		g[i] = b[i+1] ^ b[i]; //Each following bit of graycode can be found by XORing the corresponding and next binary bits
	end
  end
endmodule: bin_to_gray


module gray_to_bin
  (
    output logic [3:0] b,
	input logic [3:0] g
  );
  
  always_comb
  begin
    b[3] = g[3]; //The first bit of graycode is equal to the first bit of binary code
	for (int i = 2; i >= 0; i--)
	begin
		b[i] = b[i+1] ^ g[i]; //Each following bit of binary code can be found by XORing the corresponding graycode and next binary bits
	end
  end
endmodule: gray_to_bin

module gray_adder(
    output logic [4:0] x,
    input logic [3:0] a, b
);

logic [3:0] a_bin, b_bin;
logic [4:0] sum;

gray_to_bin  convert_a(.b(a_bin), .g(a));
gray_to_bin  convert_b(.b(b_bin), .g(b));
bin_to_gray  convert_x(.g(x), .b(sum));

always_comb
begin
    sum = a_bin + b_bin;
end
endmodule: gray_adder

