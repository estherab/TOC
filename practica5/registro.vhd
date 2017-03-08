----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:  
-- Design Name: 
-- Module Name:    Registro
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
-------------------------------------------------------------------------------------
	-- Este registro lo usamos dos veces, una para registro_contador que almacena la puntuacion que va llevando el contador
	-- y la otra para registro_puntuacion que almacena la puntuacion acumulada por el jugador, esto es posible hacerlo porque los dos 
	--registros tienen distintas vidas
-------------------------------------------------------------------------------------
entity registro is
    port ( entrada : in  std_logic_vector (5 downto 0);
           salida : out  std_logic_vector (5 downto 0);
           load, clk, rst_n : in  std_logic);
end registro;

architecture Behavioral of registro is

begin
	cargar_registro: process(clk, rst_n, load, entrada)
	begin
		if rst_n ='1' then 
			salida <= (others =>'0');
		elsif (clk'event and clk ='1' and load ='1')then
			salida<=entrada;
		end if;
	end process cargar_registro;
end Behavioral;