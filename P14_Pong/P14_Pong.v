module P14_Pong(
    output VGA_RED,
    output VGA_GREEN,
    output VGA_BLUE,
    output VGA_HSYNC,
    output VGA_VSYNC,
	 output LED_0,
	 output LED_1,
	 output LED_2,
	 output LED_3,
	 output LED_4,
	 output LED_5,
	 output LED_6,
	 output LED_7,
	 input  ROT_A,
	 input  ROT_B,
	 input  SW_0,
	 input  SW_1,
	 input  SW_2,
	 input  SW_3,
	 input  CLK_50MHZ
);

// DE0 Nano has a 50MHz clock.
// This section divides CLK_50MHZ by 2 and outputs clk.
reg clk;

always @(posedge CLK_50MHZ)
clk <= ~clk;

wire inDisplayArea;
wire [9:0] CounterX;
wire [8:0] CounterY;

hvsync_generator syncgen(.clk(clk), .vga_h_sync(VGA_HSYNC), .vga_v_sync(VGA_VSYNC), 
  .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
  

/////////////////////////////////////////////////////////////////
reg [9:0] BouncerPosition, AutoBouncerPosition;
reg [2:0] quadAr, quadBr;
always @(posedge clk) quadAr <= {quadAr[1:0], ROT_A};
always @(posedge clk) quadBr <= {quadBr[1:0], ROT_B};

always @(posedge clk)
if(quadAr[2] ^ quadAr[1] ^ quadBr[2] ^ quadBr[1])
begin
	if(quadAr[2] ^ quadBr[1])
	begin
		if(~&BouncerPosition)        // make sure the value doesn't overflow
			BouncerPosition <= BouncerPosition + 1;
	end
	else
	begin
		if(|BouncerPosition)        // make sure the value doesn't underflow
			BouncerPosition <= BouncerPosition - 1;
	end
end

/////////////////////////////////////////////////////////////////

reg [9:0] ballX;
reg [8:0] ballY;
reg ball_inX, ball_inY;

always @(posedge clk)
if(ball_inX==0) ball_inX <= (CounterX==ballX) & ball_inY; else ball_inX <= !(CounterX==ballX+16);

always @(posedge clk)
if(ball_inY==0) ball_inY <= (CounterY==ballY); else ball_inY <= !(CounterY==ballY+16);

wire ball = ball_inX & ball_inY;

/////////////////////////////////////////////////////////////////
// Draw a border around the screen                //79
wire border = (CounterX[9:3]==0) || (CounterX[9:3]==72) || (CounterY[8:3]==0) || (CounterY[8:3]==59);
wire manualBouncer = (CounterX>=BouncerPosition+8) && (CounterX<=BouncerPosition+120) && (CounterY[8:4]==27);
wire autoBouncer = (CounterX>=(AutoBouncerPosition-60)+8) && (CounterX<=(AutoBouncerPosition-60)+120) && (CounterY[8:4]==27);
wire Bouncer = (SW_0 ? (autoBouncer) : manualBouncer); // select based on SW_0
wire BouncingObject = border | Bouncer; // active if the border or Bouncer is redrawing itself

reg ball_dirX, ball_dirY;
reg ResetCollision;
always @(posedge clk) ResetCollision <= (CounterY==500) & (CounterX==0);  // active only once for every video frame

reg CollisionX1, CollisionX2, CollisionY1, CollisionY2;
always @(posedge clk) if(ResetCollision) CollisionX1<=0; else if(BouncingObject & (CounterX==ballX   ) & (CounterY==ballY+ 8)) CollisionX1<=1;
always @(posedge clk) if(ResetCollision) CollisionX2<=0; else if(BouncingObject & (CounterX==ballX+16) & (CounterY==ballY+ 8)) CollisionX2<=1;
always @(posedge clk) if(ResetCollision) CollisionY1<=0; else if(BouncingObject & (CounterX==ballX+ 8) & (CounterY==ballY   )) CollisionY1<=1;
always @(posedge clk) if(ResetCollision) CollisionY2<=0; else if(BouncingObject & (CounterX==ballX+ 8) & (CounterY==ballY+16)) CollisionY2<=1;

// Output assigns for LEDs
assign LED_0 = CollisionX1;
assign LED_1 = CollisionX2;
assign LED_2 = CollisionY1;
assign LED_3 = CollisionY2;
assign LED_7 = ROT_A;
assign LED_6 = ROT_B;
assign LED_5 = ball_dirX;
assign LED_4 = ball_dirY;

/////////////////////////////////////////////////////////////////
wire UpdateBallPosition = ResetCollision;  // update the ball position at the same time that we reset the collision detectors

always @(posedge clk)
if(UpdateBallPosition & SW_3) // only update ball if SW_3 allows.
begin
	if(~(CollisionX1 & CollisionX2))        // if collision on both X-sides, don't move in the X direction
	begin
		ballX <= ballX + (ball_dirX ? (SW_1 ? -3 : -1) : (SW_1 ? 3 : 1));  // Speed set by SW_1
		if(CollisionX2) ball_dirX <= 1; else if(CollisionX1) ball_dirX <= 0;
	end

	if(~(CollisionY1 & CollisionY2))        // if collision on both Y-sides, don't move in the Y direction
	begin
		ballY <= ballY + (ball_dirY ? (SW_1 ? -3 : -1) : (SW_1 ? 3 : 1)); // Speed set by SW_1
		if(CollisionY2) ball_dirY <= 1; else if(CollisionY1) ball_dirY <= 0;
	end
	
	AutoBouncerPosition <= ((ballX<=60) ? 60 : (ballX>=520) ? 520 : ballX);  // Don't let autoBouncer drive off screen edge!
end 

/////////////////////////////////////////////////////////////////

// Set colour scheme based on SW_2
wire R = ((~SW_2 & (border | Bouncer | ball)) | (SW_2 & (border | Bouncer)));
wire G = ((~SW_2 & (border | Bouncer | ball)) | (SW_2 & (border)));
wire B = ((~SW_2 & (border | Bouncer | ball)) | (SW_2 & (ball)));

reg VGA_R, VGA_G, VGA_B;

assign VGA_RED   = VGA_R;
assign VGA_GREEN = VGA_G;
assign VGA_BLUE  = VGA_B;

always @(posedge clk)
begin
  VGA_R <= R & inDisplayArea;
  VGA_G <= G & inDisplayArea;
  VGA_B <= B & inDisplayArea;
end

endmodule