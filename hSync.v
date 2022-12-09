module hSync(
input clock25MHz,
output reg hsync,
output reg isHorizontalActive,
output reg [9:0] x
);
parameter
	syncPulse = 10'd96,
	backPorch = 10'd48,
	active = 10'd640,
	frontPorch = 10'd16,
	syncStart = active+frontPorch,
	syncEnd = syncStart+syncPulse,
	dataStart = syncPulse+ backPorch,
	dataEnd = dataStart + active;


localparam maxCount = syncPulse+backPorch+active+frontPorch;

reg [9:0] counter = 0; // 9 bits (max value is 480)
always @(posedge clock25MHz) begin
    if (counter >= maxCount - 1)
        counter <= 0;
    else
        counter <= counter + 10'd1;
	hsync <= ~(counter >= syncStart & counter<syncEnd);
   x	<= counter;
   isHorizontalActive <= (counter<active);
end


endmodule