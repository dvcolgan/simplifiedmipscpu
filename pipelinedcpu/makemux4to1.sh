ghdl -a mux4to1.vhdl
ghdl -a mux4to1_tb.vhdl
ghdl -e mux4to1_tb
ghdl -r mux4to1_tb --vcd=mux4to1.vcd
