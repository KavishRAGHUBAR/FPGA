----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M1 SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mae is
    port(
        clk, reset_n : in std_logic;
        registre_dcc : in std_logic;
        fin0, fin1, fin_tempo : in std_logic;
        go0, go1, start_tempo, com, reg : out std_logic
        
        );
end mae;

architecture Behavioral of mae is

type etat is (load, shift, compare, bit0, bit1, wait0, wait1, tempo, wait_tempo);
signal EP, EF : etat;

signal cpt50 : std_logic := '0';
signal cpt : integer range 0 to 50 := 0;
signal cpt_inc : std_logic := '0';

begin

-- succession des etats
process(clk, reset_n, EP)
begin 
    if reset_n = '0' then 
        EP <= load; -- Si la ligne de reset est active, on va au premier etat.
    elsif rising_edge(clk) then -- Si le front montant de l'horloge est detecte, on passe a l'etat suivant.
        EP <= EF;
    end if;
    
    case EP is -- On utilise une instruction case pour determiner l'etat actuel et le prochain etat a atteindre.
        when load => EF <= shift; -- On passe a l'etat shift pour lire les bits du registre.
        when shift => EF <= compare; -- On passe a l'etat compare pour verifier si le bit lu est egal a 0 ou 1.
        when compare => EF <= bit0; -- Si le bit est 0, on passe a l'etat bit0, sinon on passe a l'etat bit1.
            if registre_dcc = '1' then EF <= bit1; end if; -- Si le bit est 1, on passe a l'etat bit1.
        when bit0 => EF <= wait0; -- On attend un certain temps avant de passer a l'etat suivant.
        when bit1 => EF <= wait1; -- On attend un certain temps avant de passer a l'etat suivant.
        when wait0 => EF <= wait0; -- Si le temps n'est pas ecoule, on reste dans l'etat wait0.
            if fin0 = '1' and cpt50 = '1' then 
                EF <= tempo; -- Si on a atteint la fin de la transmission, on passe a l'etat tempo.
            elsif fin0 = '1' and cpt50 = '0' then 
                EF <= shift; -- Si on a atteint la fin d'un octet, on passe a l'etat shift.
            end if;
            
        when wait1 => EF <= wait1; -- Si le temps n'est pas ecoule, on reste dans l'etat wait1.
            if fin1 = '1' and cpt50 = '1' then 
                EF <= tempo; -- Si on a atteint la fin de la transmission, on passe a l'etat tempo.
            elsif fin1 = '1' and cpt50 = '0' then 
                EF <= shift; -- Si on a atteint la fin d'un octet, on passe a l'etat shift.
            end if;
            
        when tempo => EF <= wait_tempo; -- On attend un certain temps avant de passer a l'etat suivant.
        
        when wait_tempo => EF <= wait_tempo; -- Si le temps n'est pas ecoule, on reste dans l'etat wait_tempo.
            if fin_tempo = '1' then EF <= load; end if; -- Si le temps est ecoule, on revient a l'etat load pour attendre une nouvelle transmission.
    end case;
end process;

-- generation des sorties
process(EP)
begin 
       case EP is 
        when load => 
            reg <= '1';
            com <= '0';
            start_tempo <= '0';
            go0 <= '0';
            go1 <= '0';
            cpt_inc <= '0';
                       
        when shift => 
            reg <= '0';
            com <= '1';
            start_tempo <= '0';
            go0 <= '0';
            go1 <= '0';
            cpt_inc <= '1';

                   
        when compare => 
            reg <= '0';
            com <= '0';
            start_tempo <= '0';
            go0 <= '0';
            go1 <= '0';
            cpt_inc <= '0';
            
             
        when bit0 => 
            reg <= '0';
            com <= '0';
            start_tempo <= '0';
            go0 <= '1';
            go1 <= '0';  
            cpt_inc <= '0';
                                    
        when bit1 => 
            reg <= '0';
            com <= '0';
            start_tempo <= '0';
            go0 <= '0';
            go1 <= '1';
            cpt_inc <= '0';
         
        when wait0 => 
            reg <= '0';
            com <= '0';
            start_tempo <= '0';
            go0 <= '0';
            go1 <= '0';  
            cpt_inc <= '0';
                        
        when wait1 => 
            reg <= '0';
            com <= '0';
            start_tempo <= '0';
            go0 <= '0';
            go1 <= '0';
            cpt_inc <= '0';
       
        when tempo => 
            reg <= '0';
            com <= '0';
            start_tempo <= '1';
            go0 <= '0';
            go1 <= '0';
            cpt_inc <= '0';
             
        when wait_tempo => 
            reg <= '0';
            com <= '0';
            start_tempo <= '0';
            go0 <= '0';
            go1 <= '0';
            cpt_inc <= '0';
                   
        when others => 
            reg <= '0';
            com <= '0';
            start_tempo <= '0';
            go0 <= '0';
            go1 <= '0';
            cpt_inc <= '0';
    end case;
end process;

process(reset_n, cpt_inc) 
begin 
    if reset_n = '0' then 
        cpt <= 0;
        cpt50 <= '0';
    elsif rising_edge(cpt_inc) then 
        cpt <= cpt + 1;
        if cpt = 50 then 
            cpt <= 0;
            cpt50 <= '1';
        else 
            cpt50 <= '0';
        end if;
    end if;

end process;

end Behavioral;
