library ieee;
use ieee.std_logic_1164.all;

entity control is
	port(Operation: in std_logic_vector(31 downto 26);
	     Function_: in std_logic_vector(5 downto 0);
	     Branch, MemRead, MemWrite, RegWrite, SignExtend: out std_logic;
	     MemToReg, RegDst, Jump, ALUSrc, ALUOp: out std_logic_vector(1 downto 0));
end control;

architecture behavior of control is
begin
	process (Operation, Function_)
	begin
		case Operation is
			when "000000" => --R-Type instruction
				case Function_ is
					when "001000" => --jr
						Branch <= '0' after 90 ps;
						MemRead <= '0' after 90 ps;
						MemWrite <= '0' after 90 ps;
						ALUSrc <= "00" after 90 ps; --Don't care
						RegWrite <= '0' after 90 ps;
						SignExtend <= '0' after 90 ps; --Don't care

						MemToReg <= "00" after 90 ps; --Don't care
						RegDst <= "00" after 90 ps; --Don't care
						Jump <= "10" after 90 ps;
						ALUOp <= "00" after 90 ps; --Don't care

					when "000000" => --sll
						Branch <= '0' after 90 ps;
						MemRead <= '0' after 90 ps;
						MemWrite <= '0' after 90 ps;
						ALUSrc <= "10" after 90 ps;
						RegWrite <= '1' after 90 ps;
						SignExtend <= '0' after 90 ps; --Don't care

						MemToReg <= "00" after 90 ps;
						RegDst <= "01" after 90 ps;
						Jump <= "00" after 90 ps;
						ALUOp <= "10" after 90 ps;

					when "000010" => --srl
						Branch <= '0' after 90 ps;
						MemRead <= '0' after 90 ps;
						MemWrite <= '0' after 90 ps;
						ALUSrc <= "10" after 90 ps;
						RegWrite <= '1' after 90 ps;
						SignExtend <= '0' after 90 ps; --Don't care

						MemToReg <= "00" after 90 ps;
						RegDst <= "01" after 90 ps;
						Jump <= "00" after 90 ps;
						ALUOp <= "10" after 90 ps;

					when others => --add nor slt sub
						Branch <= '0' after 90 ps;
						MemRead <= '0' after 90 ps;
						MemWrite <= '0' after 90 ps;
						ALUSrc <= "00" after 90 ps;
						RegWrite <= '1' after 90 ps;
						SignExtend <= '0' after 90 ps; --Don't care

						MemToReg <= "00" after 90 ps;
						RegDst <= "01" after 90 ps;
						Jump <= "00" after 90 ps;
						ALUOp <= "10" after 90 ps;
				end case;

			when "000100" => --beq
				Branch <= '1' after 90 ps;
				MemRead <= '0' after 90 ps;
				MemWrite <= '0' after 90 ps;
				ALUSrc <= "00" after 90 ps;
				RegWrite <= '0' after 90 ps;
				SignExtend <= '1' after 90 ps;

				MemToReg <= "00" after 90 ps; --Don't care
				RegDst <= "00" after 90 ps; --Don't care
				Jump <= "00" after 90 ps;
				ALUOp <= "01" after 90 ps; --Subtract

			when "000010" => --jump
				Branch <= '0' after 90 ps;
				MemRead <= '0' after 90 ps;
				MemWrite <= '0' after 90 ps;
				ALUSrc <= "00" after 90 ps; --Don't care
				RegWrite <= '0' after 90 ps;
				SignExtend <= '0' after 90 ps; --Don't care

				MemToReg <= "00" after 90 ps; --Don't care
				RegDst <= "00" after 90 ps; --Don't care
				Jump <= "01" after 90 ps;
				ALUOp <= "00" after 90 ps; --Don't care

			when "000011" => --jal
				Branch <= '0' after 90 ps;
				MemRead <= '0' after 90 ps;
				MemWrite <= '0' after 90 ps;
				ALUSrc <= "00" after 90 ps; --Don't care
				RegWrite <= '1' after 90 ps;
				SignExtend <= '0' after 90 ps; --Don't care

				MemToReg <= "10" after 90 ps;
				RegDst <= "10" after 90 ps;
				Jump <= "01" after 90 ps;
				ALUOp <= "00" after 90 ps; --Don't care

			when "100011" => --lw
				Branch <= '0' after 90 ps;
				MemRead <= '1' after 90 ps;
				MemWrite <= '0' after 90 ps;
				ALUSrc <= "01" after 90 ps;
				RegWrite <= '1' after 90 ps;
				SignExtend <= '1' after 90 ps;

				MemToReg <= "01" after 90 ps;
				RegDst <= "00" after 90 ps;
				Jump <= "00" after 90 ps;
				ALUOp <= "00" after 90 ps;

			when "101011" => --sw
				Branch <= '0' after 90 ps;
				MemRead <= '0' after 90 ps;
				MemWrite <= '1' after 90 ps;
				ALUSrc <= "01" after 90 ps;
				RegWrite <= '0' after 90 ps;
				SignExtend <= '1' after 90 ps;

				MemToReg <= "00" after 90 ps; --Don't care
				RegDst <= "00" after 90 ps; --Don't care
				Jump <= "00" after 90 ps;
				ALUOp <= "00" after 90 ps;

			when "001101" => --ori
				Branch <= '0' after 90 ps;
				MemRead <= '0' after 90 ps;
				MemWrite <= '0' after 90 ps;
				ALUSrc <= "01" after 90 ps;
				RegWrite <= '1' after 90 ps;
				SignExtend <= '0' after 90 ps;

				MemToReg <= "00" after 90 ps;
				RegDst <= "00" after 90 ps;
				Jump <= "00" after 90 ps;
				ALUOp <= "11" after 90 ps;
		end case;
	end process;
end behavior;
