module bouncingSquare(
input clock25MHz,
input [9:0] x,
input [9:0] y,
output [3:0] red,
output [3:0] green,
output [3:0] blue
);
	localparam SPEED_CONSTANT = 100000;
	localparam SQUARE_SIZE = 20;

	// Position of a square
	reg [9:0] squareX =100;
	reg [9:0] squareY = 100;
	
	// Counter for slowing down the animation
	reg [30:0] counter;
	
	// Vertical and horizontal speeds
	// 1 - positive direction, 0 - negative direction
	reg vSpeed = 1;
	reg hSpeed = 1;
	
	// Checking for collisions
	wire topCollision = (squareY-SQUARE_SIZE==0);
   wire bottomCollision = (squareY+SQUARE_SIZE==479);
	wire leftCollision = (squareX-SQUARE_SIZE ==0);
	wire rightCollision = (squareX+SQUARE_SIZE == 639);
	

always @(posedge clock25MHz)
begin
	if(topCollision) vSpeed<=1;
	if(bottomCollision) vSpeed<=0;
	if(leftCollision) hSpeed<=1;
	if(rightCollision) hSpeed<=0;
	counter <= counter + 1;
	if (counter == SPEED_CONSTANT)
	begin
		squareX <= squareX + (hSpeed==1? 1 : -1);
		squareY <= squareY + (vSpeed==1? 1 : -1);
	end
	if(counter>SPEED_CONSTANT) counter<=0;
end

// Drawing a square
wire square = (squareX-SQUARE_SIZE<=x && squareX+SQUARE_SIZE>=x) && (squareY-SQUARE_SIZE<=y && squareY+SQUARE_SIZE>=y);

assign red = (square) ? 4'hF: 0;
assign green = (square) ? 4'hF: 0;
assign blue = (square) ? 4'hF: 0;
endmodule