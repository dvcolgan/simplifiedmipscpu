ghdl -a mux4to1.vhdl
ghdl -a mux16to1.vhdl
ghdl -a mux16to1_tb.vhdl
ghdl -e mux16to1_tb
ghdl -r mux16to1_tb --vcd=mux16to1.vcd
