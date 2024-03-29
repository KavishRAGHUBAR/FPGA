----------------------------------------------------------------------------------
-- Company: 
-- Engineer:
-- 
-- Create Date:
-- Design Name: 
-- Module Name: REG_DCC - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_DCC is
    Port (
        -- Synchronisation
        CLK_100MHz: in std_logic;
        RESET: in std_logic;
        
        -- Signaux d'entrée
        COM_REG: in std_logic;
        TRAME_DCC: in std_logic_vector(50 downto 0); -- il peut y avoir de 42 à 51 bit dans une trame
        
        -- Signaux de sortie
        DCC_BIT: out std_logic;
        TRAME_LEN: out integer;
        -- TRAME_LEN: out std_logic_vector(5 downto 0);

     );
end REG_DCC;

architecture Behavioral of REG_DCC is

    --Compteur pour le bit actuelle à lire
signal cpt: INTEGER range 0 to 50;
    -- Ensemble de la trame à lire
signal trame: std_logic_vector(50 downto 0);
    -- Taille de la trame à lire
signal t_len: integer;


begin

    --A chaque front d'horloge ou reset asynchrone
process(CLK_100MHz,RESET)
begin
    -- reset du système
    if RESET = '1' then cpt <= 0;
    -- si la MAE signal qu'elle veut décaller, on retourne le bit actuelle et on passe au bit suivant
    elsif rising_edge(CLK_100MHz) and COM_REG = '1' and cpt<t_len then DCC_BIT <= trame(cpt); cpt <= cpt + 1;
    -- si la MAE signal qu'elle veut charger une trame, on rénitialise cpt, on charge la trame suivante et on envoi sa taille
    elsif rising_edge(CLK_100MHz) and COM_REG = '0' then trame <= TRAME_DCC; cpt <= 0; t_len := TRAME_DCC'length; TRAME_LEN <= t_len;
    -- si com est défini a 'U' (non défini) par la MAE alors on ne fait rien
    
    -- elsif rising_edge(CLK_100MHz) and COM_REG = '0' then trame <= TRAME_DCC; cpt <= 0; t_len := TRAME_DCC'length; TRAME_LEN <= std_logic_vector(to_unsigned(integer(t_len), TRAME_LEN'length));
    end if;
end process;

end Behavioral;