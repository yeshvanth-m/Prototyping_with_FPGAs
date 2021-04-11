module Counter (
	input Clk_50MHz, reset_c, reset_fd,
	output reg[7:0] Count
);
	
	wire Clk_1Hz;
	
	Freq_Divider FD1 (.clk_50MHz(Clk_50MHz), .clk_1Hz(Clk_1Hz), .reset(reset_fd));

	always @ (posedge Clk_1Hz)
	begin
		if(reset_c)
		begin
			Count <= 0;
		end
		else
		begin
			Count <= Count + 1;
		end
	end
	
endmodule

		


	
	
