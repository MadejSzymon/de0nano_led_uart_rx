package pkg;
	
	parameter DATA_BITS = 8;
	parameter STOP_BITS = 1;
	parameter integer CLK_FREQ = 50_000_000;
	parameter integer BAUD_RATE = 9600;
	parameter integer TICK_NBR = CLK_FREQ/BAUD_RATE;
	
	typedef enum {RX_IDLE,RX_START,RX_DATA,RX_STOP} rx_state;
	
endpackage 