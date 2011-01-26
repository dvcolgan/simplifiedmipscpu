library ieee;
use ieee.std_logic_1164.all;

entity forwardingunit is
	port(Rs, Rt: in std_logic_vector(4 downto 0);
	     MEM_RegWriteAddress, WB_RegWriteAddress: in std_logic_vector(4 downto 0);
	     MEM_RegWriteAddressWE, WB_RegWriteAddressWE: in std_logic;
	     ForwardingUnitFlagALUSrc1, ForwardingUnitFlagALUSrc2: out std_logic_vector(1 downto 0));
end forwardingunit;

architecture behavior of forwardingunit is
begin
	process (Rs, Rt, MEM_RegWriteAddress, MEM_RegWriteAddressWE, WB_RegWriteAddress, WB_RegWriteAddressWE)
	begin
		if WB_RegWriteAddress = Rs and WB_RegWriteAddressWE = '1' and WB_RegWriteAddress /= "00000" then
			ForwardingUnitFlagALUSrc1 <= "10" after 90 ps;
		else
			if MEM_RegWriteAddress = Rs and MEM_RegWriteAddressWE = '1' and MEM_RegWriteAddress /= "00000" then
				ForwardingUnitFlagALUSrc1 <= "01" after 90 ps;
			else
				ForwardingUnitFlagALUSrc1 <= "00" after 90 ps;
			end if;
		end if;

		if WB_RegWriteAddress = Rt and WB_RegWriteAddressWE = '1' and WB_RegWriteAddress /= "00000" then
			ForwardingUnitFlagALUSrc2 <= "10" after 90 ps;
		else
			if MEM_RegWriteAddress = Rt and MEM_RegWriteAddressWE = '1' and MEM_RegWriteAddress /= "00000" then
				ForwardingUnitFlagALUSrc2 <= "01" after 90 ps;
			else
				ForwardingUnitFlagALUSrc2 <= "00" after 90 ps;
			end if;
		end if;
	end process;
end behavior;
