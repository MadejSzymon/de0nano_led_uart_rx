import pkg::*;
module led_controller(i_clk, i_ready_rx, i_data_rx, o_led);
	
	input i_clk;
	input i_ready_rx;
	input [DATA_BITS-1:0] i_data_rx;
	
	output logic [DATA_BITS-1:0] o_led;
	
	initial 
		o_led <= 0;
		
	always@(posedge i_clk) begin
		if(i_ready_rx)
			o_led <= i_data_rx;
	end
	
	
endmodule 