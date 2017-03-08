----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:16:51 11/11/2014 
-- Design Name: 
-- Module Name:    fa - Behavioral 
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

entity fa is
   port(op1   : in std_logic;
        op2   : in std_logic;
        cin   : in std_logic;
        cout  : out std_logic;
        sum   : out std_logic); 
end fa;

architecture beh of fa is
         
begin
   sum <= (op1 xor op2) xor cin;
   cout <= (op1 and op2) or (cin and op1) or (cin and op2);
end architecture;
   


