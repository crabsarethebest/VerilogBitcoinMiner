set_property PACKAGE_PIN E3 [get_ports {sys_clk}]
create_clock -name sysclk -period 10 [get_ports {sys_clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {sys_clk}]

set_property PACKAGE_PIN H5 [get_ports {led_0}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_0}]

set_property PACKAGE_PIN C2 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]