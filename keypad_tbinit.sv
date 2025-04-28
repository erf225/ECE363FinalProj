//Ethan First & David King
//ECE 363 Project
//Keypad testbench
module keypad_tb;
	reg clk_tb, enable_tb, reset_tb; // inputs
	reg [3:0] number_tb; // input
	wire correct_tb; // output

	// connecting ports
	keypad DUT(.clk(clk_tb), .enable(enable_tb), .reset(reset_tb), .number(number_tb), .correct(correct_tb));
	
	// initializing clock
	initial begin
		clk_tb=0;
		forever #20 clk_tb = ~clk_tb;
	end
	
	// test cases
	initial begin
		// toggle reset
		reset_tb = 1; #20; 
		reset_tb = 0; #20;

		// correct code - 1865
		enable_tb = 1;
		number_tb = 4'b0001; #40;
		number_tb = 4'b1000; #40;
		number_tb = 4'b0110; #40;
		number_tb = 4'b0101; #40;
		

		// incorrect on last input - 1864
		number_tb = 4'b0001; #40;
		number_tb = 4'b1000; #40;
		number_tb = 4'b0110; #40;
		number_tb = 4'b0100; #40;
		

		// incorrect on third input - 1875
		number_tb = 4'b0001; #40;
		number_tb = 4'b1000; #40;
		number_tb = 4'b0111; #40;
		number_tb = 4'b0101; #40;
		

		// incorrect on second input - 1965
		number_tb = 4'b0001; #40;
		number_tb = 4'b1001; #40;
		number_tb = 4'b0110; #40;
		number_tb = 4'b0101; #40;
		

		// incorrect on first input - 3865
		number_tb = 4'b0011; #40;
		number_tb = 4'b1000; #40;
		number_tb = 4'b0110; #40;
		number_tb = 4'b0100; #40;
		

		// enable off and correct code - 1865
		enable_tb = 0;
		number_tb = 4'b0001; #40;
		number_tb = 4'b1000; #40;
		number_tb = 4'b0110; #40;
		number_tb = 4'b0101; #40;
		
		// input one additional number to check if 'correct' = 1
		number_tb = 4'b0001; #40;

		$finish;
	end

	initial begin 
		$dumpfile("keypad.vcd");
		$dumpvars;
	end

	initial begin
		$display("\t\ttime  |  enable  |  number  |  correct");
		$monitor("%d\t   %d\t      %d\t  %d", $time, enable_tb, number_tb, correct_tb);
	end

endmodule
