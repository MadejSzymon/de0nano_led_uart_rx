package pkg;
	
	parameter DATA_BITS = 8;
	parameter STOP_BITS = 1;
	parameter TICK_NBR = 5208; //TICK_NBR = floor(clock_frequency/baud_rate) : floor(25_000_000/9600) = 2604
	
	typedef enum {RX_IDLE,RX_START,RX_DATA,RX_STOP} rx_state;
	
endpackage 