ghdl -a mux2to1.vhdl
ghdl -a extender.vhdl
ghdl -a extender_tb.vhdl
ghdl -e extender_tb
ghdl -r extender_tb --vcd=extender.vcd
