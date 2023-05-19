----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M1 SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpt_tempo is
    port(
        clk, clk1, reset_n : in std_logic; 
        start : in std_logic;
        fin : out std_logic
    );
end cpt_tempo;

architecture archi of cpt_tempo is
signal cpt : integer range 0 to 600000 := 0;
--signal cpt_en, cpt_stop : std_logic := '0';
--signal cpt_en : std_logic := '0';
begin

process(clk, reset_n)
variable cpt_en : std_logic := '0'; --cpt enable
begin 
-- Reset Asynchrone
    if reset_n = '0' then 
        cpt <= 0;
        cpt_en := '0';
        fin <= '0';
    elsif rising_edge(clk) then
        if start = '1' or cpt_en = '1' then 
            cpt_en := '1';  
            fin <= '0';        
            if cpt_en = '1' then 
                cpt <= cpt + 1;
                if cpt = 600000 then 
                    fin <= '1'; 
                    cpt_en := '0';
                    cpt <= 0;
                end if;
            else 
                cpt <= 0;
                fin <= '0';
                cpt_en := '0';
            end if;
        else 
            cpt_en := '0';
            fin <= '1';
        end if;
    end if;
end process;

end archi;
