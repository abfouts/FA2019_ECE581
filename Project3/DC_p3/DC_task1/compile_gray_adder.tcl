# Fill with your directory path and library 
lappend search_path "your file directory path"
set target_library "target library"
set link_library "link Library"


link

read_file -format sverilog gray_adder.sv
current_design gray_adder
compile
report_area
report_cell
report_power
write -format Verilog -hierarchy -output gray_adder.netlist
link
