set_property PACKAGE_PIN E3 [get_ports {clk}]
create_clock -name sysclk -period 10 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

set_property PACKAGE_PIN H5 [get_ports {led}]
set_property IOSTANDARD LVCMOS33 [get_ports {led}]

set_property PACKAGE_PIN C2 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]
