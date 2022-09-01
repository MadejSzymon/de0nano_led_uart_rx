clear 
COM = 'COM5';
baud_rate = 9600;
data_type = "uint8";
data = 100;

device = serialport(COM,baud_rate);
write(device,data,data_type)
fopen(device);