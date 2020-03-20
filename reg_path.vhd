library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


--entity of reg_path
entity reg_path is
		Generic (n : integer := 3);
		
		Port (din  		 : in  std_logic_vector (n-1 downto 0);
				clk 		 : in  std_logic;
				reset		 : in  std_logic;
				en			 : in  std_logic;
				no    	 : out std_logic_vector (n-1 downto 0));
end reg_path;


--architecture for reg_path
architecture behavior of reg_path is
		signal empty : std_logic_vector (n-1 downto 0) := (others =>'0');

begin
		process (clk, en, reset) is
		begin
				if (en='1') then
						if (reset='1') then
								no <= empty;
						elsif (rising_edge(clk)) then
								no <= din;
						else
								null;
						end if;
				end if;
		end process;
						
end behavior;