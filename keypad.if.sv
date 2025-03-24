// Ethan First & David King 
// Project semi-final submission
// Matrix keypad interface

`timescale 1ns/1ps

interface keypad_io(input logic clk);
	logic rst, facility_movement_detected, door_movement_detected; // input
	logic [3:0] row; // input
	
	logic is_enabled, led, alert_authorities; //output
	logic [3:0] col; // output
	
	//set up clock
	clocking cb@(posedge clk);
		default input #1 output #0;
		input is_enabled, led, alert_authorities, col;
		output rst, facility_movement_detected, door_movement_detected, row;
	endclocking 

	//pick the default 
	default clocking cb;

	//interfacing control
	//with respect to the TB
	modport TB(clocking cb, output rst, output door_movement_detected, output facility_movement_detected, output row, input is_enabled, input led, input alert_authorities, input col);
endinterface 
