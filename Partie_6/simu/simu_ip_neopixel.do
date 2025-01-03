puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/ip_neopixel.vhd
vcom -93 tb_ip_neopixel.vhd

vsim tb_ip_neopixel
view signals
add wave -binary /tb_ip_neopixel/Inst_ip_neopixel/clk
add wave -binary /tb_ip_neopixel/Inst_ip_neopixel/reset_n 
add wave -decimal /tb_ip_neopixel/Inst_ip_neopixel/num_leds
add wave -decimal /tb_ip_neopixel/Inst_ip_neopixel/led_index
add wave -hexadecimal /tb_ip_neopixel/Inst_ip_neopixel/couleur_index
add wave -binary /tb_ip_neopixel/Inst_ip_neopixel/OUT_WS
add wave /tb_ip_neopixel/Inst_ip_neopixel/state  
add wave OK

run -a