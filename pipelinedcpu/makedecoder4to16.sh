ghdl -a decoder2to4.vhdl
ghdl -a decoder4to16.vhdl
ghdl -a decoder4to16_tb.vhdl
ghdl -e decoder4to16_tb
ghdl -r decoder4to16_tb --vcd=decoder4to16.vcd
