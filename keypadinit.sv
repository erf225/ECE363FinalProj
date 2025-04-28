// Ethan First & David King
// ECE363 Project
// Initial submission code

module keypad(
	input wire clk,
	input wire enable,
	input wire reset, 
	input wire [3:0] number, 
	output reg correct
	);
	// correct pass: 1865

	reg [3:0] ps, ns; // track present and next state
	parameter S0=4'b0000, S1=4'b0001, S2=4'b0010, S3=4'b0011, S4=4'b0100, S5=4'b0101, S6=4'b0110, S7=4'b0111, S8=4'b1000; // FSM states
	
	// update present state on clock edge
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			ps <= S0;
		end
		else if (enable) begin
			ps <= ns;
		end
	end
			
	// update state one each clock edge
	always @(number) begin
		if (enable) begin
			case(ps)
				S0: begin correct = 0; if(number == 4'b0001) ns = S1; else ns = S5; end
				S1: begin if(number == 4'b1000) ns = S2; else ns = S6; end
				S2: begin if(number == 4'b0110) ns = S3; else ns = S7; end
				S3: begin if(number == 4'b0101) ns = S4; else ns = S8; end
				S4: begin ns = S0; correct = 1; end
				S5: ns = S6;
				S6: ns = S7;
				S7: ns = S8;
				S8: ns = S0;
				default: ns=S0;
			endcase
		end
	end

	// on present state change check to see if the passcode is correct
//	always @(posedge clk) begin
//		if (ps == S4 && ns == S0) begin
//			correct <= 1;
//		end
//		else begin
//			correct <= 0;
//		end
//	end


endmodule
