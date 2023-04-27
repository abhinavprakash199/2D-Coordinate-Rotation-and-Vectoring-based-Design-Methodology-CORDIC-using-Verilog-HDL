
#/Application/Cadence/CadencePDK/TSMC180STCLIB/180/CMOS/G/stclib/7-track/tcb018gbwp7t_290a_FE/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcb018gbwp7t_270a/
 
set_attribute hdl_search_path {/DIG_DESIGN/INTERNS/dic_lab_02/ABHINAV/ROTATING_VECTORING/} 
set_attribute lib_search_path {/DIG_DESIGN/INTERNS/PDK_DIC/}

#set_attribute library {vtvt_tsmc180.lib}
#set_attribute library {uk65lscllmvbbr_120c25_tc.lib u065gioll25mvir_25_tc.lib}

set_attribute library {slow_vdd1v0_basicCells.lib}


# tcb018gbwp7tlt.lib tcb018gbwp7tml.lib tcb018gbwp7ttc.lib tcb018gbwp7twc.lib tcb018gbwp7twcl.lib
#set_attribute library {tcb018g3d3lt.lib tcb018g3d3bc.lib tcb018g3d3tc.lib tcb018g3d3wc.lib tcb018g3d3ml.lib tcb018g3d3wcl.lib}




#set <items> to your project settings and files 

#Set the search paths to the libraries and the HDL filesset_attribute hdl_search_path {<path to hdl files>} 

set myFiles [list ROTATING_VECTORING.v]
set_attribute information_level 7

#optional. Comment this line if you accept blacboxes
#set_attribute hdl_error_on_blackbox true 


#Uncomment one of the next lines for specific files, or all files in a directory
#set myFiles [list <hdl files>]; # 
#set myFiles [glob -directory <path to hdl files> *.v];

set basename ROTATING_VECTORING;
set myClk clk;
#set mynewclk debug_clk;
set myPeriod_ps 1000;
set myInDelay_ns 0.2;
set myOutDelay_ns 0.2;
set runname report;



#RUN AND OUTPUT
#set_attribute auto_ungroup none
#set_attr preserve true
#Analyze and Elaborate the Design File
read_hdl ${myFiles}
elaborate ${basename}

set_top_module  ${basename}

#set_dont_touch crc5check
#create_clock -name clk -period 390.625 -waveform {0 195.3125} [get_ports "clk"]
#create_clock -name debug_clk -period 390.625 -waveform {0 195.3125} [get_ports "debug_clk"]
# Apply Constraints and generate clocks

set clock [define_clock -period ${myPeriod_ps} -name ${myClk} [clock_ports]]	
external_delay -input $myInDelay_ns -clock ${myClk} [find / -port ports_in/*]
external_delay -output $myOutDelay_ns -clock ${myClk} [find / -port ports_out/*]

#set clock [define_clock -period ${myPeriod_ps} -name ${mynewclk} [clock_ports]]	
#external_delay -input $myInDelay_ns -clock ${mynewclk} [find / -port ports_in/*]
#external_delay -output $myOutDelay_ns -clock ${mynewclk} [find / -port ports_out/*]

# check that the design is OK so far
check_design -unresolved
report timing -lint
# Synthesize the design to the target library
synthesize -to_mapped -effort medium

# Write out the reports
report timing > genus_reports/${basename}_${runname}_timing.rep
report gates  > genus_reports/${basename}_${runname}_cell.rep
report power  > genus_reports/${basename}_${runname}_power.rep

# Write out the structural Verilog and sdc files
write_hdl -mapped >  netlist/${basename}_${runname}.v
write_sdc >  sdc/${basename}_${runname}.sdc

# show result
gui_raise
