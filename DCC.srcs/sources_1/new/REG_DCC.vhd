----------------------------------------------------------------------------------
-- Company: Sorbonne University
-- Engineer: Raghubar et Dauvet
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: REG_DCC - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_DCC is
    Port (
        --Parametre general
        CLK_100MHz: in std_logic;
        RESET: in std_logic;
        
        COM_REG: in std_logic;
        TRAME_DCC: in std_logic_vector(50 downto 0);
        
        DCC_BIT: out std_logic
     );
end REG_DCC;

architecture Behavioral of REG_DCC is

signal cpt: INTEGER range 0 to 50;
signal trame: std_logic_vector(50 downto 0);

begin
process(CLK_100MHz,RESET)
begin
    if RESET = '1' then cpt <= 0;
    elsif rising_edge(CLK_100MHz) then
        if COM_REG = '1' then 
            cpt <= cpt + 1; 
            DCC_BIT <= TRAME(cpt);
        else trame <= Trame_DCC; cpt <= 0;
        end if;
    end if;
end process;

end Behavioral;
