module VGA(clk_50M, vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B);

input clk_50M;
output vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B;

reg clk;

always @(posedge clk_50M)
clk <= ~clk;

wire inDisplayArea;
wire [9:0] CounterX;
wire [8:0] CounterY;

hvsync_generator syncgen(.clk(clk), .vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync),
                            .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));

reg R,G,B;

always @ (posedge clk)
begin
    if (CounterX < 80 && CounterY < 480)
    begin
      G <= 1'b1;
      B <= 1'b1; 
      R <= 1'b1;
    end
    else if (CounterX < 160 && CounterY < 480) 
    begin
      G <= 1'b1;
      B <= 1'b0; 
      R <= 1'b1;
    end
    else if (CounterX < 240 && CounterY < 480)
    begin
      G <= 1'b1;
      B <= 1'b1; 
      R <= 1'b0;
    end
    else if (CounterX < 320 && CounterY < 480)
    begin
      G <= 1'b1;
      B <= 1'b0; 
      R <= 1'b0;
    end
    else if (CounterX < 400 && CounterY < 480)
    begin
      G <= 1'b0;
      B <= 1'b1; 
      R <= 1'b1;
    end
    else if (CounterX < 480 && CounterY < 480)
    begin
      G <= 1'b0;
      B <= 1'b0; 
      R <= 1'b1;
    end
    else if (CounterX < 560 && CounterY < 480)
    begin
      G <= 1'b0;
      B <= 1'b1; 
      R <= 1'b0;
    end
    else if (CounterX < 640 && CounterY < 480)
    begin
      G <= 1'b0;
      B <= 1'b0; 
      R <= 1'b0;
    end
    else 
    begin
      G <= 1'b0;
      B <= 1'b0; 
      R <= 1'b0;
    end
end 

reg vga_R, vga_G, vga_B;
always @(posedge clk)
begin
  vga_R <= R & inDisplayArea;
  vga_G <= G & inDisplayArea;
  vga_B <= B & inDisplayArea;
end

endmodule
