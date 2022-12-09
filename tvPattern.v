module tvPattern(
input [9:0] x,
input [9:0] y,
output reg [3:0] red,
output reg [3:0] green,
output reg [3:0] blue);

always @(x||y)
begin
if(x>=0 && x<91*1) // White
	begin
		red <= 4'hF;
		green <= 4'hF;
		blue <= 4'hF;
	end
	else if(x>=91*1 && x<91*2) //Yellow
	begin
		red <= 4'hF;
		blue <=  0;
		green <= 4'hF;
	end
	else if(x>=91*2 && x<91*3) // Cyan
	begin
		red <= 0;
		blue <=  4'hF;
		green <= 4'hF;
	end
	else if(x>=91*3 && x<91*4) //Green
	begin
		red <= 0;
		blue <=  0;
		green <= 4'hF;
	end
	else if(x>=91*4 && x<91*5) //Magenta
	begin
		red <= 4'hF;
		blue <=  4'hF;
		green <= 0;
	end
	else if(x>=91*5 && x<91*6)
	begin
		red <= 4'hF;
		blue <= 0;
		green <= 0;
	end
	else if(x>=91*6 && x<91*7)
	begin
		red <= 0;
		blue <= 4'hF;
		green <= 0;
	end
	else 
	begin
		red <= 0;
		green <= 0;
		blue <= 0;
	end

end



endmodule