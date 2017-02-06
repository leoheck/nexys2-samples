----------------------------------------------------------------------------------
-- company:
-- engineer: duncan frost
--
-- create date:    10:52:14 01/08/2012
-- design name:
-- module name:    counter - behavioral
-- project name:
-- target devices:
-- tool versions:
-- description:
--
-- dependencies:
--
-- revision:
-- revision 0.01 - file created
-- additional comments:
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- uncomment the following library declaration if using
-- arithmetic functions with signed or unsigned values
--use ieee.numeric_std.all;

-- uncomment the following library declaration if instantiating
-- any xilinx primitives in this code.
--library unisim;
--use unisim.vcomponents.all;

entity counter is
	port (
		sw  : in   std_logic_vector (7 downto 0);
		led : out  std_logic_vector (7 downto 0);
		clk : in   std_logic
	);
end counter;

architecture rtl of counter is
	signal counter : std_logic_vector(29 downto 0) := (others => '0');
begin

	-- led output
	led <= counter(29 downto 22);

	clk_proc: process(clk, counter)
	begin
		if rising_edge(clk) then
			--increments the counter related to the number of switches used
			counter(29 downto 0) <= counter(29 downto 0)+sw(7 downto 0);
		end if;
	end process;

end rtl;
