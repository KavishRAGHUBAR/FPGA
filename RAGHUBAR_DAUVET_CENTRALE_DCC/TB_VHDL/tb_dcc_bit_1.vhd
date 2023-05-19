----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Students: Kavish RAGHUBAR (M1 SESI) et Haron DAUVET (M1 SAR)
-- 
-- UE FPGA : Projet CENTRALE DCC
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity TB_DCC_BIT_1 is
--  Port ( );
end TB_DCC_BIT_1;

architecture Behavioral of TB_DCC_BIT_1 is
    signal Clk_100M : std_logic := '0';
    signal Clk_1M : std_logic := '0';
    signal reset : std_logic := '0';
    signal GO_1 : std_logic:='0';
    signal FIN_1 : std_logic;
    signal DCC_1 : std_logic;
    
begin

  test_dcc_bit_1 : entity work.DCC_BIT_1 port map(clk_100MHz=>Clk_100M, 
                                          clk_1MHz=>Clk_1M, 
                                          reset=>RESET, 
                                          go_1=>GO_1,
                                          fin_1=>FIN_1,
                                          dcc_1=>DCC_1);
                                          
Clk_1M <= not Clk_1M after 1 us;
Clk_100M <= not Clk_100M after 5 ns;
reset<='0' after 6 us, '1' after 10 us;
GO_1<='1' after 15 us, '0' after 25 us, '1' after 515 us, '0' after 525 us;

end Behavioral;
