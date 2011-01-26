library ieee;
use ieee.std_logic_1164.all;

package datatypes is
	type bus32x32 is array(31 downto 0) of std_logic_vector(31 downto 0);
	type bus4x32 is array(3 downto 0) of std_logic_vector(31 downto 0);
	type bus32x4 is array(31 downto 0) of std_logic_vector(3 downto 0);
	type bus2x32 is array(1 downto 0) of std_logic_vector(31 downto 0);
	type bus32x2 is array(31 downto 0) of std_logic_vector(1 downto 0);
	type bus4x5 is array(3 downto 0) of std_logic_vector(4 downto 0);
	type bus5x4 is array(4 downto 0) of std_logic_vector(3 downto 0);
end package;
