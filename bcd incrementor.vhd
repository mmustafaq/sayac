library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity bcd_incrementor is
generic (
ones_lim	: integer := 9;
tens_lim	: integer := 5
);
port (
clk			: in std_logic;
increment	: in std_logic;
reset		: in std_logic;
ones_op	: out std_logic_vector (3 downto 0);
tens_op		: out std_logic_vector (3 downto 0)
);
end bcd_incrementor;


architecture Behavioral of bcd_incrementor is
begin
signal ones : std_logic_vector(3 downto 0) := others => '0';
signal tens : std_logic_vector(3 downto 0) := others => '0';



process(clk)
begin
if(increment = '1') then 

	if(ones = ones_lim) then
		if(tens = tens_lim) then
			ones <= x"0";
			tens <= x"0";
		else
			ones <= x"0";
			tens <= tens + 1 ;
		end if;
	else 
		ones <= ones + 1 ;
	end if;
end if ;
if(reset = '1') then
	ones <= x"0";	
	tens <= x"0";
end if;



end process;

ones_op <= ones ;
tens_op <= tens ;




end Behavioral; 