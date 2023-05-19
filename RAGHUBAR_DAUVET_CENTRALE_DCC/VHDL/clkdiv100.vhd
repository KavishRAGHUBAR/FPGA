----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M1 SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------
--CLK 1 MHz : 100 MHz/100

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clkdiv100 is
    port(
        clk, reset_n : in std_logic; 
        clkout : out std_logic --CLK 1 MHz
        ); 

end clkdiv100;

architecture Behavioral of clkdiv100 is
signal cpt : integer range 0 to 50;
signal tmp : std_logic := '0';

begin

process(clk, reset_n)
begin 
-- Reset Asynchrone
    if reset_n = '0' then 
        cpt <= 0;
        tmp <= '0';
        -- A Chaque Front montant d'Horloge
    elsif rising_edge(clk) then 
        cpt <= cpt + 1; -- Incrementation du Compteur
        if cpt = 50 then   
            tmp <= not tmp; -- Inversion du Signal d'Horloge Tous les 50 Cycles
            cpt <= 0;
        end if;
    end if;
end process;

--donc sur 100 cycles nous avons 1 periode d'horloge
clkout <= tmp; -- Affectation du Port de Sortie hors process

end Behavioral;
