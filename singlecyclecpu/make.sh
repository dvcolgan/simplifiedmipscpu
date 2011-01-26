#run this to compile and test everything

ghdl -a bustypes.vhdl

sh makemux2to1.sh
echo
sh makemux4to1.sh
echo
sh makemux16to1.sh
echo
sh makemux32to1.sh
echo
sh makemux32x32to1.sh
echo

sh makedecoder1to2.sh
echo
sh makedecoder2to4.sh
echo
sh makedecoder4to16.sh
echo
sh makedecoder5to32.sh
echo

sh makedff.sh
echo
sh makereg.sh
echo
sh makeground32.sh
echo

sh makeregfile.sh
echo
