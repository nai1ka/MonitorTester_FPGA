
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

always @(posedge clock25MHz)
begin
 prescaler <= prescaler + 1;
  if (prescaler == 1000000)
  begin
   ballX <= ballX + 1;
end
	if(prescaler>1000000) prescaler<=0;
end


wire ball = (ballX-10<=x && ballX+10>=x) & (ballY-10<=y && ballY+10>=y);

assign red = (ball) ? 4'hF: 0;
	assign green = (ball) ? 4'hF: 0;
	assign blue = (ball) ? 4'hF: 0;
endmodule