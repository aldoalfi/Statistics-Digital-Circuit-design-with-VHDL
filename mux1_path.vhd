library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


--entity of mux1_path
entity mux1_path is
		Generic (n : integer := 3);
		
		Port (I0  		 : in  std_logic_vector (n-1 downto 0);
				I1 		 : in  std_logic_vector (n-1 downto 0);
				s			 : in  std_logic;
				y     	 : out std_logic_vector (n-1 downto 0));
end mux1_path;


--architecture for mux1_path
architecture behavior of mux1_path is
begin
		y <= I0 when s='0' else
			  I1 when s='1' else
		 	  (others => '0');
end behavior;	