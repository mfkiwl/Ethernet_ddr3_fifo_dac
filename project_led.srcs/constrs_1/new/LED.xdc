#
# Global config bank properties
#
set_property CFGBVS VCCO            [current_design]
set_property CONFIG_VOLTAGE 3.3     [current_design]

set_property PACKAGE_PIN E6         [get_ports led_1]
set_property IOSTANDARD LVCMOS33    [get_ports led_1]

set_property PACKAGE_PIN N11        [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33    [get_ports sys_clk]

set_property PACKAGE_PIN K5         [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS33    [get_ports sys_rst_n]


#Header U8
############################################################################
# Ethernet pins                                                            #
############################################################################
set_property PACKAGE_PIN L13        [get_ports PHY_RESET_N]
set_property IOSTANDARD LVCMOS33    [get_ports PHY_RESET_N]

set_property PACKAGE_PIN T9         [get_ports PHY_MDC]
set_property IOSTANDARD LVCMOS33    [get_ports PHY_MDC]

set_property PACKAGE_PIN R10        [get_ports PHY_MDIO]
set_property IOSTANDARD LVCMOS33    [get_ports PHY_MDIO]

set_property PACKAGE_PIN R13        [get_ports PHY_GTXC]
set_property IOSTANDARD LVCMOS33    [get_ports PHY_GTXC]

set_property PACKAGE_PIN   M12      [get_ports PHY_RXDV]
set_property IOSTANDARD LVCMOS33    [get_ports PHY_RXDV]

set_property PACKAGE_PIN   P16      [get_ports PHY_RXC]
set_property IOSTANDARD LVCMOS33    [get_ports PHY_RXC]

set_property PACKAGE_PIN   P13      [get_ports PHY_RXER]
set_property IOSTANDARD LVCMOS33    [get_ports PHY_RXER]

set_property PACKAGE_PIN   T12      [get_ports PHY_TXEN]
set_property IOSTANDARD LVCMOS33    [get_ports PHY_TXEN]

set_property PACKAGE_PIN   P10      [get_ports PHY_TXC]
set_property IOSTANDARD LVCMOS33    [get_ports PHY_TXC]

set_property PACKAGE_PIN   R11      [get_ports PHY_TXER]
set_property IOSTANDARD LVCMOS33    [get_ports PHY_TXER]

set_property PACKAGE_PIN   N13      [get_ports {PHY_RXD[0]}]
set_property PACKAGE_PIN   N14      [get_ports {PHY_RXD[1]}]
set_property PACKAGE_PIN   N16      [get_ports {PHY_RXD[2]}]
set_property PACKAGE_PIN   P15      [get_ports {PHY_RXD[3]}]
set_property PACKAGE_PIN   R15      [get_ports {PHY_RXD[4]}]
set_property PACKAGE_PIN   R16      [get_ports {PHY_RXD[5]}]
set_property PACKAGE_PIN   T14      [get_ports {PHY_RXD[6]}]
set_property PACKAGE_PIN   T15      [get_ports {PHY_RXD[7]}]
set_property IOSTANDARD    LVCMOS33 [get_ports {PHY_RXD*}]

set_property PACKAGE_PIN   R12      [get_ports {PHY_TXD[0]}]
set_property PACKAGE_PIN   N12      [get_ports {PHY_TXD[1]}]
set_property PACKAGE_PIN   K12      [get_ports {PHY_TXD[2]}]
set_property PACKAGE_PIN   K13      [get_ports {PHY_TXD[3]}]
set_property PACKAGE_PIN   P11      [get_ports {PHY_TXD[4]}]
set_property PACKAGE_PIN   N9       [get_ports {PHY_TXD[5]}]
set_property PACKAGE_PIN   P9       [get_ports {PHY_TXD[6]}]
set_property PACKAGE_PIN   T10      [get_ports {PHY_TXD[7]}]
set_property IOSTANDARD    LVCMOS33 [get_ports {PHY_TXD*}]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets PHY_RXC_IBUF]



#Header U7
############################################################################
# DAC pins                                                                 #
############################################################################
set_property PACKAGE_PIN    J4      [get_ports DAC_CLK]
set_property IOSTANDARD LVCMOS33    [get_ports DAC_CLK]

set_property PACKAGE_PIN    A4      [get_ports {DAC_DATA[0]}]
set_property PACKAGE_PIN    D6      [get_ports {DAC_DATA[1]}]
set_property PACKAGE_PIN    D5      [get_ports {DAC_DATA[2]}]
set_property PACKAGE_PIN    C7      [get_ports {DAC_DATA[3]}]
set_property PACKAGE_PIN    C6      [get_ports {DAC_DATA[4]}]
set_property PACKAGE_PIN    G5      [get_ports {DAC_DATA[5]}]
set_property PACKAGE_PIN    G4      [get_ports {DAC_DATA[6]}]
set_property PACKAGE_PIN    J5      [get_ports {DAC_DATA[7]}]
set_property IOSTANDARD LVCMOS33    [get_ports {DAC_DATA*}]

############################################################################
# ADC pins                                                                 #
############################################################################
set_property PACKAGE_PIN    E5      [get_ports ADC_CLK]
set_property IOSTANDARD LVCMOS33    [get_ports ADC_CLK]

set_property PACKAGE_PIN    A2      [get_ports {ADC_DATA[0]}]
set_property PACKAGE_PIN    B2      [get_ports {ADC_DATA[1]}]
set_property PACKAGE_PIN    B1      [get_ports {ADC_DATA[2]}]
set_property PACKAGE_PIN    C1      [get_ports {ADC_DATA[3]}]
set_property PACKAGE_PIN    D1      [get_ports {ADC_DATA[4]}]
set_property PACKAGE_PIN    E2      [get_ports {ADC_DATA[5]}]
set_property PACKAGE_PIN    D3      [get_ports {ADC_DATA[6]}]
set_property PACKAGE_PIN    E3      [get_ports {ADC_DATA[7]}]
set_property IOSTANDARD LVCMOS33    [get_ports {ADC_DATA*}]

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]


############################################################################
# Clock constraints                                                        #
############################################################################
create_clock     -period 20.000   -name sys_clk  [get_ports sys_clk]
create_clock     -period 8.000    -name PHY_RXC  [get_ports PHY_RXC]
create_clock     -period 8.000    -name PHY_GTXC [get_ports PHY_GTXC]

create_clock     -period 8.000    -name ADC_CLK  [get_ports ADC_CLK]
create_clock     -period 8.000    -name DAC_CLK  [get_ports DAC_CLK]

#set_output_delay -clock [get_clocks PHY_GTXC] -min -add_delay 0.000 [get_ports {PHY_TXD*}]
#set_output_delay -clock [get_clocks PHY_GTXC] -max -add_delay 1.000 [get_ports {PHY_TXD*}]

#set_output_delay -clock [get_clocks PHY_GTXC] -min -add_delay 0.000 [get_ports PHY_TXEN]
#set_output_delay -clock [get_clocks PHY_GTXC] -max -add_delay 1.000 [get_ports PHY_TXEN]

#set_output_delay -clock [get_clocks PHY_GTXC] -min -add_delay 0.000 [get_ports PHY_TXER]
#set_output_delay -clock [get_clocks PHY_GTXC] -max -add_delay 1.000 [get_ports PHY_TXER]
