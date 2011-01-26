library ieee;
use ieee.std_logic_1164.all;

use work.mux32to1;
use work.datatypes.bus32x32;

entity mux32x32to1 is
	port (S: in std_logic_vector(4 downto 0);
	      R: in bus32x32;
	      O: out std_logic_vector(31 downto 0));
end mux32x32to1;

architecture behavior of mux32x32to1 is
	component mux32to1
		port (S: in std_logic_vector(4 downto 0);
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic);
	end component;

begin
	muxen: for i in 31 downto 0 generate
		mux32to1_x: mux32to1 port map (
			S=>S,
			O=>O(i), --);
			R(0)=>R(0)(i),
			R(1)=>R(1)(i),
			R(2)=>R(2)(i),
			R(3)=>R(3)(i),
			R(4)=>R(4)(i),
			R(5)=>R(5)(i),
			R(6)=>R(6)(i),
			R(7)=>R(7)(i),
			R(8)=>R(8)(i),
			R(9)=>R(9)(i),
			R(10)=>R(10)(i),
			R(11)=>R(11)(i),
			R(12)=>R(12)(i),
			R(13)=>R(13)(i),
			R(14)=>R(14)(i),
			R(15)=>R(15)(i),
			R(16)=>R(16)(i),
			R(17)=>R(17)(i),
			R(18)=>R(18)(i),
			R(19)=>R(19)(i),
			R(20)=>R(20)(i),
			R(21)=>R(21)(i),
			R(22)=>R(22)(i),
			R(23)=>R(23)(i),
			R(24)=>R(24)(i),
			R(25)=>R(25)(i),
			R(26)=>R(26)(i),
			R(27)=>R(27)(i),
			R(28)=>R(28)(i),
			R(29)=>R(29)(i),
			R(30)=>R(30)(i),
			R(31)=>R(31)(i));
			--assign_R: for j in 31 downto 0 generate
				--mux32to1_x: mux32to1 port map (R(j)=>R(i)(j));
			--end generate;
	end generate;
end behavior;
