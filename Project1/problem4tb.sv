// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Problem 4 TB

module Test_CLA_16bit();
    // Inputs
    logic [15:0] A;
    logic [15:0] B;
    logic Cin;

    // Outputs
    wire [15:0] Sum;
    wire Cout;


CLA_16bit uut(
.A(A), 
.B(B), 
.cin(Cin), 
.cout(Cout), 
.out(Sum)
);

    initial begin

	integer write_file;
	write_file = $fopen("log.txt", "a");
	$fwrite(write_file, "\n\nPROBLEM 4\n\n");

    // Initialize Inputs
    A = 0;  B = 0;  Cin = 0;
    #100
    // Add stimulus here
    	A=16'h0000;B=16'h0000;Cin=1'b0;
 $fwrite(write_file, "time=",$time,, "A=%h B=%h Cin=%b : Sum=%h Cout=%b\n",A,B,Cin,Sum,Cout);
	#10 A=16'h0001;B=16'h0000;Cin=1'b0;
 $fwrite(write_file, "time=",$time,, "A=%h B=%h Cin=%b : Sum=%h Cout=%b\n",A,B,Cin,Sum,Cout);
	#10 A=16'h0F0F;B=16'hF0F0;Cin=1'b0;
 $fwrite(write_file, "time=",$time,, "A=%h B=%h Cin=%b : Sum=%h Cout=%b\n",A,B,Cin,Sum,Cout);
	#10 A=16'hFF00;B=16'h00FF;Cin=1'b1;
 $fwrite(write_file, "time=",$time,, "A=%h B=%h Cin=%b : Sum=%h Cout=%b\n",A,B,Cin,Sum,Cout);
	#10 A=16'hFFF0;B=16'h0FF0;Cin=1'b0;
 $fwrite(write_file, "time=",$time,, "A=%h B=%h Cin=%b : Sum=%h Cout=%b\n",A,B,Cin,Sum,Cout);
	#10 A=16'h000F;B=16'hFF00;Cin=1'b1;
 $fwrite(write_file, "time=",$time,, "A=%h B=%h Cin=%b : Sum=%h Cout=%b\n",A,B,Cin,Sum,Cout);
	#10 A=16'hFF00;B=16'h0FF0;Cin=1'b0;
 $fwrite(write_file, "time=",$time,, "A=%h B=%h Cin=%b : Sum=%h Cout=%b\n",A,B,Cin,Sum,Cout);
	#10 A=16'h0FFF;B=16'h0F00;Cin=1'b1;
 $fwrite(write_file, "time=",$time,, "A=%h B=%h Cin=%b : Sum=%h Cout=%b\n",A,B,Cin,Sum,Cout);
	#10 A=16'hFFFF;B=16'h000F;Cin=1'b0;
 $fwrite(write_file, "time=",$time,, "A=%h B=%h Cin=%b : Sum=%h Cout=%b\n",A,B,Cin,Sum,Cout);

 
 $fclose(write_file);
 $finish;


    end 
 
    initial begin
 $monitor("time=",$time,, "A=%h B=%h Cin=%b : Sum=%h Cout=%b\n",A,B,Cin,Sum,Cout);

    end      
endmodule