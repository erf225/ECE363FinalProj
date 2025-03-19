module keypad_test_top;
  keypad_io top_io();
  keypad1_tb test(top_io);
  keypad1 DUT(.clk(clk_tb), .en(en_tb), .rst(rst_tb), .row(row_tb), .col(col_tb), .access_granted(access_granted_tb), .led(led_tb));
endmodule
