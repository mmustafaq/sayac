library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_module is
generic (
clkfreq	: integer := 100_000_000
);
port (
clk				: in std_logic;
start			: in std_logic;
reset			: in std_logic;
seven_seg		: out std_logic_vector (7 downto 0); -- cathode
anodes		: out std_logic_vector (7 downto 0)      -- anode
);
end top_module;

architecture Behavioral of top_module is


component debounce is

generic(
		clk_freq 		: integer   := 100_000_000; -- clock parameters
		debounce_time	: integer   := 1000;		--
		c_initial		: std_logic := '0'          -- initial clock value
		);
port (
		clk        : in  std_logic; --clock 
		signal_in  : in  std_logic;	--input signal value 0 or 1
		signal_out : out std_logic  --outpu signal value 
		
);
end component;

component bcd_incrementor is
generic (
ones_lim	: integer := 9;
tens_lim	: integer := 5
);
port (
clk			: in std_logic;
increment	: in std_logic;
reset		: in std_logic;
ones_op		: out std_logic_vector (3 downto 0);
tens_op		: out std_logic_vector (3 downto 0)
);
end component;

component bcd_to_7segment is
port (
bcd_i		: in std_logic_vector (3 downto 0);
sevenseg_o	: out std_logic_vector (7 downto 0)
);
end component;







signal start_deb				: std_logic 					:= '0';
signal reset_deb				: std_logic 					:= '0';
signal ss_increment				: std_logic 					:= '0';
signal s_increment				: std_logic 					:= '0';
signal m_increment				: std_logic 					:= '0';


signal ones_op_ss				: std_logic_vector(3 downto 0) 	:= (others => '0');
signal tens_op_ss				: std_logic_vector(3 downto 0) 	:= (others => '0');
signal ones_op_s				: std_logic_vector(3 downto 0) 	:= (others => '0');
signal tens_op_s				: std_logic_vector(3 downto 0) 	:= (others => '0');
signal ones_op_m				: std_logic_vector(3 downto 0) 	:= (others => '0');
signal tens_op_m				: std_logic_vector(3 downto 0) 	:= (others => '0');

signal ss_ones_7seg				: std_logic_vector (7 downto 0) := (others => '1');
signal ss_tens_7seg				: std_logic_vector (7 downto 0) := (others => '1');
signal s_ones_7seg				: std_logic_vector (7 downto 0) := (others => '1');
signal s_tens_7seg				: std_logic_vector (7 downto 0) := (others => '1');
signal m_ones_7seg				: std_logic_vector (7 downto 0) := (others => '1');
signal m_tens_7seg				: std_logic_vector (7 downto 0) := (others => '1');
signal anodes					: std_logic_vector (7 downto 0) := "11111110";




begin

i_start_deb : debounce
generic map(
clk_freq		=> clkfreq,
debounce_time	=> 1000,
c_initval		=> '0'
)
port map(
clk			=> clk,
signal_in	=> start,
signal_out	=> start_deb
);


i_reset_deb : debounce
generic map(
clk_freq		=> clkfreq,
debounce_time	=> 1000,
c_initval		=> '0'
)
port map(
clk			=> clk,
signal_in	=> reset,
signal_out	=> reset_deb
);

split_sec_inc : bcd_incrementor
generic map(
ones_lim	=> 9,
tens_lim	=> 9
)
port map(
clk			=> clk,
increment	=> ss_increment,
reset		=> reset_deb,
ones_op		=> ones_op_ss,
tens_op		=> tens_op_ss
);



sec_inc : bcd_incrementor
generic map(
ones_lim	=> 9,
tens_lim	=> 5
)
port map(
clk			=> clk,
increment	=> s_increment,
reset		=> reset_deb,
ones_op		=> ones_op_s,
tens_op		=> tens_op_s
);

min_inc : bcd_incrementor
generic map(
ones_lim	=> 9,
tens_lim	=> 5
)
port map(
clk			=> clk,
increment	=> m_increment,
reset		=> reset_deb,
ones_op		=> ones_op_m,
tens_op		=> tens_op_m
);


ss_7seg_ones : bcd_to_7segment
port map(
bcd_i		=> ones_op_ss,
sevenseg_o	=> ss_ones_7seg
);

ss_7seg_tens : bcd_to_7segment
port map(
bcd_i		=> tens_op_ss,
sevenseg_o	=> ss_tens_7seg
);

s_7seg_ones : bcd_to_7segment
port map(
bcd_i		=> ones_op_s,
sevenseg_o	=> s_ones_7seg
);

s_7seg_tens : bcd_to_7segment
port map(
bcd_i		=> tens_op_s,
sevenseg_o	=> s_tens_7seg
);

m_7seg_ones : bcd_to_7segment
port map(
bcd_i		=> ones_op_m,
sevenseg_o	=> m_ones_7seg
);

m_7seg_tens : bcd_to_7segment
port map(
bcd_i		=> tens_op_m,
sevenseg_o	=> m_tens_7seg
);


end Behavioral;