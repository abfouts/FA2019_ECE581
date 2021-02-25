// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu

// Problem 7 TB
`timescale 1ns/1ns

module Problem7_TB;
	logic [31:0] in;
	logic [31:0] out_1;
	logic [31:0] out_2;

	integer write_file;

	problem7_1 dut1(
		.x(in),
		.y(out_1)
	);

	problem7_2 dut2(
		.in(in),
		.out(out_2)
	);

	initial 
		begin
		#100
		in = 32'hF0000000;
		write_file = $fopen("log.txt", "a");
		$fwrite(write_file, "\n\nPROBLEM 7\n\n");
		
		for (int i = 0; i < 100; i = i + 1) begin
			#10 in <= in + 32'h0000000F;
			$display("time=",$time,,"Shift Right(HEX): In = %h :: Out = %h\n",in, out_1);
			$display("time=",$time,,"Shift Right(BIN): In(top 4 bits) = %b %b %b %b :: Out(top 4 bits) = %b %b %b %b\n",in[31], in[30], in[29], in[28], out_1[31], out_1[30], out_1[29], out_1[28]);
			$display("time=",$time,,"Shift Left(HEX): In = %h :: Out = %h\n",in, out_2);
			$display("time=",$time,,"Shift Left(BIN): In(top 4 bits) = %b %b %b %b :: Out(top 4 bits) = %b %b %b %b\n",in[31], in[30], in[29], in[28], out_2[31], out_2[30], out_2[29], out_2[28]);
			
			$fwrite(write_file, "time=",$time,,"Shift Right(HEX): In = %h :: Out = %h\n",in, out_1);
			$fwrite(write_file, "time=",$time,,"Shift Right(BIN): In(top 4 bits) = %b %b %b %b :: Out(top 4 bits) = %b %b %b %b\n",in[31], in[30], in[29], in[28], out_1[31], out_1[30], out_1[29], out_1[28]);
			$fwrite(write_file, "time=",$time,,"Shift Left(HEX): In = %h :: Out = %h\n",in, out_2);
			$fwrite(write_file, "time=",$time,,"Shift Left(BIN): In(top 4 bits) = %b %b %b %b :: Out(top 4 bits) = %b %b %b %b\n\n",in[31], in[30], in[29], in[28], out_2[31], out_2[30], out_2[29], out_2[28]);
		
		end
		$fclose(write_file);
		end


endmodule
