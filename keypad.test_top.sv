// Ethan First & David King 
// Project semi-final submission
// Matrix keypad harness

`timescale 1ns/1ps

module keypad_top;
	parameter sim_cycle=10;
	reg sys_clk;

	keypad_io top_io(sys_clk); //connect to top io
	keypad_test test(top_io); //connect top io to test module
	//setup test module and connect to keypad DUT
	keypad  DUT(.clk(top_io.clk), .rst(top_io.rst), .facility_movement_detected(top_io.facility_movement_detected), .door_movement_detected(top_io.door_movement_detected), .row(top_io.row), .is_enabled(top_io.is_enabled), .led(top_io.led), .alert_authorities(top_io.alert_authorities), .col(top_io.col));

	//system clk
	initial begin
		sys_clk=0;
		forever begin
			//toggle clock every half period
			#(sim_cycle/2) 
			sys_clk=~sys_clk;
		end
	end

endmodule
