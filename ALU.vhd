library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


--entity of ALU
entity ALU is
		Port (Cin		   : in  std_logic := '0';
				A, B			: in  std_logic;
				sum, Cout	: out std_logic);
end ALU;


--architecture for ALU
architecture behavior of ALU is
begin
		sum  <= (A XOR B) XOR Cin;
		Cout <= (A AND B) OR ((A XOR B) AND Cin);
end behavior;