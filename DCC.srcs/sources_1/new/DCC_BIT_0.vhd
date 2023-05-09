----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Engineer: Raghubar et Dauvet
-- 
-- Create Date: 06.03.2023 13:37:04
-- Design Name: 
-- Module Name: DCC_BIT_0 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DCC_BIT_0 is
    Port ( Clk_1M : in std_logic; --horloge 1M
           Clk_100M : in std_logic; --horloge 100 M
           Reset : in STD_LOGIC;-- Reset Asynchrone
           GO_0 : in STD_LOGIC; --commnde go
           FIN_0 : out STD_LOGIC;--commande fin
           DCC_0 : out STD_LOGIC); --ce qui va repr?senter bit 0
end DCC_BIT_0;

architecture Behavioral of DCC_BIT_0 is
signal start, done_low, done_high : std_logic;
signal cpt    : std_logic_vector(6 downto 0);	--maintient ?  '0' ou ? '1' 
--calcul du delay '0' puis '1' qu'on utilisera dans un process sensible ? 1us

--on pourra utiliser un compteur delay pour la dur?e ? 0 et la dur?e ? 1
--on impl?mentera une mini MAE afin de prendre en compte tous les cas possibles

--MAE : type enum?r?
type etat is (INIT, E_BAS, E_HAUT); --init on ne fait rien, E_Bas -> DCC bit ? 0, E_Haut -> DCC bit ? 1
signal EP, EF : etat;
 
begin
process (Clk_1M,Clk_100M, Reset)
begin
    if (Reset = '1') then
        EP <= INIT;
    elsif (rising_edge(Clk_1M) ) then
        EP <= EF;
--        cpt <= cpt +1;
--        if (cpt = 100) then
--        cpt <= 0;
--            if (dcc_sig = '1') then 
--                FIN_0 <= '1';
--            end if;
--        dcc_sig <= not(dcc_sig);
--        end if;
    end if;
end process;

process(EP, GO_0, done_low, done_high)
begin
    case(EP) is
        when INIT => EF <= INIT; if GO_0 = '1' then EF <= E_BAS; end if;
        when E_BAS => EF <= E_BAS; if done_low = '1' then EF <= E_HAUT; end if;
        When E_HAUT => EF <= E_HAUT; if done_high = '1' then EF <= INIT; end if;
        end case;
end process;

--Sorties en fonction de l'?tat pr?sent
--process(EP,Clk_100M)
--begin
--    case (EP) is 
--        when INIT => DCC_0 <= '0'; start <= '0';
--        when E_BAS => DCC_0 <= '0'; start <= '1';
--        when E_HAUT => DCC_0 <= '1'; start <= '1';
--    end case;
--end process;
--en concurrent ?a marche mieux
DCC_0 <= '0' when EP = INIT else
         '0' when EP = E_BAS else
         '1' when EP = E_HAUT else '0';
start <= '0' when EP = INIT else
         '1'; -- dans les autre ?tats on veut que start soit ? 1 afin  d'incr?menter cpt

--process pour le compteur de 58 ?s
process (Clk_1M, start, cpt)
begin
   -- if GO_0 = '1' then start
    if start = '0' then 
        cpt <= "0000000"; 
        done_low <= '0';
        done_high <= '0';
        FIN_0 <= '0';
     elsif (rising_edge(Clk_1M) and start = '1') then
        cpt <= cpt + '1';
     end if;   
     
     if cpt = "0110010" then
     done_low <= '1';
     end if;
     
     if cpt = "1100100" then 
     done_high <= '1';
     FIN_0 <= '1'; -- on est arriv? ? la fin du cycle
     end if;
end process;
-- make a test bench to check the duration of a bit 0 transmission
end Behavioral;