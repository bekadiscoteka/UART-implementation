vlib work
vlog -work work uart_tb.v
vsim work.stimulus
add wave -r sim:/stimulus/*
run -all
