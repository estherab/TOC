-------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:53:37 10/13/2014 
-- Design Name: 
-- Module Name:    divisor - Behavioral 
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
USE IEEE.std_logic_unsigned.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divisor is
	port (
        rst_n: in STD_LOGIC;
        clk_entrada: in STD_LOGIC; -- reloj de entrada de la entity superior
        clk_salida: out STD_LOGIC -- reloj que se utiliza en los process del programa principal
        );
end divisor;

architecture Behavioral of divisor is

	SIGNAL cuenta: std_logic_vector(25 downto 0);
	SIGNAL clk_aux: std_logic;

begin

  clk_salida<=clk_aux;
  contador : PROCESS(rst_n, clk_entrada)
	BEGIN
		IF (rst_n='1') THEN
			cuenta<= (OTHERS=>'0');
			clk_aux<='0';
		ELSIF(clk_entrada'EVENT AND clk_entrada='1') THEN
			IF (cuenta="11111111111111111111111111") THEN 
				clk_aux <= not clk_aux;
				cuenta<= (OTHERS=>'0');
			ELSE
				cuenta <= cuenta+'1';
				clk_aux<=clk_aux;
			END IF;
		END IF;
	END PROCESS contador;

end Behavioral;