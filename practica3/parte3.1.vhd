----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:52:31 11/11/2014 
-- Design Name: 
-- Module Name:    cla - Behavioral 
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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:53:48 11/10/2014 
-- Design Name: 
-- Module Name:    cpa - Behavioral 
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

entity cla is
  generic(g_width : natural := 64);
  port (ent1 : in std_logic_vector(g_width - 1 downto 0);
        ent2 : in std_logic_vector(g_width - 1 downto 0);
		sumas : out std_logic_vector(g_width downto 0));
end cla;

architecture rtl of cla is

signal p0  : std_logic_vector(g_width - 1 downto 0);
signal g0  : std_logic_vector(g_width - 1 downto 0);
signal p1  : std_logic_vector(g_width / 4 - 1 downto 0);
signal g1  : std_logic_vector(g_width / 4 - 1 downto 0);
signal p2  : std_logic_vector((g_width / 4) / 4 - 1 downto 0);
signal g2  : std_logic_vector((g_width / 4) / 4 - 1 downto 0);

signal cdummy : std_logic_vector(g_width / 4 - 1 downto 0);
signal cjerry : std_logic_vector(g_width / 4 - 1 downto 0);

signal cfrank : std_logic_vector(3 downto 0);
signal clenny : std_logic_vector(3 downto 0);


signal carry0 : std_logic_vector(g_width - 1 downto 0);
signal carry1 : std_logic_vector(g_width / 4 - 1 downto 0);
signal carry2 : std_logic_vector((g_width / 4) / 4 - 1 downto 0);
signal carry3 : std_logic_vector(0 downto 0);

constant c_uaa1 : natural := g_width / 4;
constant c_uaa2 : natural := c_uaa1 / 4;



component gp
  port (op1 : in std_logic;
        op2 : in std_logic;
        cin : in std_logic;
        g   : out std_logic;
        p   : out std_logic;
        add : out std_logic);
end component;

component uaa
  port(
       cin   : in std_logic;
       pin   : in std_logic_vector(3 downto 0);
       gin   : in std_logic_vector(3 downto 0);
       pout  : out std_logic;
       gout  : out std_logic;
       carry : out std_logic_vector(3 downto 0);
       cout  : out std_logic);
end component;

begin

sums : for i in 0 to g_width - 1 generate
  i_generate : gp port map (
        op1 => ent1(i),
		  op2 => ent2(i),
		  cin => carry0(i),
		  p => p0(i),
		  g => g0(i),
		  add => sumas(i));
end generate;

uaa_1 : for i in 0 to c_uaa1 - 1 generate
  i_uaa1 : uaa port map (
    cin => carry1(i),
    pin => p0(4 * i + 3 downto 4 * i),
    gin => g0(4 * i + 3 downto 4 * i),
    pout => p1(i),
    gout => g1(i),
    carry => carry0(4 * i + 3 downto 4 * i),
    cout => cdummy(i)
    );
end generate;

uaa_2 : for i in 0 to c_uaa2-1 generate
  i_uaa2 : uaa port map(
    cin => carry2(i),
    pin => p1(4 * i + 3 downto 4 * i),
    gin => g1(4 * i + 3 downto 4 * i),
    pout => p2(i),
    gout => g2(i),
    carry => carry1(4 * i + 3 downto 4 * i),
    cout => cjerry(i)
    );
end generate;

cfrank <= "0000" or p2;
clenny <= "0000" or g2;

i_uaa3 : uaa port map(
    cin => carry3(0),
    pin => cfrank,
    gin => clenny,
    --pout => cdummy(0),
    --gout => cdummy(1),
    carry => carry2(3 downto 0),
    cout => sumas(g_width)
    );
end rtl;



