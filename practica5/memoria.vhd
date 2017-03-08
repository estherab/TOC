----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:38:26 12/10/2014 
-- Design Name: 
-- Module Name:    memoria - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoria is
    Port ( clka : in  std_logic;
           wea : in  std_logic;
           addra : in  STD_LOGIC_VECTOR (5 downto 0);
           dina : in  STD_LOGIC_VECTOR (3 downto 0);
           douta : out  STD_LOGIC_VECTOR (3 downto 0));
end memoria;

architecture Behavioral of memoria is
	type ram_type is array (0 to 63) of std_logic_vector (3 downto 0);
	signal RAM : ram_type:= (X"1", X"2", X"3", X"4", X"5", X"6",X"7", X"8", X"9", X"A", X"A", X"A", X"A",
									X"1", X"2", X"3", X"4", X"5", X"6",X"7", X"8", X"9", X"A", X"A", X"A", X"A",
									X"1", X"2", X"3", X"4", X"5", X"6",X"7", X"8", X"9", X"A", X"A", X"A", X"A",
									X"1", X"2", X"3", X"4", X"5", X"6",X"7", X"8", X"9", X"A", X"A", X"A", X"A",
									X"0", X"0",X"0",X"0",X"0",X"0",X"0",X"0",X"0",X"0",X"0",X"0");
begin
	memory_update: process (clka) 
	begin
		if rising_edge(clka) then 
			if wea = '1' then
				RAM(conv_integer(addra)) <= dina; 
			else
				douta <= RAM(conv_integer(addra)); 
			end if;
		end if;
	end process memory_update;
end Behavioral;

