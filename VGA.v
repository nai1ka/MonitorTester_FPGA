module VGA(
input clock25MHz,
output vsync,
output hsync,
output canDisplayImage,
output reg[9:0] x,
output reg[9:0] y
);
reg [9:0] xCounter;
reg [9:0] yCounter;
 always @(posedge clock25MHz)  // horizontal counter
	begin 
		if (xCounter < 799)
			xCounter <= xCounter + 1;
		else
			xCounter <= 0;              
	end  
	
	always @ (posedge clock25MHz)  // vertical counter
		begin 
			if (xCounter == 799)  // only counts up 1 count after horizontal finishes 800 counts
				begin
					if (yCounter < 525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
						yCounter <= yCounter + 1;
					else
						yCounter <= 0;              
				end  
		end
			
	always @ (posedge clock25MHz)
	begin	
		if(xCounter>=144 && xCounter<784) x=xCounter-144;
		else x = 0;
		if(yCounter>=35 && yCounter < 515) y = yCounter-35;
		else y = 0;
	end

	assign hsync = (xCounter >= 0 && xCounter < 96) ? 1:0;  // hsync high for 96 counts                                                 
	assign vsync = (yCounter >= 0 && yCounter < 2) ? 1:0;   // vsync high for 2 counts
	assign canDisplayImage = ((xCounter > 144) && (xCounter <= 783))
     && ((yCounter > 35) && (yCounter <= 514));

endmodule