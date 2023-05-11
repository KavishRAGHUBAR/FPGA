----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name:
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

entity TEST_MAE_100MHz is
end TEST_MAE_100MHz;

architecture Behavioral of TEST_MAE_100MHz is
    signal CLK_100MHz: std_logic:='0';
    signal RESET : std_logic:='0';
    signal FIN_1: std_logic;
    signal FIN_0: std_logic;
    signal FIN_TEMPO: std_logic;
    signal DCC_BIT: std_logic;   --inputs
    signal COM_REG ,START_TEMPO,GO_1,GO_0 :std_logic;      --outputs
    
       
begin
    simu : entity work.MAE_100MHz port map(CLK_100MHz=>CLK_100MHz,         
                                          RESET=>RESET, 
                                          GO_0=>GO_0,
                                          GO_1=>GO_1,
                                          FIN_0=>FIN_0,
                                          FIN_1=>FIN_1,
                                          DCC_BIT=>DCC_BIT,
                                          FIN_TEMPO=>FIN_TEMPO,
                                          COM_REG=>COM_REG,
                                          START_TEMPO=>START_TEMPO);
                                          

CLK_100MHz <= not CLK_100MHz after 10 ns;
RESET<='1' after 5 us;
DCC_BIT<='1' after 6 us,;
FIN_1<='1' after 7 us, '1' after;

FIN_TEMPO<='1' after  us;




end Behavioral;
