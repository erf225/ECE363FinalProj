// Ethan First & David King
// ECE 363 Project
// Semi-final keypad submission testbench code

module keypad1_tb;
	// inputs
	reg clk_tb;
        reg rst_tb;
        reg [3:0] row_tb;
        reg is_breach_tb; 
	
	// outputs
        wire [3:0] col_tb;
        wire is_enabled_tb;
        wire led_tb;
        wire alert_authorities_tb;

	// connecting ports
        keypad1 DUT(.clk(clk_tb), .rst(rst_tb), .row(row_tb), .is_breach(is_breach_tb), .col(col_tb), .is_enabled(is_enabled_tb), .led(led_tb), .alert_authorities(alert_authorities_tb));
	
        // initializing clock
        initial begin
                clk_tb=0;
                forever #5 clk_tb = ~clk_tb;
        end

	initial begin
		// initialize signals
	        rst_tb = 1;
	        row_tb = 4'b0000;
	        is_breach_tb <= 1'b0;
	
	        // end reset
	        #20;
	        rst_tb = 0;

	        // simulate entering correct passcode: "1865"
	        // wait for column 1000 (1st column), then press '1' (row 1000)
	        wait (col_tb == 4'b1000);
	        row_tb = 4'b1000;
		#20;
		row_tb = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '8' (row 0010)
	        wait (col_tb == 4'b0100);
	        row_tb = 4'b0010;
		#20;
                row_tb = 4'b0000;
		#10;

	        // wait for column 0010 (3rd column), then press '6' (row 0100)
	        wait (col_tb == 4'b0010);
	        row_tb = 4'b0100;
		#20;
                row_tb = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '5' (row 0100)
	        wait (col_tb == 4'b0100);
	        row_tb = 4'b0100;
		#20;
                row_tb = 4'b0000;
                #10;
                
                // SYSTEM ENABLED
                
                // toggle breach
                is_breach_tb = 1'b1;
                
                // simulate entering correct passcode: "1865"
	        // wait for column 1000 (1st column), then press '1' (row 1000)
	        wait (col_tb == 4'b1000);
	        row_tb = 4'b1000;
		#20;
		row_tb = 4'b0000;
		#10;
		
		// toggle breach
		is_breach_tb = 1'b0;

	        // wait for column 0100 (2nd column), then press '8' (row 0010)
	        wait (col_tb == 4'b0100);
	        row_tb = 4'b0010;
		#20;
                row_tb = 4'b0000;
		#10;

	        // wait for column 0010 (3rd column), then press '6' (row 0100)
	        wait (col_tb == 4'b0010);
	        row_tb = 4'b0100;
		#20;
                row_tb = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '5' (row 0100)
	        wait (col_tb == 4'b0100);
	        row_tb = 4'b0100;
		#20;
                row_tb = 4'b0000;
                #10;
                
                // simulate entering incorrect passcode: "0000"
	        // wait for column 0100 (2nd column), then press '0' (row 0001)
	        wait (col_tb == 4'b0100);
	        row_tb = 4'b0001;
		#20;
		row_tb = 4'b0000;
		#10;
		
		// toggle breach
		is_breach_tb = 1'b1;

	        // wait for column 0100 (2nd column), then press '0' (row 0001)
	        wait (col_tb == 4'b0100);
	        row_tb = 4'b0001;
		#20;
		row_tb = 4'b0000;
		#10;
		
		// toggle breach
		is_breach_tb = 1'b0;

	        // wait for column 0100 (2nd column), then press '0' (row 0001)
	        wait (col_tb == 4'b0100);
	        row_tb = 4'b0001;
		#20;
		row_tb = 4'b0000;
		#10;

	        // wait for column 0100 (2nd column), then press '0' (row 0001)
	        wait (col_tb == 4'b0100);
	        row_tb = 4'b0001;
		#20;
		row_tb = 4'b0000;
		#10;
	
	        // wait for processing
		#30;

		$finish; // finish test
	end

	// .vcd file creation
        initial begin
                $dumpfile("keypad.vcd");
                $dumpvars;
        end

endmodule
