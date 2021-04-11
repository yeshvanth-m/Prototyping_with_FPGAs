module hvsync_generator(clk, vga_h_sync, vga_v_sync, inDisplayArea, CounterX, CounterY);

input clk;  // 25MHz clock after division
output vga_h_sync, vga_v_sync;
output inDisplayArea;
output [9:0] CounterX;
output [8:0] CounterY;

reg [9:0] CounterX;
reg [8:0] CounterY;
wire CounterXmaxed = (CounterX == 10'h2FF); //Maximum horizontal distance

always @(posedge clk)
if(CounterXmaxed)      //reset horizontal count
	CounterX <= 0;
else
	CounterX <= CounterX + 1; //increment counter if not overflow

always @(posedge clk)
	if(CounterXmaxed) CounterY <= CounterY + 1; //increment vertical counter

reg	vga_HS, vga_VS;

always @(posedge clk)
begin
	vga_HS <= (CounterX[9:4] == 6'h28); // change this value to move the display horizontally
	vga_VS <= (CounterY == 479); // change this value to move the display vertically
end

reg inDisplayArea;

always @(posedge clk)
if(inDisplayArea == 0)
	inDisplayArea <= (CounterXmaxed) && (CounterY < 480); //maximum display area possible
else
	inDisplayArea <= !(CounterX == 639); //for horizontal
	
assign vga_h_sync = ~vga_HS; //complemented output for VGA signal
assign vga_v_sync = ~vga_VS;

endmodule

