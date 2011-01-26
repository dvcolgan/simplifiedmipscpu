ghdl -a mux2to1.vhdl
ghdl -a shifter32x1tor.vhdl
ghdl -a shifter32x1tor_tb.vhdl
ghdl -e shifter32x1tor_tb
ghdl -r shifter32x1tor_tb --vcd=shifter32x1tor.vcd
