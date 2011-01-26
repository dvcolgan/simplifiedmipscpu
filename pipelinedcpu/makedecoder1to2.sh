ghdl -a decoder1to2.vhdl
ghdl -a decoder1to2_tb.vhdl
ghdl -e decoder1to2_tb
ghdl -r decoder1to2_tb --vcd=decoder1to2.vcd
