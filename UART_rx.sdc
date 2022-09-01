create_clock -name i_board_clk -period 20.000 [get_ports {i_board_clk}]
derive_clock_uncertainty


set_false_path -from [get_ports {i_data_rx}]
set_false_path -to [get_ports {o_led[*]}]