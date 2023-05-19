----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M1 SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Compteur_Tempo is
--  Port ( );
end TB_Compteur_Tempo;

architecture Behavioral of TB_Compteur_Tempo is
Signal  Clk 		:  STD_LOGIC;		-- Horloge 100 MHz
Signal  Reset 		:  STD_LOGIC;		-- Reset Asynchrone
Signal  Clk1M 		:  STD_LOGIC;		-- Horloge 1 MHz
Signal  Start_Tempo	:  STD_LOGIC;		-- Commande de Demarrage de la Temporisation
Signal  Fin_Tempo	:  STD_LOGIC;		-- Drapeau de Fin de la Temporisation
constant CLK_PER_1M : time := 1 us; --periode de l'hologe 1 MHz
constant CLK_PER_100M : time := 10 ns; --periode de l'hologe 100 MHz
begin
Compteur_Tempo: entity work.Compteur_Tempo
port map(   clk => Clk,
          reset_n => Reset,
          clk1 => Clk1M,
          start => Start_Tempo,
          fin => Fin_Tempo);
         
Reset <= '0', '1' after 150 ns;

--Clock process
clock_1M : process
          begin
            Clk1M <= '0';
            wait for CLK_PER_1M/2;
            Clk1M <= '1';
            wait for CLK_PER_1M/2;
end process clock_1M;

clock_100M : process
          begin
            Clk <= '0';
            wait for CLK_PER_100M/2;
            Clk <= '1';
            wait for CLK_PER_100M/2;
end process clock_100M;

Start_Tempo <= '0', '1' after 250 ns, '0' after 600 ns;

end Behavioral;
