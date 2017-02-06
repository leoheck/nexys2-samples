----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:17:00 01/10/2012 
-- Design Name: 
-- Module Name:    stopwatch - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stopwatch is
    Port ( clk : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
			  dp : out STD_LOGIC;
			  btn : in STD_LOGIC );
end stopwatch;


architecture Behavioral of stopwatch is
	signal counter : STD_LOGIC_VECTOR(27 downto 0);
	signal sec0: STD_LOGIC_VECTOR(3 downto 0) :=( others => '0' );
	signal sec1: STD_LOGIC_VECTOR(3 downto 0) :=( others => '0' );
	signal min0: STD_LOGIC_VECTOR(3 downto 0) :=( others => '0' );
	signal min1: STD_LOGIC_VECTOR(3 downto 0) :=( others => '0' );
	signal counting: STD_LOGIC :=('0');
	component sevenseg
		Port( clk1 : in  STD_LOGIC;
				digit0 : in STD_LOGIC_VECTOR(3 downto 0);
				digit1 : in STD_LOGIC_VECTOR(3 downto 0);
				digit2 : in STD_LOGIC_VECTOR(3 downto 0);
				digit3 : in STD_LOGIC_VECTOR(3 downto 0);
				decplace : in STD_LOGIC_VECTOR(1 downto 0);
				seg1 : out  STD_LOGIC_VECTOR (6 downto 0);
				an1 : out  STD_LOGIC_VECTOR (3 downto 0);
				dp1 : out STD_LOGIC
		);
	end component;
begin
	instseven: sevenseg Port map(
			clk1 => clk,
			digit0 => min1,
			digit1 => min0,
			digit2 => sec1,
			digit3 => sec0,
			decplace => "10",
			seg1 => seg,
			an1 => an,
			dp1 => dp
		);
	
	btnproc: process(btn)
	begin
		if rising_edge(btn) then
--		if counting = '0' then
--			sec0 <= x"0";
--			sec1 <= x"0";
--			min0 <= x"0";
--			min1 <= x"0";
--		end if;
			counting <= not counting;
		end if;
	end process;

	clkproc: process(clk)
	begin	
		if rising_edge(clk) and counting = '1' then
			counter <= counter + 1;		
			if counter = 50000000 then
				counter <= x"0000001";
				sec0 <= sec0 + 1;
			end if;
			
			if sec0 = x"A" then
				sec1 <= sec1 + 1;
				sec0 <= x"0";
			end if;
		
			if sec1 = x"6" then
				min0 <= min0 + 1;
				sec1 <= x"0";
			end if;
					
			if min0 = x"A" then
				min1 <= min1 + 1;
				min0 <= x"0";
			end if;
			
			if min1 = x"6" then
				min1 <= x"0";
			end if;
		end if;		
		
		
		
	end process;
	
end Behavioral;

