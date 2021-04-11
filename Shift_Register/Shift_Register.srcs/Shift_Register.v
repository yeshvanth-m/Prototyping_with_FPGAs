module Shift_Register (

	input wire [7:0] In,
	input Clk,
	input load,
	output reg [7:0] Out 
) ;

reg tmp = 1'b0 ;

always @ (posedge Clk)
	begin
	if(load)
    	begin
    		Out <= In;
    	end
	else
    	begin
    		tmp = Out[0] ;
    		Out = Out >> 1 ;
    		Out[7] = tmp ;
    	end
	end
endmodule 



