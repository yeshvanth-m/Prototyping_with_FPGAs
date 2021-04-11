module Barrel_Shifter_8 (

	input [7:0]In, [2:0]S,  //Barrel Shifter i/p and Select Lines
	output [7:0]Out         //Barrel Shifter o/p
	
);
	
	wire MS1[7:0], MS2[7:0]; // o/p of two stages of BS
	
	Mux_2_1 M1 (.Y(MS1[7]), .I0(In[7]), .I1(In[3]), .S(S[2]));
	Mux_2_1 M2 (.Y(MS1[6]), .I0(In[6]), .I1(In[2]), .S(S[2]));
	Mux_2_1 M3 (.Y(MS1[5]), .I0(In[5]), .I1(In[1]), .S(S[2]));
	Mux_2_1 M4 (.Y(MS1[4]), .I0(In[4]), .I1(In[0]), .S(S[2]));
	Mux_2_1 M5 (.Y(MS1[3]), .I0(In[3]), .I1(In[7]), .S(S[2]));
	Mux_2_1 M6 (.Y(MS1[2]), .I0(In[2]), .I1(In[6]), .S(S[2]));
	Mux_2_1 M7 (.Y(MS1[1]), .I0(In[1]), .I1(In[5]), .S(S[2]));
	Mux_2_1 M8 (.Y(MS1[0]), .I0(In[0]), .I1(In[4]), .S(S[2]));
	
	Mux_2_1 M9 (.Y(MS2[7]), .I0(MS1[7]), .I1(MS1[1]), .S(S[1]));
	Mux_2_1 M10 (.Y(MS2[6]), .I0(MS1[6]), .I1(MS1[0]), .S(S[1]));
	Mux_2_1 M11 (.Y(MS2[5]), .I0(MS1[5]), .I1(MS1[7]), .S(S[1]));
	Mux_2_1 M12 (.Y(MS2[4]), .I0(MS1[4]), .I1(MS1[6]), .S(S[1]));
	Mux_2_1 M13 (.Y(MS2[3]), .I0(MS1[3]), .I1(MS1[5]), .S(S[1]));
	Mux_2_1 M14 (.Y(MS2[2]), .I0(MS1[2]), .I1(MS1[4]), .S(S[1]));
	Mux_2_1 M15 (.Y(MS2[1]), .I0(MS1[1]), .I1(MS1[3]), .S(S[1]));
	Mux_2_1 M16 (.Y(MS2[0]), .I0(MS1[0]), .I1(MS1[2]), .S(S[1]));
	
	Mux_2_1 M17 (.Y(Out[7]), .I0(MS2[7]), .I1(MS2[0]), .S(S[0]));
	Mux_2_1 M18 (.Y(Out[6]), .I0(MS2[6]), .I1(MS2[7]), .S(S[0]));
	Mux_2_1 M19 (.Y(Out[5]), .I0(MS2[5]), .I1(MS2[6]), .S(S[0]));
	Mux_2_1 M20 (.Y(Out[4]), .I0(MS2[4]), .I1(MS2[5]), .S(S[0]));
	Mux_2_1 M21 (.Y(Out[3]), .I0(MS2[3]), .I1(MS2[4]), .S(S[0]));
	Mux_2_1 M22 (.Y(Out[2]), .I0(MS2[2]), .I1(MS2[3]), .S(S[0]));
	Mux_2_1 M23 (.Y(Out[1]), .I0(MS2[1]), .I1(MS2[2]), .S(S[0]));
	Mux_2_1 M24 (.Y(Out[0]), .I0(MS2[0]), .I1(MS2[1]), .S(S[0]));

endmodule	




