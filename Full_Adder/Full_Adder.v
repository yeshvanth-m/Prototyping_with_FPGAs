`timescale 1ns / 1ps

module Full_Adder (
	input A, B, Cin,
	output Sum, Cout
);

	wire X1, A1, A2;
	
	xor gate1 (X1, A, B),
		gate2 (Sum, X1, Cin);
	
	and gate3 (A1, A, B),
		gate4 (A2, X1, Cin);
		
	or gate5 (Cout, A1, A2);
	
endmodule
