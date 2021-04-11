module Freq_Divider(
	input clk_50MHz, reset,
	output reg clk_1Hz 
);

	reg [31:0] divide_counter;

	always @ (posedge clk_50MHz)
	begin
		if(reset)
		begin
			divide_counter <= 0;
			clk_1Hz <= 0;
		end
		else if (divide_counter <= 25000000)
		begin
			divide_counter <= divide_counter + 1;
		end	
		else 
		begin
			divide_counter <= 0;
			clk_1Hz <= ~clk_1Hz;
		end
	end
	
endmodule
