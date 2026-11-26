# Bank 34 is HP (RIOB18) on xc7z030fbg676. Pad B5 is IOB_X1Y110, paired with
# RIOI_X79Y109.OLOGIC_Y0. Clock input G7 is also on bank 34 (LVCMOS18).
set_property PACKAGE_PIN G7 [get_ports clk_in]
set_property IOSTANDARD LVCMOS18 [get_ports clk_in]
set_property PACKAGE_PIN B5 [get_ports io]
set_property IOSTANDARD LVCMOS18 [get_ports io]
create_clock -period 25.000 -name clk_in [get_ports clk_in]
