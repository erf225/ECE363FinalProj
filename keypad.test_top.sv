module keypad_test_top;
  
  parameter sim_cycle=200;
	reg sys_clock;
  
  keypad_io top_io(sys_clock);
  keypad1_tb test(top_io);
  keypad1 DUT(.clk(top_io.clk), .en(top_io.en), .rst(top_io.rst), .row(top_io.row), .col(top_io.col), .access_granted(top_io.access_granted), .led(top_io.led));

  initial begin
		sys_clock=0;
		forever begin
			#(sim_cycle/2)
				sys_clock=~sys_clock;
		end
	end
  
endmodule
