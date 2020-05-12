// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu

// Problem 8 TB

`timescale 1ns/1ns

module Problem8_TB;

	logic [2:0] in;
	logic out;
	
	int write_file;

	Problem8 dut(
		.a(in[0]),
		.b(in[1]),
		.c(in[2]),
		.f(out)
	);
	
	initial begin 
		write_file = $fopen("log.txt", "a");
		$fwrite(write_file, "\n\nPROBLEM 8\n\n");

		in <= 0;
		//binary count to see what the output is
		for (int i = 0; i < 2**3; i = i + 1) begin
			#10 in <= in + 1'b1;
			$display("time=",$time,, "in(3bit) = %b, out = %b\n",in, out);
			$fwrite(write_file, "time=",$time,, "in(3bit) = %b, out = %b\n",in, out);
		end
		$fclose(write_file);
	end

endmodule
