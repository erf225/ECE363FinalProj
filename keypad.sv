// Ethan First & David King
// ECE363 Project
// Semi-final keypad submission code

`timescale 1ns/1ps

module keypad (
	input wire clk, // clock signal
	input wire rst, // reset signal
	input wire [3:0] row, // row input
	input wire is_breach, // detects security sensors or breach
	output reg [3:0] col, // column output
	output reg is_enabled, // determines if the system is enabled or disabled
	output reg led, // LED green if system enabled, red if not
	output reg alert_authorities // alert authorities if breach is detected
);

// password storage (temp/correct)
logic [3:0] input_buf [0:3]; // stores password input -> 0000 {4'b0000, 4'b0000, 4'b0000, 4'b0000}
logic [3:0] correct_passcode [0:3];  // stores correct passcode -> 1865 {4'b0001, 4'b1000, 4'b0110, 4'b0101}

// temp col value for sweeping
logic [3:0] col_counter; // cols to be assigned by 2'b0001, 2'b0010, 2'b0100, 2'b1000 which correlate with 4 cols on the keypad

// counter to track how full input buffer is
logic [2:0] buf_counter;

// decode col_counter
logic [1:0] decode_col;

// stores number of key pressed
logic [3:0] key_input;

// flag if key pressed
logic key_pressed;

// flag to keep state of buffer 
logic buffer_updated; 

// detect if there is security breach
always @(posedge clk or posedge rst) begin
	if (rst) begin
		alert_authorities <= 1'b0; // reset alert authorities flag
	end else begin
		if (is_breach && is_enabled) begin
			alert_authorities <= 1'b1; // toggle alert authorities flag
		end else begin
			alert_authorities <= 1'b0; // reset alert authorities flag
		end
	end
end


// sweep through the cols on ever clock cycle
always @(posedge clk or posedge rst) begin
	if (rst) begin
		col_counter <= 4'b1000; // reset to first col
	end else begin
		col_counter <= {col_counter[0], col_counter[3:1]}; // iterates to next col 
	end
	col <= col_counter; // assign column_counter to col output
end


// decodes the column
always @(posedge clk or posedge rst) begin
	if (rst) begin
		decode_col <= 2'b00; // set decode_col to zero
	end else begin
		// decode the column into 2 bits
		case (col_counter)
			4'b1000: decode_col <= 2'b00; // col 1
			4'b0100: decode_col <= 2'b01; // col 2
			4'b0010: decode_col <= 2'b10; // col 3
			4'b0001: decode_col <= 2'b11; // col 4
			default: decode_col <= 2'bxx; // default case
		endcase
	end
end


// check if a row was selected
always @(posedge clk or posedge rst) begin
	if (rst) begin
		key_pressed <= 1'b0; // set key pressed to zero
                key_input <= 4'b0000; // set key input to zero
	end else if (row != 4'b0000) begin
		key_pressed <= 1'b1; // key pressed
		
		// create the decode button that was pressed
                case (row) 
			4'b1000: key_input <= {2'b00, decode_col};
			4'b0100: key_input <= {2'b01, decode_col};
			4'b0010: key_input <= {2'b10, decode_col};
			4'b0001: key_input <= {2'b11, decode_col};
			default: key_input <= 4'bxxxx;
		endcase
	end else begin
		key_pressed <= 1'b0; // key not pressed yet
		buffer_updated <= 1'b0; // buffer reset
		key_input <= 4'bxxxx; // set key input to null
	end
end

// check if input buf is full and if so check password that was input
always @(posedge clk or posedge rst) begin
	if (rst) begin
		// binary doesn't align with decimal value because it is based on the matrix (eg. digit 8 is row 3 col 3, so row -> 10 col -> 01, hence 1001)
		// assign passcode - 1865
		correct_passcode[0] = 4'b0000; // 1, row (00) col (00)
		correct_passcode[1] = 4'b1001; // 8, row (10) col (01)
		correct_passcode[2] = 4'b0110; // 6, row (01) col (10)
		correct_passcode[3] = 4'b0101; // 5, row (01) col (01)
		buf_counter <= 3'b000; // reset buffer counter
		is_enabled <= 1'b0; // reset access granted 
		led <= 1'b0; // turn LED off
		buffer_updated <= 1'b0;  // reset buffer flag 
	end else if (key_pressed && !buffer_updated) begin // only update buffer if keyapd enabled, key is pressed, and the buffer has yet to be updated
			input_buf[buf_counter] = key_input; // add input key into the full passcode buffer
			buf_counter = buf_counter + 3'b001; // iterate passcode buffer counter
			buffer_updated <= 1'b1; // buffer has been updated

			// check if passcode buffer is full
			// full if 4 keypad presses have been made
			if (buf_counter == 3'b100) begin
				if (correct_passcode[0] == input_buf[0] 
				    && correct_passcode[1] == input_buf[1] 
				    && correct_passcode[2] == input_buf[2] 
				    && correct_passcode[3] == input_buf[3]) begin
					is_enabled <= !is_enabled; // system enabled/disabled (depends on previous state)
					led <= !led; // toggle LDE based on input
				end
				buf_counter = 3'b000; // reset buffer counter
			end
			key_input <= 4'bxxxx; // set key input to null
	end
end

// display changes
	initial begin
		$display("\t\ttime  |  LED  |   reset  |  row  |  column  |   is_enabled   | key input | decode column | key pressed | is_breach | alert authorities");
		$monitor("%d\t  %d\t     %d\t    %b     %b\t     %d\t\t%b\t         %b           %b           %b           %b", $time, led, rst, row, col, is_enabled, key_input, decode_col, key_pressed, is_breach, alert_authorities);
	end


endmodule
