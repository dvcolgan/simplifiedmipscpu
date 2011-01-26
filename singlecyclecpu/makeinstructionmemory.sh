ghdl -a instructionmemory.vhdl
ghdl -a instructionmemory_tb.vhdl
ghdl -e instructionmemory_tb
ghdl -r instructionmemory_tb --vcd=instructionmemory.vcd
