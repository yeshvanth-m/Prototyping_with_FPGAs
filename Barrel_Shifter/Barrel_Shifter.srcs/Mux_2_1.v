module Mux_2_1(Y,I0,I1,S);

	input I0,I1,S;                 // Mux Input and Select Lines
	output Y;                      // Mux Output
	
	wire andop1, andop2, notop;    // Gates output
	
	not n1 (notop, S);             // Complement of Select Line
	
	and a1 (andop1, I0, notop),    // AND Op. of Input 1 and complement of Select Line
		a2 (andop2, I1, S);        // AND Op. of Input 2 and Select Line 
		
	or o1 (Y, andop1, andop2);     // Or Op. of the two AND outputs
	
endmodule
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
