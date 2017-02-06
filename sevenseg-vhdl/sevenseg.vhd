----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:56:48 01/10/2012 
-- Design Name: 
-- Module Name:    sevenseg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sevenseg is
    Port ( clk1 : in  STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR(3 downto 0);
			  digit1 : in STD_LOGIC_VECTOR(3 downto 0);
           digit2 : in STD_LOGIC_VECTOR(3 downto 0);
			  digit3 : in STD_LOGIC_VECTOR(3 downto 0);
			  decplace : in STD_LOGIC_VECTOR(1 downto 0);
           seg1 : out  STD_LOGIC_VECTOR (6 downto 0);
           an1 : out  STD_LOGIC_VECTOR (3 downto 0);
			  dp1 : out STD_LOGIC);
end sevenseg;
 	
architecture Behavioral of sevenseg is
	signal cnt: STD_LOGIC_VECTOR(16 downto 0);
	alias counter : STD_LOGIC_VECTOR(1 downto 0) is cnt(16 downto 15);
	signal digit: STD_LOGIC_VECTOR(3 downto 0) :=( others => '0' );
begin

	
	anodeCtrl:process(counter)
	begin  
		if counter ="11" then
			an1 <= "1110";
		elsif counter ="10" then
			an1 <= "1101";
		elsif counter ="01" then
			an1 <= "1011";
		else
			an1 <= "0111";
		end if;
	end process;
	
	cathodeCtrl:process(counter, digit0, digit1, digit2, digit3)
	begin
			if counter = "00" then
				digit <= digit0;
			elsif counter = "01" then
				digit <= digit1;
			elsif counter = "10" then
				digit <= digit2;
			else 
				digit <= digit3;
			end if;		
			case digit(3 downto 0) is
				when x"0"=> seg1<="1000000";
				when x"1"=> seg1<="1111001";
				when x"2"=> seg1<="0100100"; 
				when x"3"=> seg1<="0110000";
				when x"4"=> seg1<="0011001"; 
				when x"5"=> seg1<="0010010";  
				when x"6"=> seg1<="0000010"; 
				when x"7"=> seg1<="1111000"; 
				when x"8"=> seg1<="0000000"; 
				when x"9"=> seg1<="0010000"; 
				when x"A"=> seg1<="0001000";
				when x"B"=> seg1<="0000011";
				when x"C"=> seg1<="1000110"; 
				when x"D"=> seg1<="0100001"; 
				when x"E"=> seg1<="0000110";
				when others=> seg1<="0001110"; 
			end case;
	end process;
	
	
	dp1 <= not((decplace(0) xor counter(0)) and (decplace(1) xor counter(1)));

	clk_proc: process(clk1)
	begin
		if rising_edge(clk1) then
			cnt <= cnt + 1;
		end if;
	end process;
	

end Behavioral;

