
module Problem4_2_TB;

	logic [7:0] inp, outp;
	logic [2:0] opcode;
	logic clk;
	int write_file;


	Problem42 dut(
		.in(inp),
		.out(outp),
		.op(opcode),
		.clk(clk)
	);
	
	initial begin 
		write_file = $fopen("log.txt", "a");
		$fwrite(write_file, "\n\nPROBLEM 4-2\n\n");

		inp <= $random;
		

		//test begin
		opcode <= 000; #10;
		$fwrite(write_file, "time=",$time,, "INPUT : IN = %b, OP = %b\n", inp, opcode);
		$fwrite(write_file, "time=",$time,, "OUTPUT = %b \n", outp);

		opcode <= 001; #10;
		$fwrite(write_file, "time=",$time,, "INPUT : IN = %b, OP = %b\n", inp, opcode);
		$fwrite(write_file, "time=",$time,, "OUTPUT = %b \n", outp);

		opcode <= 010; #10;
		$fwrite(write_file, "time=",$time,, "INPUT : IN = %b, OP = %b\n", inp, opcode);
		$fwrite(write_file, "time=",$time,, "OUTPUT = %b \n", outp);

		opcode <= 011; #10;
		$fwrite(write_file, "time=",$time,, "INPUT : IN = %b, OP = %b\n", inp, opcode);
		$fwrite(write_file, "time=",$time,, "OUTPUT = %b \n", outp);

		opcode <= 100; #10;
		$fwrite(write_file, "time=",$time,, "INPUT : IN = %b, OP = %b\n", inp, opcode);
		$fwrite(write_file, "time=",$time,, "OUTPUT = %b \n", outp);

		opcode <= 101; #10;
		$fwrite(write_file, "time=",$time,, "INPUT : IN = %b, OP = %b\n", inp, opcode);
		$fwrite(write_file, "time=",$time,, "OUTPUT = %b \n", outp);

		opcode <= 110; #10;
		$fwrite(write_file, "time=",$time,, "INPUT : IN = %b, OP = %b\n", inp, opcode);
		$fwrite(write_file, "time=",$time,, "OUTPUT = %b \n", outp);

		opcode <= 111; #10;
		$fwrite(write_file, "time=",$time,, "INPUT : IN = %b, OP = %b\n", inp, opcode);
		$fwrite(write_file, "time=",$time,, "OUTPUT = %b \n", outp);
		

		$fclose(write_file);
	end

	always begin
		clk <= 1; #5;
		clk <= 0; #5;
	end

endmodule