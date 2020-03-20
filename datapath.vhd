library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--entity of statistic datapath
entity datapath is
		Generic (n : integer := 3; --Data
					k : integer := 5; --Loop
					m : integer := 2);--Carry
		
		
		Port (din  		 : in  std_logic_vector (n-1 downto 0);
				dout_mode : in  std_logic_vector (1 downto 0);
				clk 		 : in  std_logic;
				reset		 : in  std_logic;
				dout		 : out std_logic_vector (n-1 downto 0);
				
				--Controller Pin
				
				gt1, gt2, gt3 : out std_logic;
				zi				  : out std_logic;
				en1, en2, en3 : in  std_logic;
				esum, enc	  : in  std_logic;
				s2, s3		  : in std_logic);
				
end datapath;


--architecture for datapath
architecture dataflow of datapath is
		
component mux2_path is
		Port (I0  		 : in  std_logic_vector (n-1 downto 0);
				I1 		 : in  std_logic_vector (n-1 downto 0);
				I2 		 : in  std_logic_vector (n-1 downto 0);
				I3 		 : in  std_logic_vector (n-1 downto 0); 	
				s			 : in  std_logic_vector (1 downto 0);
				y		  	 : out std_logic_vector (n-1 downto 0));
end component;


component mux1_path is
		Port (I0  		 : in  std_logic_vector (n-1 downto 0);
				I1 		 : in  std_logic_vector (n-1 downto 0);
				s			 : in  std_logic;
				y		  	 : out std_logic_vector (n-1 downto 0));
end component;


component reg_path is
		Port (din  		 : in  std_logic_vector (n-1 downto 0);
				clk 		 : in  std_logic;
				reset		 : in  std_logic;
				en			 : in  std_logic;
				no    	 : out std_logic_vector (n-1 downto 0));
end component;

		signal no_1, no_2, no_3 : std_logic_vector (n-1 downto 0) := (others => '0');
		signal sum					: std_logic_vector (n+m-1 downto 0) := (others => '0');
		signal avr					: std_logic_vector (n-1 downto 0);
		signal i						: integer := 0;
		signal temp1, temp2		: std_logic_vector (n-1 downto 0);
		signal m_temp1          : std_logic_vector (n-1 downto 0) := (others => '0');
		signal m_temp2          : std_logic_vector (n-1 downto 0) := (others => '0');
		signal m_temp3          : std_logic_vector (n-1 downto 0) := (others => '0');
begin

		Reg1: reg_path  PORT MAP (clk=>clk, reset=>reset,
										  din=>din, en=>en1, no=>no_1);
										
		Mux1: mux1_path PORT MAP (s=>s2, I1=>din, I0=>no_1, y=>temp1);
										
		Reg2: reg_path  PORT MAP (clk=>clk, reset=>reset,
										  din=>temp1, en=>en2, no=>no_2);
		
		Mux2: mux1_path PORT MAP (s=>s3, I1=>din, I0=>no_2, y=>temp2);
										
		Reg3: reg_path  PORT MAP (clk=>clk, reset=>reset,
										  din=>temp2, en=>en3, no=>no_3);
												
		process (clk) is
				variable temp  :	std_logic := '0';
				variable carry :  std_logic := '0';
		begin						  
				if (rising_edge(clk)) then
						if (reset='1') then
								sum  <= (others => '0');
								i	  <= 0;
						else							
								for j in 0 to k-1 loop
										if (esum='1') then
												for j in 0 to n-1 loop
														temp		 	:= (sum(j) XOR din(j)) XOR carry;
														carry 		:= ((sum(j) XOR din(j)) AND carry) OR (din(j) AND sum(j));
														sum(j) 		<=  temp;
												end loop;
														
												for j in n to n+m-1 loop
														temp 		:= sum(j) XOR carry;
														carry 	:= sum(j) AND carry;
														sum(j) 	<= temp;
												end loop;
										end if;
										
										if din > no_1 then
												gt1 <= '1';
												m_temp3 <= m_temp2;
												m_temp2 <= m_temp1;
												m_temp1 <= din;
										elsif (din > no_2) then
												gt2 <= '1';
												m_temp3 <= m_temp2;
												m_temp2 <= din;
										elsif (din > no_3) then
												gt3 <= '1';
												m_temp3 <= din;
										end if;
								end loop;
								
								if (i = k-1) then
										zi <= '1';
								elsif (enc = '1') then
										i <= i + 1;
								end if;
								
						end if;
				end if;
		end process;
								
		avr <= sum(n+m-1 downto m);
		
		Mux3: Mux2_path PORT MAP (I0=>avr, I1=>m_temp1, I2=>m_temp2, 
										  I3=>m_temp3, s=>dout_mode, y=>dout);
										  
		
end dataflow; 