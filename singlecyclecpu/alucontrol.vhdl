library ieee;
use ieee.std_logic_1164.all;

entity alucontrol is
	port(ALUOp: in std_logic_vector(1 downto 0);
	     Function_: in std_logic_vector(5 downto 0);
	     Operation: out std_logic_vector(2 downto 0));
end alucontrol;

architecture behavior of alucontrol is
begin
	process (ALUOp, Function_)
	begin
		case ALUOp is
			when "00" => --perform add
				Operation <= "000" after 90 ps;
			when "01" => --perform subtract
				Operation <= "100" after 90 ps;
			when "11" => --perform or
				Operation <= "111" after 90 ps;
			when "10" => --use function
				case Function_ is
					when "100000" => --add
						Operation <= "000" after 90 ps;
					when "010111" => --nor
						Operation <= "001" after 90 ps;
					when "000000" => --left shift
						Operation <= "010" after 90 ps;
					when "000010" => --right shift
						Operation <= "011" after 90 ps;
					when "100010" => --subtract
						Operation <= "100" after 90 ps;
					when "101010" => --set less than
						Operation <= "101" after 90 ps;
				end case;
		end case;
	end process;
end behavior;
