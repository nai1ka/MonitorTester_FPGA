module gradient(
input canDisplayImage,
input [9:0] x,
input [9:0] y,
output reg [3:0] red,
output reg [3:0] green,
output reg [3:0] blue);
reg[3:0] i=0;

always @(x|y)
begin
	if(canDisplayImage)begin
		
	red = x[9:6];
	green=i;
	blue=0;
	end

	else
	begin
	red = 0;
	green = 0;
	blue = 0;
	end
end


endmodule