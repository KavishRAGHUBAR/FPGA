----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M) SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity TB_TOP_DCC is
--  Port ( );
end TB_TOP_DCC;

architecture Behavioral of TB_TOP_DCC is
signal clk100,reset_n,sortie_dcc : std_logic := '0';
signal interrupteur : std_logic_vector(7 downto 0);

-- Signaux de test bench
begin

Clk100 <= not Clk100 after 5 ns;
reset_n <= '0', '1' after 15 ns;

interrupteur <= "10000000", "010000000" after 1 us;

top : entity work.TOP_DCC
    port map(clk100, reset_n, interrupteur, sortie_dcc);

end Behavioral;
