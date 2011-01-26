ghdl -a dff.vhdl
ghdl -a dff_tb.vhdl
ghdl -e dff_tb
ghdl -r dff_tb --vcd=dff.vcd
