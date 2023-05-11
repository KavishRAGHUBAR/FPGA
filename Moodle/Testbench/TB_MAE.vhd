----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M) SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use IEEE.NUMERIC_STD.ALL;

entity tb_mae is
--  Port ( );
end tb_mae;

architecture Behavioral of tb_mae is

signal reset_n,registre_dcc,fin_0,fin_1,fin_tempo,go_0,go_1,start_tempo,COM,REG,dcc_0,dcc_1 : std_logic;
signal trame : std_logic_vector(50 downto 0);
signal clk : std_logic:='0';
signal clk_1MHz : std_logic:='0';
signal i : integer range 0 to 50;
signal dcc : std_logic; 

-- debug
signal debug_mae, mae0 : integer range 0 to 10;
signal cpt0 : integer range 0 to 100;

begin

Clk <= not Clk after 5 ns;  -- clk 10MHz : 10 ns 
clk_1MHz <= not clk_1MHz after 500 ns;   -- clk 1MHz  : 1 us 
reset_n <= '0', '1' after 14 ns;
registre_dcc <= trame(i);
--trame <= "010111111111111111111111110000000110011111110011111";
trame <= "010101010101010101010101010101010101010101010101010";


process(Clk,REG, COM,reset_n)
begin
    if((reset_n = '0') or ((rising_edge (clk)) and (REG = '1'))) then
        i <= 50;
    elsif((rising_edge (clk)) and (COM = '1'))then
        i <= i - 1;
    end if;

end process;

dcc_bit_0 : entity work.DCC_Bit_0
    port map(clk_1MHz, clk,reset_n,go_0,fin_0,cpt0, mae0, dcc_0);

dcc_bit_1 : entity work.DCC_Bit_1
    port map(clk_1MHz, clk,reset_n,go_1,fin_1,dcc_1);
    
fsm : entity work.mae
    port map(clk, reset_n, registre_dcc, fin_0,fin_1,fin_tempo,go_0,go_1,start_tempo,COM,REG,debug_mae);
    
cpt_tempo : entity work.CPT_TEMPO
    port map(clk,clk_1Mhz,reset_n,Start_tempo,Fin_tempo);

dcc <= dcc_0 or dcc_1;

end Behavioral;

