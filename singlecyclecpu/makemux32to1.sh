ghdl -a mux2to1.vhdl
ghdl -a mux4to1.vhdl
ghdl -a mux16to1.vhdl
ghdl -a mux32to1.vhdl
ghdl -a mux32to1_tb.vhdl
ghdl -e mux32to1_tb
ghdl -r mux32to1_tb --vcd=mux32to1.vcd
