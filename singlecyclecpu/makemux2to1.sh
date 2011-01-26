ghdl -a mux2to1.vhdl
ghdl -a mux2to1_tb.vhdl
ghdl -e mux2to1_tb
ghdl -r mux2to1_tb --vcd=mux2to1.vcd
