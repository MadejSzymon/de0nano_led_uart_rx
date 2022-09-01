import pkg::*;
module top(i_board_clk, i_data_rx, o_led);
	
	input i_board_clk;
	input i_data_rx;
	
	output [DATA_BITS-1:0] o_led;
	
	logic [DATA_BITS-1:0] w_data_rx;
	logic w_ready_rx;
	
	uart_rx uart_rx (
	.i_clk(i_board_clk),
	.i_data_rx(i_data_rx),
	.i_enb_rx(1'b1),
	.o_data_rx(w_data_rx),
	.o_ready_rx(w_ready_rx)
	);
	
	led_controller led_controller(
	.i_clk(i_board_clk),
	.i_ready_rx(w_ready_rx),
	.i_data_rx(w_data_rx),
	.o_led(o_led)
	);
	
endmodule 