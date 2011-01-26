ghdl -a mux2to1.vhdl
ghdl -a shifter32x4tor.vhdl
ghdl -a shifter32x4tor_tb.vhdl
ghdl -e shifter32x4tor_tb
ghdl -r shifter32x4tor_tb --vcd=shifter32x4tor.vcd
