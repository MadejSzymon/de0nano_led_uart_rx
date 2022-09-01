import pkg::*;

module uart_rx 
(i_clk, i_data_rx, i_enb_rx,
o_data_rx, o_ready_rx);
	
	input i_clk;
	input i_data_rx;
	input i_enb_rx;
	
	output logic [DATA_BITS-1:0] o_data_rx;
	output o_ready_rx;
//-------------------------------------------------------
	logic [$clog2(TICK_NBR)-1:0] ticks_count_rx;
	logic [$clog2(DATA_BITS+2)-1:0] bits_count_rx;
	rx_state state_rx;
	rx_state next_rx;
//-------------------------------------------------------	
	
	
	initial begin
		state_rx <= RX_IDLE;
		ticks_count_rx <= 0;
		bits_count_rx <= 0;
	end
	
	assign o_ready_rx = (state_rx == RX_STOP) ? 1'b1 : 1'b0;
	
	always@(*) begin
		case(state_rx)
		RX_IDLE:begin
			if(i_enb_rx && !i_data_rx)
				next_rx = RX_START;
			else
				next_rx = RX_IDLE;
		end
		RX_START: begin
			if(ticks_count_rx == TICK_NBR-1)
				next_rx = RX_DATA;
			else
				next_rx = RX_START;
		end
		RX_DATA: begin
			if(bits_count_rx == DATA_BITS)
				next_rx = RX_STOP;
			else
				next_rx = RX_DATA;
		end
		RX_STOP: begin
			if(bits_count_rx == DATA_BITS + STOP_BITS)
				next_rx = RX_IDLE;
			else
				next_rx = RX_STOP;
		end
		endcase
	end
	
	always @(posedge i_clk) begin
		state_rx <= next_rx;
	end
	
	always @(posedge i_clk) begin
		case (state_rx)
			RX_IDLE:
			begin
				ticks_count_rx <= 0;
				bits_count_rx <= 0;
			end
			
			RX_START:
			begin
				if (ticks_count_rx == TICK_NBR-1)
					ticks_count_rx <= 0;
				else
					ticks_count_rx <= ticks_count_rx + 1'b1;
			end
			
			RX_DATA:
			begin
				if (ticks_count_rx == TICK_NBR-1) begin
					bits_count_rx <= bits_count_rx + 1'b1;
					ticks_count_rx <= 0;
				end
				else begin
					ticks_count_rx <= ticks_count_rx + 1'b1;
				end
				
				if (ticks_count_rx == TICK_NBR/2 + 1) begin
					o_data_rx[0] <= i_data_rx;
				end
				
				if (ticks_count_rx == TICK_NBR/2) begin
					o_data_rx <= o_data_rx << 1;
				end
				
			end
			
			RX_STOP:
			begin
				if (ticks_count_rx == TICK_NBR-1) begin
					bits_count_rx <= bits_count_rx + 1'b1;
					ticks_count_rx <= 0;
				end
				else begin
					ticks_count_rx <= ticks_count_rx + 1'b1;
				end
				
			end
			
			
		endcase
	end
	
endmodule 