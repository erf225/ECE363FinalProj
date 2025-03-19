interface keypad_io(input logic clk);
  logic en, rst, access_granted, led;
  logic [3:0] row, col;
  clocking cb@(posedge clk);
		default input #1 output #0;
		output rst;
	endclocking
	
	default clocking cb;
    modport TB(clocking cb, output en, output rst, output row, output col, input access_granted, input led);
endinterface
