library ieee;
use ieee.std_logic_1164.all;

entity smoosher is
	port (JumpAddress: in std_logic_vector(25 downto 0);
	      PCPlus4: in std_logic_vector(31 downto 28);
	      Output: out std_logic_vector(31 downto 0));
end smoosher;

architecture behavior of smoosher is
begin

	Output(31 downto 28) <= PCPlus4;
	Output(27 downto 2) <= JumpAddress;
	Output(1 downto 0) <= "00"; --Left shift 2

end behavior;
