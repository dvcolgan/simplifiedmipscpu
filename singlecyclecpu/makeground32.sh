ghdl -a ground32.vhdl
ghdl -a ground32_tb.vhdl
ghdl -e ground32_tb
ghdl -r ground32_tb --vcd=ground32.vcd
