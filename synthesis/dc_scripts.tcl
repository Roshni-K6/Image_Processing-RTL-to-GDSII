# PATH SETUP
set project_path ../
set search_path [list . $project_path/input \
    /home/ams22/synopsys/x/SAED32_EDK/lib/stdcell_lvt/db_nldm \
    /home/ams22/synopsys/x/SAED32_EDK/lib/stdcell_hvt/db_nldm \
    /home/ams22/synopsys/x/SAED32_EDK/lib/stdcell_rvt/db_nldm ]

set_app_var link_library "* saed32lvt_ss0p75vn40c.db \
                             saed32hvt_ss0p75vn40c.db \
                             saed32rvt_ss0p75vn40c.db"

set_app_var target_library "saed32rvt_ss0p75vn40c.db"

# READ RTL (MULTIPLE FILES)
read_file -rtl -format verilog ../input/grayscale.v
read_file -rtl -format verilog ../input/operation.v
read_file -rtl -format verilog ../input/top.v

current_design top
link

analyze -format verilog ../input/grayscale.v
analyze -format verilog ../input/operation.v
analyze -format verilog ../input/top.v

elaborate top
link

# INTERMEDIATE WRITE (RTL)
write_file -format verilog -output ../output/top.vs

# CHECK DESIGN
check_design
check_timing

# SYNTHESIS
compile

# WRITE NETLIST
write_file -format verilog -output ../output/top.vg

# CLOCK DEFINITIONS
create_clock -name clk -period 0.5 [get_ports clk]
report_clock

set_clock_latency 0.4 [get_clocks clk]
set_clock_uncertainty 0.1 [get_clocks clk]

# IO CONSTRAINTS
set_input_delay 1.0 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 0.5 -clock clk [all_outputs]

set_input_delay 0.1 -clock clk -min [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay -0.1 -clock clk -min [all_outputs]

report_port -verbose

# ENVIRONMENT
set_load 25 [all_outputs]
set_input_transition 0.3 [all_inputs]

set_max_transition 0.250 -clock [get_clocks clk]
set_max_transition 0.500 [current_design]

report_port -verbose

# TIMING CHECK
check_timing

# SAVE CONSTRAINTS
write_sdc ../output/top.sdc
compile_ultra

# FINAL OUTPUTS
write_file -format verilog -output ../output/top_final.v
write_sdc ../output/top.sdc
write -f ddc -hierarchy -output ../output/top.ddc

# REPORTS
report_timing
report_constraint -all_violators
report_area
report_power
report_qor

# TIMING ANALYSIS
set_false_path -to [all_outputs]
set_false_path -from [all_inputs]

report_timing
report_timing -max_paths 10 -slack_lesser_than 0
report_timing -max_paths 10 -delay_type min -slack_lesser_than 0

# INCREMENTAL OPTIMIZATION
compile_ultra -incremental
exit
