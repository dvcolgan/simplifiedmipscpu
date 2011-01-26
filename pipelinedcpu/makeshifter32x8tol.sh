ghdl -a mux2to1.vhdl
ghdl -a shifter32x8tol.vhdl
ghdl -a shifter32x8tol_tb.vhdl
ghdl -e shifter32x8tol_tb
ghdl -r shifter32x8tol_tb --vcd=shifter32x8tol.vcd
