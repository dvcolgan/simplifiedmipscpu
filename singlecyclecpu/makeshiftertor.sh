ghdl -a mux2to1.vhdl

ghdl -a shifter32x1tor.vhdl
ghdl -a shifter32x2tor.vhdl
ghdl -a shifter32x4tor.vhdl
ghdl -a shifter32x8tor.vhdl
ghdl -a shifter32x16tor.vhdl

ghdl -a shiftertor.vhdl
ghdl -a shiftertor_tb.vhdl
ghdl -e shiftertor_tb
ghdl -r shiftertor_tb --vcd=shiftertor.vcd
