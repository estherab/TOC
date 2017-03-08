----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:
-- Design Name: 
-- Module Name:    unidad de control
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

entity uc is
    port ( control : out  std_logic_vector (3 downto 0); -- Vamos a instanciar una señal que almacene las señales de mem_ld, cntr_ld, puntuacion_ld
           punt : in  std_logic_vector (9 downto 0); -- Señal que contiene la puntuacion total(9,8,7,6,5,4) y la puntuacion parcial/valor carta(3,2,1,0)
		   carta_pregunta : in  std_logic_vector (3 downto 0);
		   clk, inicio, jugar, plantarse, rst_n : in std_logic;
		   pierdo, carta_error, espera: out std_logic);
end uc;

architecture Behavioral of uc is
	type estados is (s0, s1,s2, s3, s4, s5, s6, s7);
	signal estado_actual, siguiente_estado: Estados;
	
	signal control_aux: std_logic_vector(3 downto 0);
		alias cntr_ld : std_logic is control_aux(0);
		alias puntuacion_ld : std_logic is control_aux(1);
		alias mem_ld : std_logic is control_aux(2);
		alias puntuacion_parcial_ld :  std_logic is control_aux(3);
	
	signal punt_aux: std_logic_vector (9 downto 0);
		
begin
	punt_aux <= punt;

	proceso_sincrono: process (clk, rst_n)
	begin
		if (rst_n ='1') then 
			estado_actual <= s1;
		elsif rising_edge(clk) then 
			estado_actual <= siguiente_estado;
		end if;
	end process proceso_sincrono;

	proceso_calculoEstado: process (estado_actual, inicio)
	begin

		cntr_ld <= '1';
		puntuacion_ld <= '0';
		mem_ld <= '0';
		puntuacion_parcial_ld <= '0';
		espera <= '0';
		case estado_actual is
         when s0 => -- en el estado s1 da error al cargar siguiente estado a si mismo por lo que llamo a s0 y de ahi a s1
            siguiente_estado <= s1;
			when s1 => -- Espera hasta que inicio = 1
				espera <= '1';
				if (inicio = '1') then
					carta_error <= '0';
					espera <= '0';

					pierdo <= '0';
					siguiente_estado <= s3;
				else
					siguiente_estado <= s0;
				end if;
			when s2 =>--en el estado s3 da error al cargar siguiente estado a si mismo por lo que llamo a s2 y de ahi a s3			
			siguiente_estado <= s3;
            
			when s3 => -- Estado en el que o se planta o pide una carta
				if (plantarse = '0') then
					siguiente_estado <= s1;
				elsif (jugar = '0') then
						cntr_ld <= '0';
						siguiente_estado <= s4;
					else 
						siguiente_estado <= s2;
				end if;
			when s4 => --vacio para poder cargar la puntuacion en el registro ya que el dato sacado de la memoria s3 tarda un ciclo
					
					cntr_ld <= '0';
					siguiente_estado <= s6;
					
			when s5 => -- Estado vacío que vuelve a comprobar la puntuacion
                 --cntr_ld <= '0';
				siguiente_estado <= s7;
			when s6 => -- Comprueba la carta
				if carta_pregunta = "0000" then
					carta_error <= '1';
					siguiente_estado <= s3;
				else
					 puntuacion_ld <= '1';

					puntuacion_parcial_ld <= '1';
					carta_error <= '0';
					mem_ld <= '1';
					siguiente_estado <= s5;
				end if;
			when s7 => --Comprueba la puntuacion
				if punt_aux (5 downto 0) <= "010101" then
					siguiente_estado <= s3;
				else
					pierdo <=  '1';
					siguiente_estado <= s1;
				end if;
		end case;
	end process proceso_calculoEstado;
	
	control <= control_aux;
end Behavioral;