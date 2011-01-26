ghdl -a mux2to1.vhdl
ghdl -a fulladder1.vhdl
ghdl -a fulladder32.vhdl
ghdl -a addersubtractor32.vhdl
ghdl -a addersubtractor32_tb.vhdl
ghdl -e addersubtractor32_tb
ghdl -r addersubtractor32_tb --vcd=addersubtractor32.vcd
