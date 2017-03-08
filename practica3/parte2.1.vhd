----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:21:59 11/11/2014 
-- Design Name: 
-- Module Name:    cpa - Behavioural 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity cpa is
   generic (g_width : natural := 32);
   port (
      cin   :  in std_logic;
      op1   :  in std_logic_vector (g_width - 1 downto 0);
      op2   :  in std_logic_vector (g_width - 1 downto 0);
      add   :  out std_logic_vector (g_width - 1 downto 0);
      cout  :  out std_logic);
end cpa;

architecture behavioural of cpa is
   component fa
      port(op1   : in std_logic;
           op2   : in std_logic;
           cin   : in std_logic;
           cout  : out std_logic;
           sum   : out std_logic);
   end component;
   
   signal carry : std_logic_vector(g_width downto 0);
         
begin
   --carry(0) <= '0';
   carry(0) <= cin;
   p_cpa : for i in 0 to g_width - 1 generate
   i_fa : fa port map (
                        op1 => op1(i),
                        op2 => op2(i),
                        cin => carry(i),
                        sum => add(i),
                        cout => carry(i + 1));
   end generate p_cpa;
end behavioural;

