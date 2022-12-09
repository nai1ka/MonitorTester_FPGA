module gridPattern(
input [9:0] x,
input [9:0] y,
output reg [3:0] red,
output reg [3:0] green,
output reg [3:0] blue
);

always @(x||y)
begin

red <= (x%2==0 || y%2==0) ? 4'hF : 0;
green <= (x%2==0 || y&2==0) ? 4'hF : 0;
blue <= (x%2==0 || y%2==0) ? 4'hF : 0;
end


endmodule