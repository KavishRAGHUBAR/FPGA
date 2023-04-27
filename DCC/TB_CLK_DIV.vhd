----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2023 10:02:18
-- Design Name: 
-- Module Name: TB_CLK_DIV - Behavioral
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

entity TB_CLK_DIV is
--  Port ( );
end TB_CLK_DIV;

architecture Behavioral of TB_CLK_DIV is
signal Reset 	:  STD_LOGIC;	-- Reset Asynchrone
signal Clk_In 	:  STD_LOGIC;	-- Horloge 100 MHz de la carte Nexys
signal Clk_Out :  STD_LOGIC;
constant CLK_PER : time := 10 ns; --periode de l'hologe 100MHz

begin
CLK_DIV: entity work.CLK_DIV
port map( Reset => Reset,
          Clk_In => Clk_In,
          Clk_Out => Clk_Out);
         
Reset <= '1', '0' after 100 ns;
--Clock process
clocked : process
          begin
            Clk_In <= '0';
            wait for CLK_PER/2;
            Clk_In <= '1';
            wait for CLK_PER/2;
end process clocked;

end Behavioral;
