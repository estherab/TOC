----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:41:00 11/11/2014 
-- Design Name: 
-- Module Name:    uaa - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity uaa is
port(
   cin : in std_logic;
   pin : in std_logic_vector(3 downto 0);
   gin : in std_logic_vector(3 downto 0);
   pout : out std_logic;
   gout : out std_logic;
   carry : out std_logic_vector(3 downto 0);
   cout : out std_logic);
end entity uaa;

architecture Behavioral of uaa is

begin
  gout <= gin(3) or (pin(3) and gin(2)) or (pin(3) and pin(2) and gin(1)) or (pin(3) and pin(2) and pin(1) and gin(0));
  pout <= pin(3) and pin(2) and pin(1) and pin(0);
  
  cout <= gin(3) or (pin(3) and gin(2)) or (pin(3) and pin(2) and gin(1)) or (pin(3) and pin(2) and pin(1) and gin(0)) or (pin(3) and pin(2) and pin(1) and pin(0) and cin);
 
  carry(0) <= cin;
  carry(1) <= gin(0) or (pin(0) and cin);
  carry(2) <= gin(1) or (pin(1) and gin(0)) or (pin(1) and pin(0) and cin);
  carry(3) <= gin(2) or (pin(2) and gin(1)) or (pin(2) and pin(1) and gin(0)) or (pin(2) and pin(1) and pin(0) and cin);
end Behavioral;

