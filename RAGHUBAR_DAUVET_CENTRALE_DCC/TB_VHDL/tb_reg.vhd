----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M1 SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity testbench_reg is
--  Port ( );
end testbench_reg;

architecture Behavioral of testbench_reg is
signal Trame_DCC : std_logic_vector(50 downto 0);
signal COM,REG,reset_n,Reg_out : std_logic;
signal Clk100 : std_logic:='0';
-- Signaux de test bench
begin

Clk100 <= not Clk100 after 10ns;

registre_dcc : entity work.Registre_DCC
    port map(Trame_DCC,COM,REG,Clk100,reset_n,Reg_out);

process
begin

reset_n <= '0';
wait for 10 ns;
reset_n <= '1';
Trame_DCC <= "010111111111111111111111110000000110011111110011111";

REG <= '1';
COM <= '0';
wait for 40 ns;
REG <= '0';
COM <= '1';

wait for 30 ns;
assert Reg_out = '0'  report "Premier bit incorrect" severity Warning;
wait for 20 ns;

assert Reg_out = '1'  report "Second bit incorrect" severity Warning;
wait for 20 ns;

wait;
end process;

end Behavioral;
