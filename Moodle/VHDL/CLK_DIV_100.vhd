----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M) SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------
--CLK 1 MHz : 100 MHz/100

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clkdiv100 is
    port(
        clk, reset_n : in std_logic; 
        clkout : out std_logic
        ); 

end clkdiv100;

architecture Behavioral of clkdiv100 is
signal cpt : integer range 0 to 50;
signal tmp : std_logic := '0';

begin

process(clk, reset_n)
begin 
    if reset_n = '0' then 
        cpt <= 0;
        tmp <= '0';
    elsif rising_edge(clk) then 
        cpt <= cpt + 1;
        if cpt = 50 then 
            tmp <= not tmp;
            cpt <= 0;
        end if;
    end if;
end process;

clkout <= tmp;

end Behavioral;
