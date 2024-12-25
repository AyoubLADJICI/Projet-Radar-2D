puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/telemetre_us_avalon.vhd
vcom -93 tb_telemetre_us_avalon.vhd

vsim tb_telemetre_us_avalon
view signals
add wave -binary /tb_telemetre_us_avalon/inst_telemetre_us_avalon/clk
add wave -binary /tb_telemetre_us_avalon/inst_telemetre_us_avalon/rst_n
add wave -binary /tb_telemetre_us_avalon/inst_telemetre_us_avalon/trig
add wave -binary /tb_telemetre_us_avalon/inst_telemetre_us_avalon/echo
add wave -binary /tb_telemetre_us_avalon/inst_telemetre_us_avalon/read_n
add wave -binary /tb_telemetre_us_avalon/inst_telemetre_us_avalon/chipselect
add wave -decimal /tb_telemetre_us_avalon/inst_telemetre_us_avalon/cnt_echo_ticks
add wave -decimal /tb_telemetre_us_avalon/inst_telemetre_us_avalon/dist_cm
add wave -decimal /tb_telemetre_us_avalon/inst_telemetre_us_avalon/readdata
add wave /tb_telemetre_us_avalon/inst_telemetre_us_avalon/state 
add wave OK

run -a