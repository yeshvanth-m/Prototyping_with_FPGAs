`timescale 1ns / 1ps

module top(
    input input_1,
    input input_2,
    input carry_in,
    output sum,
    output carry_out
    );

	Full_Adder FA1 ( .A(input_1), .B(input_2), .Cin(carry_in), .Sum(sum), .Cout(carry_out));
	
endmodule
