ghdl -a decoder1to2.vhdl
ghdl -a decoder2to4.vhdl
ghdl -a decoder4to16.vhdl
ghdl -a decoder5to32.vhdl
ghdl -a decoder5to32_tb.vhdl
ghdl -e decoder5to32_tb
ghdl -r decoder5to32_tb --vcd=decoder5to32.vcd
