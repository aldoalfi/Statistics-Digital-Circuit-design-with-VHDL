library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


--entity of statistic
entity statistic is
		Generic (n : integer := 3);
		
		Port (clk, reset, go : in  std_logic;
				din				: in  std_logic_vector (n-1 downto 0);
				dout_mode		: in  std_logic_vector (1 downto 0);
				dout				: out std_logic_vector (n-1 downto 0);
				done				: out std_logic);
end statistic;


--architecture for statistic
architecture behavior of statistic is

component datapath is
		Generic (n : integer := 3; --Data
					k : integer := 5; --Loop
					m : integer := 2);--Carry
		
		
		Port (din  		 : in  std_logic_vector (n-1 downto 0);
				dout_mode : in  std_logic_vector (1 downto 0);
				clk 		 : in  std_logic;
				reset		 : in  std_logic;
				dout		 : out std_logic_vector (n-1 downto 0);
				
				--Controller Pin
				
				gt1, gt2, gt3 : out std_logic := '0';
				zi				  : out std_logic := '0';
				en1, en2, en3 : in  std_logic := '0';
				esum, enc	  : in  std_logic := '0';
				s2, s3		  : in std_logic) := '0';
				
end component;

component controller is
		Port (go				  : in  std_logic;
				done			  : out std_logic;
				en1, en2, en3 : out std_logic;
				esum, enc	  : out std_logic;
				s2, s3		  : out std_logic;
				clk, reset	  : in  std_logic;
				
		--connection from datapath
		
				gt1, gt2, gt3 : in std_logic;
				zi				  : in std_logic);
				
end component;

		signal s_en1, s_en2, s_en3 : std_logic := '0';
		signal s_esum, s_enc			: std_logic	:= '0';
		signal s_gt1, s_gt2, s_gt3 : std_logic	:= '0';
		signal s_s2, s_s3, s_zi		: std_logic := '0';
begin

	data_path: datapath PORT MAP (din=>din, clk=>clk, reset=>reset, dout_mode=>dout_mode, dout=>dout,
										  en1=>s_en1, en2=>s_en2, en3=>s_en3, esum=>s_esum, enc=>s_enc, s2=>s_s2,
										  s3=>s_s3, zi=>s_zi, gt1=>s_gt1, gt2=>s_gt2, gt3=>s_gt3);
										  
	control	: controller PORT MAP (go=>go, done=>done, reset=>reset, clk=>clk, en1=>s_en1, 
											  en2=>s_en2, en3=>s_en3, esum=>s_esum, enc=>s_enc, s2=>s_s2,
											  s3=>s_s3, zi=>s_zi, gt1=>s_gt1, gt2=>s_gt2, gt3=>s_gt3);
											  
end behavior;