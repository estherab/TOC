----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:42:42 9/12/2014 
-- Design Name: 
-- Module Name:    adder - rtl 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity adder is

generic (g_width : natural := 16);
   port (cin : in std_logic;
         op1 : in std_logic_vector(g_width - 1 downto 0);
         op2 : in std_logic_vector(g_width - 1 downto 0);
         add : out std_logic_vector(g_width downto 0));
end adder;

architecture rtl of adder is

begin
	add <= std_logic_vector(unsigned('0' & op1) + unsigned('0' & op2) + unsigned'(0 => cin));
end rtl;

