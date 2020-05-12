# Fill with your directory path and library 
lappend search_path /home/abfouts/common/Documents/ece581_abfouts_project3/stage1/tutorial/
set target_library osu05_stdcells.db
set link_library [concat "*" $target_library]


link

read_file -format sverilog gray_adder.sv
current_design gray_adder
compile
report_area
report_cell
report_power
write -format Verilog -hierarchy -output gray_adder.netlist
link
