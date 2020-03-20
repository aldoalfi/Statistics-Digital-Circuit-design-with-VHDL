library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


--entity of mux2_path
entity mux2_path is
		Generic (n : integer := 3);
		
		Port (I0  		 : in  std_logic_vector (n-1 downto 0);
				I1 		 : in  std_logic_vector (n-1 downto 0);
				I2 		 : in  std_logic_vector (n-1 downto 0);
				I3 		 : in  std_logic_vector (n-1 downto 0);
				s			 : in  std_logic_vector (1 downto 0);
				y		  	 : out std_logic_vector (n-1 downto 0));
end mux2_path;


--architecture for mux1_path
architecture behavior of mux2_path is
begin
		y <= I0 when s="00" else
			  I1 when s="01" else
 	 		  I2 when s="10" else
			  I3 when s="11" else
			  (others => '0');
end behavior;