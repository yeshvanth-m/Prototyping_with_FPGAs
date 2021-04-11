## This file is a general .xdc for the USB104 A7-100T Rev. B.2

## Buttons
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { Clk }]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets Clk_IBUF]

## Pmod Header JA
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports {Out[0]}]
set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVCMOS33} [get_ports {Out[1]}]
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports {Out[2]}]
set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports {Out[3]}]
set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports {Out[4]}]
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {Out[5]}]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports {Out[6]}]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports {Out[7]}]

### Pmod Header JB
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports {In[0]}]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports {In[1]}]
set_property -dict {PACKAGE_PIN B3 IOSTANDARD LVCMOS33} [get_ports {In[2]}]
set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {In[3]}]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {In[4]}]
set_property -dict {PACKAGE_PIN A1 IOSTANDARD LVCMOS33} [get_ports {In[5]}]
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {In[6]}]
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {In[7]}]

### Pmod Header JC
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports load]


## Bitstream Settings
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]


