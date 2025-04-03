// Ethan First & David King
// ECE 363 Project
// Semi-final keypad submission testbench code

`timescale 1ns/1ps

program keypad_test(keypad_io.TB keypad_io);

	// start tests
	initial begin
		// initialize signals
	        keypad_io.rst = 1;
	        keypad_io.row = 4'b0000;
	        keypad_io.door_movement_detected <= 1'b0;
	        keypad_io.facility_movement_detected <= 1'b0;
	
	        // end reset
	        #20;
	        keypad_io.rst = 0;

	        // simulate entering correct passcode: "1865"
	        // wait for column 1000 (1st column), then press '1' (row 1000)
	        wait (keypad_io.col == 4'b1000);
	        keypad_io.row = 4'b1000;
		#20;
		keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '8' (row 0010)
	        wait (keypad_io.col == 4'b0100);
	        keypad_io.row = 4'b0010;
		#20;
                keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0010 (3rd column), then press '6' (row 0100)
	        wait (keypad_io.col == 4'b0010);
	        keypad_io.row = 4'b0100;
		#20;
                keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '5' (row 0100)
	        wait (keypad_io.col == 4'b0100);
	        keypad_io.row = 4'b0100;
		#20;
                keypad_io.row = 4'b0000;
                #10;
                
                // SYSTEM ENABLED
                
                // simulate entering incorrect passcode: "1234"
	        // wait for column 1000 (1st column), then press '1' (row 1000)
	        wait (keypad_io.col == 4'b1000);
	        keypad_io.row = 4'b1000;
		#20;
		keypad_io.row = 4'b0000;
		#10;
		
		// toggle breach
                keypad_io.door_movement_detected = 1'b1;
		
	        // wait for column 0100 (2nd column), then press '2' (row 1000)
	        wait (keypad_io.col == 4'b0100);
	        keypad_io.row = 4'b1000;
		#20;
		keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0010 (3r column), then press '3' (row 1000)
	        wait (keypad_io.col == 4'b0010);
	        keypad_io.row = 4'b1000;
		#20;
		keypad_io.row = 4'b0000;
		#10;
		
		// toggle breach
		keypad_io.door_movement_detected = 1'b0;

	        // wait for column 1000 (1st column), then press '4' (row 0100)
	        wait (keypad_io.col == 4'b1000);
	        keypad_io.row = 4'b0100;
		#20;
		keypad_io.row = 4'b0000;
		#10;
		
		// ACCESS DENIED
                
                // simulate entering correct passcode: "1865"
	        // wait for column 1000 (1st column), then press '1' (row 1000)
	        wait (keypad_io.col == 4'b1000);
	        keypad_io.row = 4'b1000;
		#20;
		keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '8' (row 0010)
	        wait (keypad_io.col == 4'b0100);
	        keypad_io.row = 4'b0010;
		#20;
                keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0010 (3rd column), then press '6' (row 0100)
	        wait (keypad_io.col == 4'b0010);
	        keypad_io.row = 4'b0100;
		#20;
                keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '5' (row 0100)
	        wait (keypad_io.col == 4'b0100);
	        keypad_io.row = 4'b0100;
		#20;
                keypad_io.row = 4'b0000;
                #10;
                
                // SYSTEM DISABLED
		
		// simulate entering incorrect passcode: "5678"
	        // wait for column 0100 (2nd column), then press '5' (row 0100)
	        wait (keypad_io.col == 4'b0100);
	        keypad_io.row = 4'b0100;
		#20;
		keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0010 (3rd column), then press '6' (row 0100)
	        wait (keypad_io.col == 4'b0100);
	        keypad_io.row = 4'b0001;
		#20;
		keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '7' (row 0010)
	        wait (keypad_io.col == 4'b1000);
	        keypad_io.row = 4'b0010;
		#20;
		keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '8' (row 0001)
	        wait (keypad_io.col == 4'b0100);
	        keypad_io.row = 4'b0010;
		#20;
		keypad_io.row = 4'b0000;
		#10;
		
		// ACCESS DENIED
		
		// simulate entering incorrect passcode: "9*0#"
	        // wait for column 0010 (3rd column), then press '9' (row 0010)
	        wait (keypad_io.col == 4'b0010);
	        keypad_io.row = 4'b0010;
		#20;
		keypad_io.row = 4'b0000;
		#10;
		
		// toggle breach
		keypad_io.facility_movement_detected = 1'b1;
		
		// BREACH NOT DETECTED

	        // wait for column 1000 (1st column), then press '*' (row 0001)
	        wait (keypad_io.col == 4'b1000);
	        keypad_io.row = 4'b0001;
		#20;
		keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '0' (row 0001)
	        wait (keypad_io.col == 4'b0100);
	        keypad_io.row = 4'b0001;
		#20;
		keypad_io.row = 4'b0000;
		#10;
		
		// toggle breach
		keypad_io.facility_movement_detected = 1'b0;
		
		// BREACH NOT DETECTED

	        // wait for column 0010 (3rd column), then press '#' (row 0001)
	        wait (keypad_io.col == 4'b0010);
	        keypad_io.row = 4'b0001;
		#20;
		keypad_io.row = 4'b0000;
		#10;
		
		// ACCESS DENIED
	
		// simulate entering incorrect passcode: "ABCD"
	        // wait for column 0001 (4th column), then press 'A' (row 1000)
	        wait (keypad_io.col == 4'b0001);
	        keypad_io.row = 4'b1000;
		#20;
		keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0001 (4th column), then press 'B' (row 0100)
	        wait (keypad_io.col == 4'b0001);
	        keypad_io.row = 4'b0100;
		#20;
		keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0001 (4th column), then press 'C' (row 0010)
	        wait (keypad_io.col == 4'b0001);
	        keypad_io.row = 4'b0010;
		#20;
		keypad_io.row = 4'b0000;
		#10;

	        // wait for column 0001 (4th column), then press 'D' (row 0001)
	        wait (keypad_io.col == 4'b0001);
	        keypad_io.row = 4'b0001;
		#20;
		keypad_io.row = 4'b0000;
		#10;
		
		// ACCESS DENIED
	
	        // wait for processing
		#30;

		$finish; // finish test
	end

	// .vcd file creation
        initial begin
                $dumpfile("keypad.vcd");
                $dumpvars;
        end
        

endprogram
