puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/ip_servo_avalon.vhd
vcom -93 tb_ip_servo_avalon.vhd

vsim tb_ip_servo_avalon
view signals
add wave -binary /tb_ip_servo_avalon/inst_ip_servo_avalon/clk 
add wave -binary /tb_ip_servo_avalon/inst_ip_servo_avalon/reset_n
add wave -binary /tb_ip_servo_avalon/inst_ip_servo_avalon/chipselect
add wave -binary /tb_ip_servo_avalon/inst_ip_servo_avalon/write_n
add wave -unsigned /tb_ip_servo_avalon/inst_ip_servo_avalon/writedata
add wave -unsigned /tb_ip_servo_avalon/inst_ip_servo_avalon/duty
add wave -binary /tb_ip_servo_avalon/inst_ip_servo_avalon/commande
add wave OK

run -a