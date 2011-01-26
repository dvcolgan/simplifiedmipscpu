ghdl -a dff.vhdl
ghdl -a reg.vhdl
ghdl -a reg_tb.vhdl
ghdl -e reg_tb
ghdl -r reg_tb --vcd=reg.vcd
