library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity bcd_to_7segment is
port (
bcd_i		: in std_logic_vector (3 downto 0);
sevenseg_o	: out std_logic_vector (7 downto 0)
);
end bcd_to_7segment;

architecture Behavioral of bcd_to_sevenseg is

begin

process (bcd_i) begin

	case bcd_i is
		-- When cathode of a segment is one it will not illuminate
		when "0000" =>			
			sevenseg_o	<= "00000011"; -- CA CB CC CD CE CF CG DP				
			
		when "0001" =>		
			sevenseg_o	<= "10011111"; -- CA CB CC CD CE CF CG DP
			
		when "0010" =>		
			sevenseg_o	<= "00100101"; -- CA CB CC CD CE CF CG DP
			
		when "0011" =>
			sevenseg_o	<= "00001101"; -- CA CB CC CD CE CF CG DP
			
		when "0100" =>
			sevenseg_o	<= "10011001"; -- CA CB CC CD CE CF CG DP
			
		when "0101" =>
			sevenseg_o	<= "01001001"; -- CA CB CC CD CE CF CG DP
			
		when "0110" =>
			sevenseg_o	<= "01000001"; -- CA CB CC CD CE CF CG DP
			
		when "0111" =>
			sevenseg_o	<= "00011111"; -- CA CB CC CD CE CF CG DP
			
		when "1000" =>
			sevenseg_o	<= "00000001"; -- CA CB CC CD CE CF CG DP
			
		when "1001" =>
			sevenseg_o	<= "00001001"; -- CA CB CC CD CE CF CG DP
			
		when others =>
			sevenseg_o	<= "11111111"; -- CA CB CC CD CE CF CG DP
		
	end case;

end process;

end Behavioral;