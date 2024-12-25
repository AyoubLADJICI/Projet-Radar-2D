puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/ip_telemetre.vhd
vcom -93 tb_ip_telemetre.vhd

vsim tb_ip_telemetre
view signals
add wave -binary /tb_ip_telemetre/Inst_IP_Telemetre/clk
add wave -binary /tb_ip_telemetre/Inst_IP_Telemetre/rst_n
add wave -binary /tb_ip_telemetre/Inst_IP_Telemetre/echo
add wave -binary /tb_ip_telemetre/Inst_IP_Telemetre/trig
add wave -decimal /tb_ip_telemetre/Inst_IP_Telemetre/dist_cm
add wave -decimal /tb_ip_telemetre/Inst_IP_Telemetre/cnt_echo_ticks
add wave /tb_ip_telemetre/Inst_IP_Telemetre/state  
add wave OK

run -a