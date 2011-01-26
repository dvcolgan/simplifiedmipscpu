ghdl -a bustypes.vhdl
ghdl -a mux2to1.vhdl
ghdl -a mux4to1.vhdl
ghdl -a mux16to1.vhdl
ghdl -a mux32to1.vhdl
ghdl -a mux32x32to1.vhdl

ghdl -a decoder1to2.vhdl
ghdl -a decoder2to4.vhdl
ghdl -a decoder4to16.vhdl
ghdl -a decoder5to32.vhdl

ghdl -a dff.vhdl
ghdl -a reg.vhdl
ghdl -a ground32.vhdl

ghdl -a regfile.vhdl
ghdl -a regfile_tb.vhdl

ghdl -e regfile_tb
ghdl -r regfile_tb --vcd=regfile.vcd
