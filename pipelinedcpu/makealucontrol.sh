ghdl -a alucontrol.vhdl
ghdl -a alucontrol_tb.vhdl
ghdl -e alucontrol_tb
ghdl -r alucontrol_tb --vcd=alucontrol.vcd
