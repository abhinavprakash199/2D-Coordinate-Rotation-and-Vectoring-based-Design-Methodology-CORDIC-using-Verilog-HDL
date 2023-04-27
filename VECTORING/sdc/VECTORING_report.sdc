# ####################################################################

#  Created by Genus(TM) Synthesis Solution 20.10-p001_1 on Thu Apr 27 18:55:21 IST 2023

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design VECTORING

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
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[10]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[11]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[12]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[13]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[14]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {R[15]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[10]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[11]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[12]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[13]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[14]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0002 [get_ports {theta[15]}]
set_wire_load_mode "enclosed"
