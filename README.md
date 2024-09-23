# Monitor Testing Using DE10-Lite FPGA Board

This project uses the DE10-Lite FPGA board to test monitors through the VGA interface. The DE10-Lite is ideal for this purpose due to its compact size and built-in VGA connector. The project generates a 25.175 MHz clock required by VGA using the board's 50 MHz clock and the Altera PLL. A simple Verilog-based VGA controller is used to display images, including animated tests like a bouncing square.
## Requirements:
  * DE10-Lite Board (MAX 10 FPGA)
  * Quartus Prime Lite Edition
  * Verilog HDL

## Key Features:

* VGA controller supporting 640x480 @ 60Hz resolution.
* Animated test patterns with buttons and switches for mode selection.
* Debouncing for button input stability.

For a detailed explanation, check out the [original article](https://habr.com/en/articles/707224/).
