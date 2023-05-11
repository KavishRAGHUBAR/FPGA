----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M) SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_DCC is
  Port (clk100, reset_n : in std_logic;
         interrupteur : in std_logic_vector(7 downto 0);
         sortie_dcc : out std_logic);
end TOP_DCC;

architecture Behavioral of TOP_DCC is
signal clk_1MHz,COM,REG,reg_out,go_0,fin_0,dcc_0,go_1,fin_1,dcc_1,start_tempo,fin_tempo : std_logic;
signal Trame_DCC : std_logic_vector(50 downto 0);
begin

sortie_dcc <= dcc_1 or dcc_0;

clk_div : entity work.clkdiv100
    port map(Clk100,reset_n,clk_1MHz);
    
reg_dcc : entity work.Registre_DCC
    port map(Trame_DCC,COM,REG,Clk100,reset_n,Reg_out);
    
frame_generator : entity work.DCC_FRAME_GENERATOR
    port map(Interrupteur,Trame_DCC);

dcc_bit_0 : entity work.DCC_Bit_0
    port map(clk_1MHz, clk100,reset_n,go_0,fin_0,dcc_0);

dcc_bit_1 : entity work.DCC_Bit_1
    port map(clk_1MHz, clk100,reset_n,go_1,fin_1,dcc_1);

cpt_tempo : entity work.CPT_TEMPO
    port map(clk100,clk_1Mhz,reset_n,Start_tempo,Fin_tempo);

fsm : entity work.mae
    port map(clk100, reset_n, reg_out, fin_0,fin_1,fin_tempo,go_0,go_1,start_tempo,COM,REG);
     
end Behavioral;
