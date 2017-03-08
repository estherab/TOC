----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    camino de datos
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
use ieee.std_logic_ARITH.all;
use ieee.std_logic_UNSIGNED.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use ieee.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cd is
    port ( control : in  std_logic_vector (3 downto 0); 
           punt : out  std_logic_vector (9 downto 0);-- Necesitamos un vector de salida de 10 bits para representar la puntuacion (6bits) y el valor de la carta (4bits)
			clk, rst_n: in std_logic);
end cd;

architecture Behavioral of cd is

	component registro -------------------------------------------------------------------------------
    port ( entrada : in  std_logic_vector (5 downto 0);
           salida : out  std_logic_vector (5 downto 0);
           load, clk, rst_n : in  std_logic);
	end component registro;
	-------------------------------------------------------------------------------
	
	component memoria
    port ( clka : in  std_logic;
           wea : in  std_logic; -- load
           addra : in  std_logic_vector (5 downto 0); -- direccion
           dina : in  std_logic_vector (3 downto 0); -- dato de entradda
           douta : out  std_logic_vector (3 downto 0)); -- dato salida
	end component memoria;
	--------------------------------------------------------------------------mirar
	signal control_aux: std_logic_vector(3 downto 0);
		alias cntr_ld : std_logic is control_aux(0);
		alias puntuacion_ld : std_logic is control_aux(1);
		alias mem_ld : std_logic is control_aux(2);
		alias puntuacion_parcial_ld : std_logic is control_aux(3);
		--------------------------------------------------------------------mirar
	
	signal punt_aux: std_logic_vector (9 downto 0);-- En esta señal guardamos la puntuacion y el valor de la carta
	
	signal aux_contador, r_contador, r_puntuacion, aux_puntuacion,r_puntuacion_parcial, aux_puntuacion_parcial: std_logic_vector (5 downto 0);-- 6bits por la puntuacion
	signal aux_memoria: std_logic_vector (3 downto 0);--Valor de la carta
	--signal aux_contador_parcial : std_logic_vector (3 downto 0);-- Valor de la carta
begin
	
	control_aux <= control;
	
	-----------------------------------------------------
				--Contador
	-----------------------------------------------------
	
	proceso_sincrono: process (clk, rst_n)
	begin
		if rising_edge(clk) then 
			if aux_contador = "110011" then-- Si llegamos a 21 (puntuacion), reseteamos el contador (aunque no se resetea realmente hasta que no apaguemos la placa)
				r_contador <= "000000";
			else
				r_contador <= (aux_contador + "000001");
			end if;
		else 
			
		end if;
	end process proceso_sincrono;

	--with cntr_ld select punt_aux (9 downto 6) <= aux_memoria when '0', aux_contador_parcial when others;
	--entrada/salida/load/clk/reset
		-- Nos entra la cuenta en el registro_contador y nos saca lo mismo(aux_contador)en el caso de que el reset sea 0
	registro_contador: registro port map(r_contador, aux_contador, cntr_ld, clk, rst_n); 

	
	
	------------------------------------------------------------------------------------------------------------------
	memoria_ram: memoria port map (clk, mem_ld, aux_contador, "0000", aux_memoria);------------------------memoria
	-----------------------------------------------------------
	
	----------------------------NUEVOOOOOOOOOO--------------
	r_puntuacion_parcial <= "00"&aux_memoria; --El valor de la carta que sale de memoria(aux_memoria(4))se lo metemos al registro r_puntuacion_parcial(6) con dos ceros delante para que sea de 6bits 
	regist_puntuacion_parcial : registro port map (r_puntuacion_parcial, aux_puntuacion_parcial, puntuacion_parcial_ld, clk, rst_n);
	--------------------------------------------------HASTA AQUI NUEVO
	
	
	--El valor de la carta (aux_puntuacion_parcial) lo almacenamos en los 4 bits (9,8,7,6) de la variable auxiliar de la puntuacion(punt_aux)
	punt_aux(9 downto 6) <= aux_puntuacion_parcial(3 downto 0);
	
	-- Sumamos el valor de carta (aux_memoria) con la puntuacion que lleva el jugador (aux_puntuacion)
	
	
	r_puntuacion <= aux_puntuacion_parcial + aux_puntuacion;
	
	
	--Almacenamos la puntuacion resultante (r_puntuacion) en un auxiliar(aux_puntuacion), mientras reset sea cero
	registro_puntuacion: registro port map (r_puntuacion, aux_puntuacion, puntuacion_ld, clk, rst_n);
	-- En la variable auxiliar de la puntuacion total almacenamos los puntos que lleva el jugador
	punt_aux(5 downto 0) <= r_puntuacion;
	--Almacenamos el auxiliar en la principal
	punt <= punt_aux;

end Behavioral;

