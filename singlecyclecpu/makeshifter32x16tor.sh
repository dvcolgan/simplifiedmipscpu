ghdl -a mux2to1.vhdl
ghdl -a shifter32x16tor.vhdl
ghdl -a shifter32x16tor_tb.vhdl
ghdl -e shifter32x16tor_tb
ghdl -r shifter32x16tor_tb --vcd=shifter32x16tor.vcd
