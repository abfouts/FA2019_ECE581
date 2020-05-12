// Abram Fouts - abfouts@pdx.edu
// Zoe DeFreitas - zcd2@pdx.edu
// Project 1; Problem 5

module full_adder(A, B, Ci, S, Co);
input A,B, Ci;
output S, Co;

assign S = (A ^ B) ^ Ci;
assign Co = ((A ^ B) & Ci) | (A & B);

endmodule

module half_adder(A, B, S, Co);
input A,B;
output S, Co;

assign S = A^B;
assign Co = A&B;
endmodule

module wallace(IN1, IN2, OUT);
input [7:0] IN1, IN2;	//IN1 = Miltiplicand :: IN2 = Multiplier
output [15:0] OUT;

wire [15:0] PP0, PP1, PP2, PP3, PP4, PP5, PP6, PP7;			//Stage 1 :: Partial Product
wire [15:0] PPA0, PPA1, PPA2, PPA3, PPA4, PPA5; 			//Stage 2 :: Partial Product Addition
wire [15:0] PPAS2_0, PPAS2_1, PPAS2_2, PPAS2_3;				//Stage 2 :: Partial Product Addition step 2
wire [15:0] ROW0, ROW1, ROW2;						//Repeating stage 2 again
wire [15:0] PPAS4_0, PPAS4_1;						//Stage 2 :: Last Step

//Unused locations
assign PPA0[15:10] = 1'b0;
assign PPA1[1:0] = 1'b0;
assign PPA1[15:10] = 1'b0;
assign PPA2[15:12] = 1'b0;
assign PPA2[2:0] = 1'b0;
assign PPA3[15:13] = 1'b0;
assign PPA3[4:0] = 1'b0;

assign PPAS2_0[15:11] = 1'b0;
assign PPAS2_1[15:13] = 1'b0;
assign PPAS2_1[2:0] = 1'b0;
assign PPAS2_2[15] = 1'b0;
assign PPAS2_2[4:0] = 1'b0;
assign PPAS2_3[15] = 1'b0;
assign PPAS2_3[6:0] = 1'b0;
assign ROW0[15:14] = 1'b0;
assign ROW1[15] = 1'b0;
assign ROW1[3:0] = 1'b0;
assign PPAS4_0[15] = 1'b0; 
assign PPAS4_1[4:0] = 1'b0; 

//STAGE 1 :: Partial Products
assign PP0 = IN1 * IN2[0];
assign PP1 = (IN1 * IN2[1]) << 1;
assign PP2 = (IN1 * IN2[2]) << 2;
assign PP3 = (IN1 * IN2[3]) << 3;
assign PP4 = (IN1 * IN2[4]) << 4;
assign PP5 = (IN1 * IN2[5]) << 5;
assign PP6 = (IN1 * IN2[6]) << 6;
assign PP7 = (IN1 * IN2[7]) << 7;

//STAGE 2 :: Partial Products Addition
//First set of 3 Rows
assign PPA0[0] = PP0[0];
half_adder S2R12C1(PP0[1], PP1[1], PPA0[1], PPA1[2]);
full_adder S2R12C2(PP0[2], PP1[2], PP2[2] ,PPA0[2], PPA1[3]);
full_adder S2R12C3(PP0[3], PP1[3], PP2[3] ,PPA0[3], PPA1[4]);
full_adder S2R12C4(PP0[4], PP1[4], PP2[4] ,PPA0[4], PPA1[5]);
full_adder S2R12C5(PP0[5], PP1[5], PP2[5] ,PPA0[5], PPA1[6]);
full_adder S2R12C6(PP0[6], PP1[6], PP2[6] ,PPA0[6], PPA1[7]);
full_adder S2R12C7(PP0[7], PP1[7], PP2[7] ,PPA0[7], PPA1[8]);
half_adder S2R12C8(PP1[8], PP2[8], PPA0[8], PPA1[9]);
assign PPA0[9] = PP2[9];

//Second set of 3 Rows
assign PPA2[3] = PP3[3];
half_adder S2R23C1(PP3[4], PP4[4], PPA2[4], PPA3[5]);
full_adder S2R23C2(PP3[5], PP4[5], PP5[5] ,PPA2[5], PPA3[6]);
full_adder S2R23C3(PP3[6], PP4[6], PP5[6] ,PPA2[6], PPA3[7]);
full_adder S2R23C4(PP3[7], PP4[7], PP5[7] ,PPA2[7], PPA3[8]);
full_adder S2R23C5(PP3[8], PP4[8], PP5[8] ,PPA2[8], PPA3[9]);
full_adder S2R23C6(PP3[9], PP4[9], PP5[9] ,PPA2[9], PPA3[10]);
full_adder S2R23C7(PP3[10], PP4[10], PP5[10] ,PPA2[10], PPA3[11]);
half_adder S2R23C8(PP4[11], PP5[11], PPA2[11], PPA3[12]);
assign PPA3[12] = PP5[12];

//Last 2 two rows
assign PPA4 = PP6;
assign PPA5 = PP7;

