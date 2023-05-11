----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M) SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench_reg is
--  Port ( );
end testbench_reg;

architecture Behavioral of testbench_reg is
signal Trame_DCC : std_logic_vector(50 downto 0);
signal COM,REG,reset_n,Reg_out : std_logic;
signal Clk100 : std_logic:='0';
-- Signaux de test bench
file TB: text open write_mode is "SIMU.log";
begin

Clk100 <= not Clk100 after 10ns;

process
variable Write_L : line;
begin
    write(Write_L,string'("Sortie du registre"));
    writeline(TB,Write_L);
    
    wait for 10 ns;
    write(Write_L,to_bit(Reg_out));
    writeline(TB,Write_L);
end process;

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

assert Reg_out = '0'  report "Troisième bit incorrect" severity Warning;
wait for 20 ns;

assert Reg_out = '1'  report "Quatrième bit incorrect" severity Warning;
wait for 920 ns;

assert Reg_out = '1'  report "Dernier bit incorrect" severity Warning;
wait;
end process;

end Behavioral;
