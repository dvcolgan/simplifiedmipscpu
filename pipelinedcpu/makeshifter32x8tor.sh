ghdl -a mux2to1.vhdl
ghdl -a shifter32x8tor.vhdl
ghdl -a shifter32x8tor_tb.vhdl
ghdl -e shifter32x8tor_tb
ghdl -r shifter32x8tor_tb --vcd=shifter32x8tor.vcd
