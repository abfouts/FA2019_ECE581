# Fill with your directory path and library 
lappend search_path /home/abfouts/common/Documents/ece581_abfouts_project3/stage2/task1/
set target_library osu05_stdcells.db
set link_library [concat "*" $target_library]


link

read_file -format sverilog wallace.sv
current_design wallace
compile
report_area
report_cell
report_power
write -format Verilog -hierarchy -output wallace.netlist
link
