
module screenSaverPattern(
input clock25MHz,
input clock50MHz,
 input reset,  
input [9:0] x,
input [9:0] y,
output [3:0] red,
output [3:0] green,
output [3:0] blue
);

	reg [9:0] ballX =100;
	reg [9:0] ballY = 100;
	reg [10:0] counter;
	reg [30:0] prescaler;
	reg vSpeed = 1; // 1 - positive, 0 - negative;
	reg hSpeed = 1;
	localparam SPEED_CONSTANT = 100000;
	localparam SQUARE_SIZE = 20;
	wire topCollision = (ballY-SQUARE_SIZE==0);
   wire bottomCollision = (ballY+SQUARE_SIZE==479);
	wire leftCollision = (ballX-SQUARE_SIZE ==0);
	wire rightCollision = (ballX+SQUARE_SIZE == 639);
	

always @(posedge clock25MHz)
begin
	if(topCollision) vSpeed<=1;
	if(bottomCollision) vSpeed<=0;
	if(leftCollision) hSpeed<=1;
	if(rightCollision) hSpeed<=0;
 prescaler <= prescaler + 1;
  if (prescaler == SPEED_CONSTANT)
  begin
   ballX <= ballX + (hSpeed==1? 1 :-1);
	ballY <= ballY + (vSpeed==1? 1 : -1);
end
	if(prescaler>SPEED_CONSTANT) prescaler<=0;
end


wire ball = (ballX-SQUARE_SIZE<=x && ballX+SQUARE_SIZE>=x) & (ballY-SQUARE_SIZE<=y && ballY+SQUARE_SIZE>=y);

assign red = (ball) ? 4'hF: 0;
	assign green = (ball) ? 4'hF: 0;
	assign blue = (ball) ? 4'hF: 0;
endmodule