## Run Script



read_verilog MY_DESIGN.v
current_design MY_DESIGN 
link
check_design

#write your timing constraints here


check_timing
report_clock


write_script -out my_design.wscr

write -format ddc -hier -out unmapped_design.ddc
exit
