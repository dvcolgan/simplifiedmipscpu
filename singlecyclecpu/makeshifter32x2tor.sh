ghdl -a mux2to1.vhdl
ghdl -a shifter32x2tor.vhdl
ghdl -a shifter32x2tor_tb.vhdl
ghdl -e shifter32x2tor_tb
ghdl -r shifter32x2tor_tb --vcd=shifter32x2tor.vcd
