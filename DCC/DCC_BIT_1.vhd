----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2023 13:39:21
-- Design Name: 
-- Module Name: DCC_BIT_1 - Behavioral
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

entity DCC_BIT_1 is
    Port ( Clk : in std_logic; --horloge 1M
           Clk_100M : in std_logic; --horloge 100 M
           Reset : in STD_LOGIC;-- Reset Asynchrone
           GO_1 : in STD_LOGIC;
           FIN_1 : out STD_LOGIC;
           DCC_1 : out STD_LOGIC);
end DCC_BIT_1;

architecture Behavioral of DCC_BIT_1 is
signal delay_1 : std_logic;
begin


end Behavioral;