//Stage 2 Step 2, First 3 Rows
assign PPAS2_0[0] = PPA0[0];
assign PPAS2_0[1] = PPA0[1];
half_adder S22R12C1(PPA0[2], PPA1[2], PPAS2_0[2], PPAS2_1[3]);
full_adder S22R12C2(PPA0[3], PPA1[3], PPA2[3], PPAS2_0[3], PPAS2_1[4]);
full_adder S22R12C3(PPA0[4], PPA1[4], PPA2[4], PPAS2_0[4], PPAS2_1[5]);
full_adder S22R12C4(PPA0[5], PPA1[5], PPA2[5], PPAS2_0[5], PPAS2_1[6]);
full_adder S22R12C5(PPA0[6], PPA1[6], PPA2[6], PPAS2_0[6], PPAS2_1[7]);
full_adder S22R12C6(PPA0[7], PPA1[7], PPA2[7], PPAS2_0[7], PPAS2_1[8]);
full_adder S22R12C7(PPA0[8], PPA1[8], PPA2[8], PPAS2_0[8], PPAS2_1[9]);
full_adder S22R12C8(PPA0[9], PPA1[9], PPA2[9], PPAS2_0[9], PPAS2_1[10]);
assign PPAS2_0[10] = PPA2[10];
assign PPAS2_1[11] = PPA2[11];
assign PPAS2_1[12] = PPA2[12];

//Stage 2 Step 2, Last 3 Rows
assign PPAS2_2[5] = PPA3[5];
half_adder S22R34C1(PPA3[6], PPA4[6], PPAS2_2[6], PPAS2_3[7]);
full_adder S22R34C2(PPA3[7], PPA4[7], PPA5[7], PPAS2_2[7], PPAS2_3[8]);
full_adder S22R34C3(PPA3[8], PPA4[8], PPA5[8], PPAS2_2[8], PPAS2_3[9]);
full_adder S22R34C4(PPA3[9], PPA4[9], PPA5[9], PPAS2_2[9], PPAS2_3[10]);
full_adder S22R34C5(PPA3[10], PPA4[10], PPA5[10], PPAS2_2[10], PPAS2_3[11]);
full_adder S22R34C6(PPA3[11], PPA4[11], PPA5[11], PPAS2_2[11], PPAS2_3[12]);
full_adder S22R34C7(PPA3[12], PPA4[12], PPA5[12], PPAS2_2[12], PPAS2_3[13]);
half_adder S22R34C8(PPA4[13], PPA5[13], PPAS2_2[13], PPAS2_3[14]);
assign PPAS2_2[14] = PPA5[14];

//Stage 2 Step 3, 4 Rows to 3 rows
assign ROW0[0] = PPAS2_0[0];
assign ROW0[1] = PPAS2_0[1];
assign ROW0[2] = PPAS2_0[2];
half_adder step3_0(PPAS2_0[3], PPAS2_1[3], ROW0[3], ROW1[4]);
half_adder step3_1(PPAS2_0[4], PPAS2_1[4], ROW0[4], ROW1[5]);
full_adder step3_2(PPAS2_0[5], PPAS2_1[5], PPAS2_2[5], ROW0[5], ROW1[6]);
full_adder step3_3(PPAS2_0[6], PPAS2_1[6], PPAS2_2[6], ROW0[6], ROW1[7]);
full_adder step3_4(PPAS2_0[7], PPAS2_1[7], PPAS2_2[7], ROW0[7], ROW1[8]);
full_adder step3_5(PPAS2_0[8], PPAS2_1[8], PPAS2_2[8], ROW0[8], ROW1[9]);
full_adder step3_6(PPAS2_0[9], PPAS2_1[9], PPAS2_2[9], ROW0[9], ROW1[10]);
full_adder step3_7(PPAS2_0[10], PPAS2_1[10], PPAS2_2[10], ROW0[10], ROW1[11]);
half_adder step3_8(PPAS2_1[11], PPAS2_2[11], ROW0[11], ROW1[12]);
half_adder step3_9(PPAS2_1[12], PPAS2_2[12], ROW0[12], ROW1[13]);
assign ROW0[13] = PPAS2_2[13];
assign ROW1[14] = PPAS2_2[14];
assign ROW2 = PPAS2_3;

//STAGE 2 STEP 4
assign PPAS4_0[0] = ROW0[0];
assign PPAS4_0[1] = ROW0[1];
assign PPAS4_0[2] = ROW0[2];
assign PPAS4_0[3] = ROW0[3];
half_adder step4_0(ROW0[4], ROW1[4], PPAS4_0[4], PPAS4_1[5]);
half_adder step4_1(ROW0[5], ROW1[5], PPAS4_0[5], PPAS4_1[6]);
half_adder step4_2(ROW0[6], ROW1[6], PPAS4_0[6], PPAS4_1[7]);
full_adder step4_3(ROW0[7], ROW1[7], ROW2[7], PPAS4_0[7], PPAS4_1[8]);
full_adder step4_4(ROW0[8], ROW1[8], ROW2[8], PPAS4_0[8], PPAS4_1[9]);
full_adder step4_5(ROW0[9], ROW1[9], ROW2[9], PPAS4_0[9], PPAS4_1[10]);
full_adder step4_6(ROW0[10], ROW1[10], ROW2[10], PPAS4_0[10], PPAS4_1[11]);
full_adder step4_7(ROW0[11], ROW1[11], ROW2[11], PPAS4_0[11], PPAS4_1[12]);
full_adder step4_8(ROW0[12], ROW1[12], ROW2[12], PPAS4_0[12], PPAS4_1[13]);
full_adder step4_9(ROW0[13], ROW1[13], ROW2[13], PPAS4_0[13], PPAS4_1[14]);
half_adder step4_10(ROW1[14], ROW2[14], PPAS4_0[14], PPAS4_1[15]);

//Stage 4 :: Final Addition
assign OUT = (PPAS4_0 + PPAS4_1);

endmodule
