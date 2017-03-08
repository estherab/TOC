----------------------------------------------------------------------------------
-- Company: UCM
-- Engineer: Inmaculada Pardines
-- 
-- Create Date:    15:03:54 10/22/2012 
-- Design Name: 
-- Module Name:    FSM_muneca - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Diseño de control del funcionamiento de una muñeca
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity FSM_munyeca is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           R : in  STD_LOGIC;
           C : in  STD_LOGIC;
           G : out  STD_LOGIC;
           L : out  STD_LOGIC);
end FSM_munyeca;

architecture Behavioral of FSM_munyeca is

type ESTADOS is (tranquila_st,habla_st,dormida_st,asustada_st,ps_tranquila_st);

signal estado_actual, estado_sig: ESTADOS;
signal rst_cont:std_logic;
signal cuenta_reg:std_logic_vector(1 downto 0);

component contador_mod_K is
	generic (K: integer := 4; N: integer := 2);
-- K < 2**N
	port (rst, clk: in std_logic;
	S: out std_logic_vector(N-1 downto 0));
end component;


begin

mod_contador_i: contador_mod_K port map(rst_cont,clk,cuenta_reg);

p_sincrono: process(clk,rst)
begin
if rst = '1' then
	estado_actual <= tranquila_st;
elsif clk'event and clk = '1' then
	estado_actual <= estado_sig;
end if;
end process;

p_comb: process(R,C,estado_actual,cuenta_reg)
begin
G <= '0';
L <= '0';
rst_cont <= '1';
case estado_actual is
	when tranquila_st =>
		rst_cont <= '0';
		if cuenta_reg = "11" then
			estado_sig <= ps_tranquila_st;
		else
			estado_sig <= tranquila_st;
		end if;
		
	when ps_tranquila_st =>
		if (C = '1' and R = '0') then
			estado_sig <= dormida_st;
		elsif(C = '0' and R = '1') then
			estado_sig <= habla_st;
		else
			estado_sig <= ps_tranquila_st;
		end if;

	when habla_st =>
		G <= '1';
		if C = '1' then
			estado_sig <= dormida_st;
		else
			estado_sig <= habla_st;
		end if;
	when dormida_st =>
		if R = '1' then
			estado_sig <= asustada_st;
		else
			estado_sig <= dormida_st;
		end if;
	when asustada_st =>
		L <= '1';
		if C = '1' and R = '0' then
			estado_sig <= dormida_st;
		elsif C = '0' and R = '0' then
			estado_sig <= tranquila_st;
		else
			estado_sig <= asustada_st;
		end if;
end case;
end process;

end Behavioral;

