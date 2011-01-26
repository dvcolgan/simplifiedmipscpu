ghdl -a nor1.vhdl
ghdl -a nor32.vhdl
ghdl -a nor32_tb.vhdl
ghdl -e nor32_tb
ghdl -r nor32_tb --vcd=nor32.vcd
