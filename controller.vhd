library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


--entity of statistic controller
entity controller is
		Port (go				  : in  std_logic;
				done			  : out std_logic;
				en1, en2, en3 : out std_logic;
				esum, enc	  : out std_logic;
				s2, s3		  : out std_logic;
				clk, reset	  : in  std_logic;
		--connection from datapath
				gt1, gt2, gt3 : in std_logic;
				zi				  : in std_logic);
				
end controller;


--architecture for controller
architecture behavior of controller is
begin
		process (clk) is
		begin
				if (reset = '1') then
						esum <= '0';
						enc  <= '0';
						en1  <= '0';
						en2  <= '0';
						en3  <= '0';
				else
						if (go='1') then
								esum <= '1';
								enc  <= '1';
								en1  <= '1';
								en2  <= '1';
								en3  <= '1';
						end if;
				end if;
		end process;
			
		s2 <= '0' when gt1='1' else
				'1' when gt1='0';
							
		s3 <= '0' when gt2='1' else
				'1' when gt2='0';
			
		done <= '1' when zi='1' else
				  '0'	when zi='0';
end behavior;