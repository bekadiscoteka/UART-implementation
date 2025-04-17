vlib work
vlog -work work bin2bcd_tb.v
vsim work.stimulus
add wave -r sim:/stimulus/* 
run -all
