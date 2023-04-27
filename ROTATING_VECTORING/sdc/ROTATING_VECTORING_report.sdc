# ####################################################################

#  Created by Genus(TM) Synthesis Solution 20.10-p001_1 on Thu Apr 27 18:22:52 IST 2023

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design ROTATING_VECTORING

create_clock -name "clk" -period 1.0 -waveform {0.0 0.5} [get_ports clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[8]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[9]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[10]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[11]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[12]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[13]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[14]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yi[15]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[8]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[9]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[10]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[11]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[12]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[13]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[14]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xi[15]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports clk]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[10]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[11]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[12]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[13]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[14]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {yf[15]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[10]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[11]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[12]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[13]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[14]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {xf[15]}]
set_wire_load_mode "enclosed"
