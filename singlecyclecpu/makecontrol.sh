ghdl -a control.vhdl
ghdl -a control_tb.vhdl
ghdl -e control_tb
ghdl -r control_tb --vcd=control.vcd
