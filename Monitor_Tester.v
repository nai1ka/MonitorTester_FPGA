module Monitor_Tester(
   clock50MHz,
   switches,
   red,
	blue,
	green,
   hsync,
   vsync,
	nextButton,
	prevButton,	
);
input  clock50MHz;  
input  [9:0] switches;
output reg [3:0]  red;
output reg [3:0]  blue;
output reg [3:0] green; 
input nextButton;
input prevButton;
output hsync;   
output vsync;  

reg [4:0] currentMode = 1;
wire  isOverflowH;
wire  isOVerflowV;
wire  dat_act;
wire  clock25MHz;
wire isHorizontalActive;
wire isVerticalActive;
wire canDisplayImage;
localparam numberOfModes = 7;
wire [9:0] x;
wire [9:0] y;

clock_divider clock_divider(
clock50MHz, clock25MHz
);


wire nextButtonDebounced;
wire prevButtonDebounced;

debounce debounce1(nextButton,clock50MHz, nextButtonDebounced);
debounce debounce2(prevButton,clock50MHz, prevButtonDebounced);

VGA VGA(clock25MHz, vsync, hsync, canDisplayImage, x, y);

reg nextPressed, nextPrev;
reg prevPressed, prevPrev;

always @(posedge clock50MHz)begin
    nextPrev<=nextButtonDebounced;
	 prevPrev<=prevButtonDebounced;
end

always@(*)
    if (nextButtonDebounced&&!nextPrev)
        nextPressed = 1;
    else
        nextPressed = 0;
		  
always@(*)
    if (prevButtonDebounced&&!prevPrev)
        prevPressed = 1;
    else
        prevPressed = 0;
		  
always @(posedge clock50MHz)
begin
	if(nextPressed) begin
		currentMode <= currentMode+1;
		if(currentMode==numberOfModes) currentMode<=1;
	end

	if(prevPressed)begin
		currentMode <= currentMode-1;
		if(currentMode==1) currentMode<=numberOfModes;

	end
end

wire [9:0] red1;
wire[9:0] green1;
wire [9:0] blue1;
tvPattern tvPattern(x,y,red1,green1,blue1);

wire [9:0] red2;
wire[9:0] green2;
wire [9:0] blue2;
fillColorPattern fillColorPattern1(15,15,15,red2,green2,blue2);

wire [9:0] red3;
wire[9:0] green3;
wire [9:0] blue3;
fillColorPattern fillColorPattern2(15,0,0,red3,green3,blue3);

wire [9:0] red4;
wire[9:0] green4;
wire [9:0] blue4;
fillColorPattern fillColorPattern3(0,15,0,red4,green4,blue4);

wire [9:0] red5;
wire[9:0] green5;
wire [9:0] blue5;
fillColorPattern fillColorPattern4(0,0,15,red5,green5,blue5);

wire [9:0] red6;
wire[9:0] green6;
wire [9:0] blue6;
gridPattern gridPattern(x,y,red6,green6,blue6);

wire [9:0] red7;
wire[9:0] green7;
wire [9:0] blue7;
bouncingSquare bouncingSquare(clock25MHz,x,y,red7,green7,blue7);

always @(switches)
begin
	if(canDisplayImage)
	case(switches)
		1:
		begin
			red <= red1;
			green <= green1;
			blue <= blue1;
		end
		2:
		begin
			red <= red2;
			green <= green2;
			blue <= blue2;
		end
		4:
		begin
			red <= red3;
			green <= green3;
			blue <= blue3;
		end
		8:
		begin
			red <= red4;
			green <= green4;
			blue <= blue4;
		end
		16:
		begin
			red <= red5;
			green <= green5;
			blue <= blue5;
		end
		32:
		begin
			red <= red6;
			green <= green6;
			blue <= blue6;
		end
		64:
		begin
			red <= red7;
			green <= green7;
			blue <= blue7;
		end
		default:
		begin
			case(currentMode)
				1:
				begin
					red <= red1;
					green <= green1;
					blue <= blue1;
				end
				2:
				begin
					red <= red2;
					green <= green2;
					blue <= blue2;
				end
				3:
				begin
					red <= red3;
					green <= green3;
					blue <= blue3;
				end
				4:
				begin
					red <= red4;
					green <= green4;
					blue <= blue4;
				end
				5:
				begin
					red <= red5;
					green <= green5;
					blue <= blue5;
				end
				6:
				begin
					red <= red6;
					green <= green6;
					blue <= blue6;
				end
				7:
				begin
					red <= red7;
					green <= green7;
					blue <= blue7;
				end
			endcase
		end
	endcase
	else begin
		red <= 0;
		green <= 0;
		blue <= 0;
	end
end

endmodule

