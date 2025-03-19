// Ethan First & David King
// ECE363 Project
// Semi-final keypad submission code

module keypad1 (
	input wire clk, // clock signal
	input en, // enable signal
	input wire rst, // reset signal
	input wire [3:0] row, // row input
	output reg [3:0] col, // column output
	output reg access_granted, // determines if password is correct/incorrect
	output reg led // LED green if access granted, red if not
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

// check enable and led
always @(posedge clk or posedge rst) begin
	if (rst) begin
		led <= 1'b0; // turn off led
	end else if (en) begin
		led <= 1'b1; // turn on led
	end else begin
		led <= 1'b0; // turn off led
	end
end


// sweep through the cols on ever clock cycle
always @(posedge clk or posedge rst) begin
	if (rst) begin
		col_counter <= 4'b1000; // reset to first col
	end else if (en) begin
		col_counter <= {col_counter[0], col_counter[3:1]}; // iterates to next col 
	end
	col <= col_counter; // assign column_counter to col output
end


// decode the current column into its two bit represenation 
always @(posedge clk or posedge rst) begin
	if (rst) begin
		decode_col <= 2'b00; // set decode_col to zero
	end else if (en) begin
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
	end else if (en && (row != 4'b0000)) begin
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
		access_granted <= 1'b0; // reset access granted
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
		access_granted <= 1'b0; // reset access granted 
		buffer_updated <= 1'b0;  // reset buffer flag
	end else if (en && key_pressed && !buffer_updated) begin // only update buffer if keyapd enabled, key is pressed, and the buffer has yet to be updated
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
					access_granted <= 1'b1; // access granted
				end else begin
					access_granted <= 1'b0;	// access not granted
				end
				buf_counter = 3'b000; // reset buffer counter
			end
	end
end

// display changes
initial begin
        $display("\t\ttime  |  enable  |  LED  |   reset  |  row  |  column  |   acccess granted   | key input | decode column | key pressed");
        $monitor("%d\t   %d\t     %d\t       %d       %b\t%b\t          %d\t\t  %b\t          %b         %b", $time, en, led, rst, row, col, access_granted, key_input, decode_col, key_pressed);
end


endmodule
