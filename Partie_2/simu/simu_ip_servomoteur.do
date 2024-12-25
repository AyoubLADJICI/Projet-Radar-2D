puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/ip_servomoteur.vhd
vcom -93 tb_ip_servomoteur.vhd

vsim tb_ip_servomoteur
view signals
add wave -binary /tb_ip_servomoteur/inst_ip_servomoteur/clk 
add wave -binary /tb_ip_servomoteur/inst_ip_servomoteur/reset_n
add wave -unsigned /tb_ip_servomoteur/inst_ip_servomoteur/position
add wave -binary /tb_ip_servomoteur/inst_ip_servomoteur/commande
add wave -unsigned /tb_ip_servomoteur/inst_ip_servomoteur/duty
add wave OK

run -a