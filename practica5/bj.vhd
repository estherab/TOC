----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    bj
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bj is
    port ( rst_n : in  std_logic;
           clk : in  std_logic;
           inicio : in  std_logic;
           jugar : in  std_logic;
           plantarse : in  std_logic;
           pierdo : out  std_logic;
		     espera, carta_error, reloj : out std_logic;
		     puntuacion : out  std_logic_vector (13 downto 0);
			  puntuacion_parcial : out std_logic_vector(6 downto 0));
end bj;

architecture Behavioral of bj is

	component divisor 
		port (
		rst_n        : in  std_logic;         -- asynch reset
		clk_entrada : in  std_logic;         -- 100 MHz input clock
		clk_salida   : out std_logic          -- 1 Hz output clock
		);
	end component divisor;

	component uc
    port ( control : out  std_logic_vector (3 downto 0);
           punt : in  std_logic_vector (9 downto 0);
		   carta_pregunta : in std_logic_vector (3 downto 0);
			  clk, inicio, jugar, plantarse, rst_n : in std_logic;
			  pierdo, carta_error, espera: out std_logic);
	end component uc;
	
	component cd
    port ( control : in  std_logic_vector (3 downto 0);
           punt : out  std_logic_vector (9 downto 0);
			  clk, rst_n: in std_logic);
	end component cd;
	
	signal punt_aux : std_logic_vector (9 downto 0);
	signal control_aux : std_logic_vector (3 downto 0);
	signal carta_pregunta : std_logic_vector (3 downto 0);
	signal clk_1hz : std_logic;

begin
   

     divisor1 : divisor port map (rst_n, clk, clk_1hz);
	   reloj <= clk_1hz;
	 --comentar para fpga
	 control1 : uc port map (control_aux, punt_aux, carta_pregunta, clk, inicio, jugar, plantarse, rst_n, pierdo, carta_error, espera);	
	 rutaDatos1 : cd port map (control_aux, punt_aux, clk, rst_n);

	 --descomentar para fpga

	 --control1 : uc port map (control_aux, punt_aux, carta_pregunta, clk_1hz, inicio, jugar, plantarse, rst_n, pierdo, carta_error, espera);
	 --rutaDatos1 : cd port map (control_aux, punt_aux, clk_1hz, rst_n);

	with punt_aux(5 downto 0) select puntuacion <= "00000000000110" when "000001",
	"00000001011011" when "000010", "00000001001111" when "000011", "00000001100110" when "000100",--4
	"00000001101101" when "000101", "00000001111100" when "000110", "00000000000111" when "000111",--7
	"00000001111111" when "001000", "00000001100111" when "001001", "00001100111111" when "001010",--10
	"00001100000110" when "001011", "00001101011011" when "001100", "00001101001111" when "001101",--13
	"00001101100110" when "001110", "00001101101101" when "001111", "00001101111100" when "010000",--16
	"00001100000111" when "010001", "00001101111111" when "010010", "00001101100111" when "010011",--19
	"10110110111111" when "010100", "10110110000110" when "010101", "10110111011011" when "010110",--22
	"10110111001111" when "010111", "10110111100110" when "011000", "10110111101101" when "011001",--25
	"10110111111100" when "011010", "10110110000111" when "011011", "10110111111111" when "011100",--28
	"10110111100111" when "011101", "10011110111111" when "011110", "00000000000000" when others;

	with punt_aux (9 downto 6) select puntuacion_parcial <= "0000110" when "0001",
	"1011011" when "0010", "1001111" when "0011", "1100110" when "0100", "1101101" when "0101",
	"1111100" when "0110", "0000111" when "0111", "1111111" when "1000", "1100111" when "1001",
	"0111111" when "1010", "1111001" when others;
	
end Behavioral;

