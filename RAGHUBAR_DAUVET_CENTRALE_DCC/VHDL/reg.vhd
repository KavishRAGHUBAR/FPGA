----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M1 SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registre_DCC is
  Port (Trame_DCC : in std_logic_vector(50 downto 0);
        COM, REG : in std_logic;
        Clk100 : in std_logic;
        reset_n : in std_logic;
        Reg_out : out std_logic);
end Registre_DCC;

architecture Behavioral of Registre_DCC is
signal registre : std_logic_vector(50 downto 0):=(others => '0');
begin

    process(Clk100, reset_n)
    begin
    
        -- Si le signal reset_n est a 0, reinitialiser le registre et la sortie Reg_out
        if(reset_n = '0')then
            registre <= (others => '0');
            Reg_out <= '0';
        -- Sinon, si l'horloge clk100 a une transition ascendante (rising edge), traiter les signaux COM et REG
        elsif(rising_edge(Clk100))then
            -- Si le signal COM est actif, mettre a jour la sortie Reg_out et le contenu du registre
            if(COM = '1')then
                Reg_out <= registre(50);
                registre <= registre(49 downto 0) & '0';
            end if;
            -- Si le signal REG est actif, mettre a jour le contenu du registre et reinitialiser Reg_out
            if(REG = '1')then
                Reg_out <= '0';
                registre(50 downto 0) <= Trame_DCC (50 downto 0);
            end if;
        end if;
        
    end process;
    end Behavioral;
    