ghdl -a std_logic_arith.vhdl
ghdl -a std_logic_unsigned.vhdl
ghdl -a sram.vhdl
ghdl -a sram_tb.vhdl
ghdl -e sram_tb
ghdl -r sram_tb --vcd=sram.vcd
