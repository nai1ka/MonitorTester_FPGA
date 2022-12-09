module fillColorPattern(
input [3:0] redLevel,
input [3:0] greenLevel,
input [3:0] blueLevel,
output [3:0] red,
output [3:0] green,
output [3:0] blue);

assign red = redLevel;
assign green =  greenLevel;
assign blue =  blueLevel;

endmodule