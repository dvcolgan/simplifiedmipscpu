ghdl -a datamemory.vhdl
ghdl -a datamemory_tb.vhdl
ghdl -e datamemory_tb
ghdl -r datamemory_tb --vcd=datamemory.vcd
