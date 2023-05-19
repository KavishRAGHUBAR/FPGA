----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M1 SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DCC_Bit_1 is
    port(
        clk_1MHz, clk_100MHz, reset : in std_logic;
        go_1 : in std_logic;
        fin_1 : out std_logic;
        dcc_1 : out std_logic
    );
end DCC_Bit_1;

architecture Behavioral of DCC_Bit_1 is

type etat is (idle, zero, un);
signal EP, EF : etat;

signal fin : std_logic := '1';

signal cpt0 : integer range 0 to 200 := 0;
signal cpt1 : integer range 0 to 200 := 0;

signal cpt0_en : std_logic; --enable
signal cpt1_en : std_logic;

signal cpt0_end : std_logic;
signal cpt1_end : std_logic;

begin

-----------------------------------------------------
-- MAE
-----------------------------------------------------

-- sucessions des etats
process(reset, clk_100MHz, EP)
begin
    -- Reset Asynchrone
    if reset = '0' then 
        EF <= idle;
    elsif rising_edge(clk_100MHz) then 
        EP <= EF; -- On sauvegarde l'etat precedent dans EP a chaque front montant de l'horloge
    end if;

    case(EP) is 
        when idle   => EF <= idle;
            if go_1 = '1' then EF <= zero; end if; -- Si go_1 est actif, on passe a l'etat zero
        when zero   => EF <= zero; 
            if cpt0_end = '1' then EF <= un; end if; -- Si cpt0_end est actif, on passe a l'etat un
        when un     => EF <= un;
            if cpt1_end = '1' then EF <= idle; end if;  -- Si cpt1_end est actif, on retourne a l'etat idle
    end case;

end process;

-- generation des sorties
process(EP)
begin 
    if EP = idle then 
        dcc_1 <= '0';
        fin <= '1'; 
        cpt0_en <= '0';
        cpt1_en <= '0';
        
    elsif EP = zero then 
        dcc_1 <= '0';
        fin <= '0';
        cpt0_en <= '1';
        cpt1_en <= '0';
        
    elsif EP = un then 
        dcc_1 <= '1';
        fin <= '0';
        cpt0_en <= '0';
        cpt1_en <= '1';
        
    else 
        dcc_1 <= '0';
        fin <= '0';
        cpt0_en <= '0';
        cpt1_en <= '0';
        
    end if;
end process;

-----------------------------------------------------
-- Compteur 0
-----------------------------------------------------
process(clk_1MHz)
begin     
    if rising_edge(clk_1MHz) then 
        if cpt0_en = '1' then 
            cpt0 <= cpt0 + 1;
            if cpt0 = 29 then 
                cpt0_end <= '1'; 
                cpt0 <= 0;
            end if;
        else 
            cpt0_end <= '0';
            cpt0 <= 0;
        end if;
    end if;
end process;


-----------------------------------------------------
-- Compteur 1
-----------------------------------------------------
process(clk_1MHz)
begin     
    if rising_edge(clk_1MHz) then 
        if cpt1_en = '1' then 
            cpt1 <= cpt1 + 1;
            if cpt1 = 29 then 
                cpt1_end <= '1'; 
                cpt1 <= 0;
            end if;
        else 
            cpt1_end <= '0';
            cpt1 <= 0;
        end if;
    end if;
end process;

fin_1 <= fin and not(go_1);
end Behavioral;
