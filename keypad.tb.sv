// Ethan First & David King
// ECE 363 Project
// Semi-final keypad submission testbench code

program keypad1_tb(keypad_io.TB keypad);
	initial begin
		// initialize signals
	        keypad.rst = 1;
	        keypad.en = 1;
	        keypad.row = 4'b0000;
	
	        // end reset
	        #20;
	        keypad.rst = 0;

	        // simulate entering correct passcode: "1865"
	        // wait for column 1000 (1st column), then press '1' (row 1000)
	        wait (keypad.col == 4'b1000);
	        keypad.row = 4'b1000;
		#20;
		keypad.row = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '8' (row 0010)
	        wait (keypad.col == 4'b0100);
	        keypad.row = 4'b0010;
		#20;
                keypad.row = 4'b0000;
		#10;

	        // wait for column 0010 (3rd column), then press '6' (row 0100)
	        wait (keypad.col == 4'b0010);
	        keypad.row = 4'b0100;
		#20;
                keypad.row = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '5' (row 0100)
		wait (keypad.col == 4'b0100);
	        keypad.row = 4'b0100;
		#20;
                keypad.row = 4'b0000;
	
	        // wait for processing
		#30;

		$finish; // finish test
	end

	// .vcd file creation
        initial begin
                $dumpfile("keypad1.vcd");
                $dumpvars;
        end

endprogram
