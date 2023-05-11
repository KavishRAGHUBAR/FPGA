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

entity testbench_dcc_fg is
--  Port ( );
end testbench_dcc_fg;

architecture Behavioral of testbench_dcc_fg is
signal Interrupteur : std_logic_vector(7 downto 0);
signal Trame_DCC : std_logic_vector(50 downto 0);
signal Trame_valide : std_logic_vector(50 downto 0);
-- Signaux de test bench

begin

frame_generator : entity work.DCC_FRAME_GENERATOR
    port map(Interrupteur,Trame_DCC);

process
begin
Interrupteur <= "10000000";
Trame_valide <= "111111111111111111111110000000110011111110011111001";
assert Trame_DCC = Trame_valide report "Trame 1 invalide" severity Warning;
wait for 10 ns;
Interrupteur <= "01000000";
Trame_valide <= "111111111111111111111110000000110010111110010111001";
assert Trame_DCC = Trame_valide report "Trame 2 invalide" severity Warning;
wait for 10 ns;
Interrupteur <= "00100000" ;
Trame_valide <= "111111111111111111111110000000110100100000100100111";
assert Trame_DCC = Trame_valide report "Trame 3 invalide" severity Warning;
wait for 10 ns;
Interrupteur <= "00010000" ;
Trame_valide <= "111111111111111111111110000000110100000000100000111";
assert Trame_DCC = Trame_valide report "Trame 4 invalide" severity Warning;
wait for 10 ns;
Interrupteur <= "00001000" ;
Trame_valide <= "111111111111111111111110000000110101001000101001111";
assert Trame_DCC = Trame_valide report "Trame 5 invalide" severity Warning;
wait for 10 ns;
Interrupteur <= "00000100" ;
Trame_valide <= "111111111111111111111110000000110101000000101000111";
assert Trame_DCC = Trame_valide report "Trame 6 invalide" severity Warning;
wait for 10 ns;
Interrupteur <= "00000010" ;
Trame_valide <= "111111111111110000000110110111100000000010110111001";
assert Trame_DCC = Trame_valide report "Trame 7 invalide" severity Warning;
wait for 10 ns;
Interrupteur <= "00000001" ;
Trame_valide <= "111111111111110000000110110111100000000000110111011";
assert Trame_DCC = Trame_valide report "Trame 8 invalide" severity Warning;
wait for 10 ns;
Interrupteur <= "00000000" ;
Trame_valide <= "111111111111111111111110000000110011000000011111001";
assert Trame_DCC = Trame_valide report "Trame 8 invalide" severity Warning;
wait;
end process;

end Behavioral;
