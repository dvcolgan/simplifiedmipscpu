ghdl -a decoder2to4.vhdl
ghdl -a decoder2to4_tb.vhdl
ghdl -e decoder2to4_tb
ghdl -r decoder2to4_tb --vcd=decoder2to4.vcd
