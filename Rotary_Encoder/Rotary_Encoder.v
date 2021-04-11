module Rotary_Encoder(clk, rot_en_A, rot_en_B, switch_in, switch_out, direction_led, count);

input clk, rot_en_A, rot_en_B, switch_in;
output switch_out, direction_led;
output [7:0] count;

reg [2:0] rot_en_A_delayed, rot_en_B_delayed;

always @(posedge clk) 
begin
	rot_en_A_delayed <= {rot_en_A_delayed[1:0], rot_en_A};
end

always @(posedge clk) 
begin
	rot_en_B_delayed <= {rot_en_B_delayed[1:0], rot_en_B};
end

wire count_enable = rot_en_A_delayed[1] ^ rot_en_A_delayed[2] ^ rot_en_B_delayed[1] ^ rot_en_B_delayed[2];
wire count_direction = rot_en_A_delayed[1] ^ rot_en_B_delayed[2];

assign switch_out = switch_in;
assign direction_led = count_direction;

reg [7:0] count;

always @(posedge clk)
begin
  if(count_enable)
  begin
    if(count_direction)
	 begin
		count <= count + 1; 
	 end
	 else
	 begin
		count <= count - 1;
	 end
  end
end

endmodule
