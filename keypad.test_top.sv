module keypad_test_top;
  keypad_io top_io();
  keypad1_tb test(top_io);
  keypad1 DUT(.clk(top_io.clk), .en(top_io.en), .rst(top_io.rst), .row(top_io.row), .col(top_io.col), .access_granted(top_io.access_granted), .led(top_io.led));
endmodule
