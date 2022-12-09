

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
	testLED
	
);
input  clock50MHz;    // Clock signal - 50 MHz
input  [9:0] switches; // switches for chooosing mode
output reg [3:0]  red;
output reg [3:0]  blue;
output reg [3:0] green; 
input nextButton;
input prevButton;
output reg testLED;
output hsync;   
output vsync;  


reg[27:0] my_count;
reg [4:0] currentMode = 1;
reg   flag;
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

reg [30:0] counter = 1'b0;

reg clkout = 0;
wire nextButtonDebounced;
wire prevButtonDebounced;
debounce debounce1(nextButton,clock50MHz, nextButtonDebounced);
debounce debounce2(prevButton,clock50MHz, prevButtonDebounced);
always @(posedge clock25MHz) begin
    counter <= counter + 1;
    if ( counter == 30'd2_000_000)
         begin
          counter <= 0;
                  clkout <= ~clkout;
                end
end
//always @(posedge clkout)
//begin
//testLED = ~testLED;
//end
//reg [30:0] counter;
//reg enable;

//reg [30:0] sec = 0;

//always @ (posedge clock50MHz)
//begin
	// testLED <= (sec>10) ? 1:0;  
	// counter<= counter+1;
  //  if (counter == 30'd50_000_000) begin
	// counter<=0;
     //   sec = sec +1;
   // end
  
//	end

//assign testLED = (sec>10) ? 1 :0;

VGA VGA(clock25MHz, vsync, hsync, canDisplayImage, x, y);

reg nextPressed, nextPrev;
reg prevPressed, prevPrev;
always @(posedge clock50MHz)begin
    nextPrev<=nextButtonDebounced;
	 prevPrev<=prevButtonDebounced;
end
always@(*)
    if (nextButtonDebounced&&!nextPrev) // a is high now, but was low last cycle
        nextPressed = 1;
    else
        nextPressed = 0;
		  
always@(*)
    if (prevButtonDebounced&&!prevPrev) // a is high now, but was low last cycle
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
screenSaverPattern screenSavePattern(clock25MHz,clock50MHz, btn_next, x,y,red7,green7,blue7);

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
else
begin
red <= 0;
green <= 0;
blue <= 0;
end
end

//patterns patterns(canDisplayImage, switches, x,y, red, green, blue);

/*
always @(x|y)
begin
case(switches)
1:
begin
red = red1;
green = green1;
blue = blue1;
end
2:
begin
red = red2;
green = green2;
blue = blue2;
end
endcase
end


case (switches)
10'b0000000001:	
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
10'b0000000010:
	begin 
	//on = (x%2 | y%2);
	red =  4'hF ;
	blue = 0;
	green = 0; 
	end
10'b0000000100:
begin
	red = 0;
	blue = 0;
	green = 4'hF;
	//red = (canDisplayImage) ? 4'hF : 4'h0; 
	//green = 4'h0;
	//blue = 4'h0;
	end
10'b0000001000:
begin
red = 0;
	blue = 4'hF ;
	green = 0;
end
10'b0000010000:
begin
	if(((x-100)*(x-100))+((y-100)*(y-100))<=(100*100))
	begin
		red = 4'hF;
		green = 4'hF;
		blue = 4'hF;
	end
	else
	begin
	red = 0;
	blue = 0;
	green = 0;
	end
	
end

10'b0000100000:
begin
	
end
default:
begin
	red = 0;
	green = 0;
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
*/
endmodule

