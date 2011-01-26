library ieee;
use ieee.std_logic_1164.all;

use work.mux2to1;

entity extender is
	port (Input: in std_logic_vector(15 downto 0);
	      ExtendMethod: in std_logic;
	      Output: out std_logic_vector(31 downto 0));
end extender;

architecture behavior of extender is
	component mux2to1
		port (S: in std_logic;
		      R: in std_logic_vector(1 downto 0);
		      O: out std_logic);
	end component;

	signal MuxOutput: std_logic;
begin

	mux2to1_0: mux2to1 port map (S=>ExtendMethod, R(0)=>'0', R(1)=>Input(15), O=>MuxOutput);

	Connect: for i in 31 downto 16 generate
		Output(i) <= MuxOutput;
	end generate;
	Output(15 downto 0) <= Input;

end behavior;
