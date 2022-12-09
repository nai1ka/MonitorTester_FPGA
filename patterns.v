module patterns(
input canDisplayImage,
input  [9:0] switches,
input [9:0] x,
input [9:0] y,
input clock25MHz
output reg [3:0] red,
output reg [3:0] green,
output reg [3:0] blue);

reg [9:0] squareX;
reg [9:0] squareY;
reg [10:0] squareCounter;
localparam squareSize = 10;
reg [2:0] vX;
reg [2:0] vY;

always @(x|y)
begin	
	squareX = 100;
	squareY = 100;
	if(canDisplayImage)
	begin
		case(switches)
		1: 
		begin
			if(x>=0 && x<91*1) // White
			begin
				red = 4'hF;
				green = 4'hF;
				blue = 4'hF;
			end
			else if(x>=91*1 && x<91*2) //Yellow
			begin
				red = 4'hF;
				blue =  0;
				green = 4'hF;
			end
			else if(x>=91*2 && x<91*3) // Cyan
			begin
				red = 0;
				blue =  4'hF;
				green = 4'hF;
			end
			else if(x>=91*3 && x<91*4) //Green
			begin
				red = 0;
				blue =  0;
				green = 4'hF;
			end
			else if(x>=91*4 && x<91*5) //Magenta
			begin
				red = 4'hF;
				blue =  4'hF;
				green = 0;
			end
			else if(x>=91*5 && x<91*6)
			begin
				red = 4'hF;
				blue = 0;
				green = 0;
			end
			else if(x>=91*6 && x<91*7)
			begin
				red = 0;
				blue = 4'hF;
				green = 0;
			end
			else 
			begin
				red = 0;
				green = 0;
				blue = 0;
			end
		end
		2:
		begin
			red = 4'hF;
			green = 0;
			blue = 0;
		end
		4:
		begin
			red = 0;
			green = 4'hF;
			blue = 0;
		end
		
		8:
		begin
			red = 0;
			green = 0;
			blue = 4'hF;
		end
		
		16:
		begin
			red = x[9:6];
			green=0;
			blue=0;
		end
		
		32:
		begin
			red = (x%2==0 || y%2==0) ? 4'hF : 0;
		   green = (x%2==0 || y&2==0) ? 4'hF : 0;
		   blue = (x%2==0 || y%2==0) ? 4'hF : 0;
		end
		64:
		begin
			if(x>= (squareX- squareSize) && x<= (squareX + squareSize) && y>=(squareY-squareSize) && y<=(squareY+squareSize))
			begin
			red = 4'hF;
			green = 4'hF;
			blue = 4'hF;
			end
			else
			begin
			red=0;
			green = 0;
			blue = 0;
			end
		end
		default:
		begin
			red = 0;
			green= 0;
			blue = 0;
		end
		endcase
	end
	else
	begin
		red = 0;
		green = 0;
		blue = 0;
	end
end

always @(clock25MHz)
begin

end


endmodule