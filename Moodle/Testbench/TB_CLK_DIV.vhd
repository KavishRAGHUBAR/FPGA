----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M) SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench_clk_div is
--  Port ( );
end testbench_clk_div;

architecture Behavioral of testbench_clk_div is
signal clk_in : std_logic:='0';
signal clk_out : std_logic;
signal reset : std_logic:='1';
begin

clk_div : entity work.CLK_DIV
    port map(clk_in=>clk_in,reset=>reset,clk_out=>clk_out);
    
clk_in <= not(clk_in) after 10 ns;

reset <= '1' after 40 ns;

end Behavioral;
