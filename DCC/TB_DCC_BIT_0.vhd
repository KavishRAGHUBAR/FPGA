----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2023 16:33:58
-- Design Name: 
-- Module Name: TB_DCC_BIT_0 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_DCC_BIT_0 is
--  Port ( );
end TB_DCC_BIT_0;

architecture Behavioral of TB_DCC_BIT_0 is
    signal Clk_100M : std_logic := '0';
    signal Clk_1M : std_logic := '0';
    signal reset : std_logic := '0';
    signal GO_0 : std_logic;
    signal FIN_0 : std_logic;
    signal DCC_0 : std_logic;
    
begin

  test_dcc_bit_0 : entity work.DCC_BIT_0 port map(Clk_100M=>Clk_100M, 
                                          Clk_1M=>Clk_1M, 
                                          RESET=>RESET, 
                                          GO_0=>GO_0,
                                          FIN_0=>FIN_0,
                                          DCC_0=>DCC_0);
                                          
Clk_1M <= not Clk_1M after 1 us;
Clk_100M <= not Clk_100M after 10 ns;
RESET<='1' after 5 us, '0' after 10 us;
GO_0<='1' after 5 us, '0' after 25 us, '1' after 500 us, '0' after 520 us;

end Behavioral;
