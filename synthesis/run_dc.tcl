set PDK_PATH ./../ref

source -echo -verbose ./rm_setup/dc_setup.tcl
source -verbose ./rm_setup/dc_setup.tcl
set RTL_SOURCE_FILES ./input/seq_110.v

define_design_lib WORK -path ./WORK

analyze -format verilog ./input/seq_110.v
elaborate seq_110
current_design

report_area
report_power
report_design
report_cell 
report_qor
report_timing


read_sdc -echo ./CONSTRAINTS/seq_110.sdc
set_clock_uncertainty -setup 0.300 [get_clocks clk]
source -echo -verbose ./rm_setup/dc_setup.tcl
report_timing 

set -path ./WORK

create_clock -period 1 [get_ports clk]

set_input_delay -max 0.5 -clock clk [all_inputs]
set_input_transition 0.5 [all_inputs]

set_output_delay -max 0.5 -clock clk [all_outputs]
compile
set_clock_uncertainty -setup 0.300 [get_clocks clk]
set_clock_uncertainty -hold 0.100 [get_clocks clk]
source -echo -verbose ./rm_setup/dc_setup.tcl
set_max_transition 0.250 [current_design]
set_max_transition -clock_path 0.150 [get_clocks clk]

compile

compile_ultra
report_timing
write -format verilog -hierarchy -output ${RESULTS_DIR}/${DESIGN NAME.mapped.v}
