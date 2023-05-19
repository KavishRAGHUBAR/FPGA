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

entity testbench_clk_div is
--  Port ( );
end testbench_clk_div;

architecture Behavioral of testbench_clk_div is
signal clk : std_logic:='0';
signal clkout : std_logic;
signal reset_n : std_logic:='0';
begin

clk_div : entity work.clkdiv100
    port map(clk=>clk,reset_n=>reset_n,clkout=>clkout);
    
clk <= not(clk) after 10 ns;

reset_n <= '1' after 40 ns;

end Behavioral;
