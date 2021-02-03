// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu

//Problem 6 - Hamming Code Encoder and Decoder

//Hamming Code Learnings from https://www.youtube.com/watch?v=eixCGqdlGxQ 
//and https://www.youtube.com/watch?v=wbH2VxzmoZk 
//and https://www.youtube.com/watch?v=1A_NcXxdoCc

//Hamming Encoder
module hamming_encode(dataI, dataO);
input 		[3:0] dataI; //4 bit data in
output logic 	[6:0] dataO; // 7 bit data out

wire p1, p2, p3;

assign p1 = dataI[0] ^ dataI[1] ^ dataI[3];	// P1 = D0 XOR D1 XOR D3
assign p2 = dataI[0] ^ dataI[2] ^ dataI[3];	// P2 = D0 XOR D2 XOR D3
assign p3 = dataI[1] ^ dataI[2] ^ dataI[3];	// P3 = D1 XOR D2 XOR D3

assign dataO = {p1, p2, dataI[0], p3, dataI[1], dataI[2], dataI[3]};
endmodule

//
// Hamming Decoder
module hamming_decode(dataI, parity, dataO, correct);
input 		[6:0] dataI; 	// 7 bit data in
input 		parity;	     	// 1 = odd, 0 = even
output logic 	[3:0] dataO; 	// 4 bit data out
output logic 	[6:0] correct; 	//Corrected value if any

logic [6:0] XORcopy = 7'b0000000;

integer sum;

wire p1, p2, p3; 									//Keeps track of SHOULD BE parity bits

assign p1 = (parity == (dataI[0] ^ dataI[2] ^ dataI[4] ^ dataI[6])) ?  1'b0 : 1'b1;	//if the parity XOR 3 corresponding data bits == given parity = 0 else 1
assign p2 = (parity == (dataI[1] ^ dataI[2] ^ dataI[5] ^ dataI[6])) ?  1'b0 : 1'b1;	//if the parity XOR 3 corresponding data bits == given parity = 0 else 1
assign p3 = (parity == (dataI[3] ^ dataI[4] ^ dataI[5] ^ dataI[6])) ?  1'b0 : 1'b1;	//if the parity XOR 3 corresponding data bits == given parity = 0 else 1

assign sum = {p3, p2, p1}; 								//Integer value of 3'bP3,P2,P1

always_comb
begin
/*
$display("p1 = %b", p1); //DEBUG TEST 
$display("p2 = %b", p2);
$display("p3 = %b", p3);
$display("sum = bin %b, int %d", sum, sum);*/
//XORcopy <= 7'b0000000;	
if (sum != 0)							//Makes sum bit a 1 in XORcopy
	begin
	for(int i = 1; i < 8; i = i + 1) begin
		if(i == sum)
			XORcopy[i-1] = 1'b1;
		else
			XORcopy[i-1] = 1'b0;
	end
	end
end

assign correct = (dataI ^ XORcopy);							//XOR to change the wrong bit
assign dataO = {correct[6],correct[5],correct[4],correct[2]};

endmodule
