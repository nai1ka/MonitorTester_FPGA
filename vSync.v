module vSync(
input clock25MHz,
output reg vsync,
output reg isVerticalActive,
output reg [9:0] y
);
parameter
	vFrontPorch = 10'd10,
	vBackPorch = 10'd33,
	vSyncPulse = 10'd2,
	vSyncActive = 10'd480,
	syncStart = vSyncActive + vFrontPorch,
	syncEnd = syncStart+vSyncPulse,
	dataStart = vSyncPulse+ vBackPorch,
	dataEnd = dataStart + vSyncActive;

localparam maxCount = vFrontPorch+vBackPorch+vSyncPulse+vSyncActive;

reg [9:0] counter = 0; // 9 bits (max value is 512)
always @(posedge clock25MHz) begin
    if (counter >= maxCount - 1)
        counter <= 0;
    else
        counter <= counter + 10'd1;
    
	 vsync <= ~(counter >= syncStart & counter <= syncEnd);
    y     <= counter;
    isVerticalActive  <= (counter < vSyncActive);
end


endmodule