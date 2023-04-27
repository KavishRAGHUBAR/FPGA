----------------------------------------------------------------------------------
-- Company: Sorbonne Universite
-- Engineer: Kavish RAGHUBAR
-- 
-- Create Date: 06.03.2023 10:53:19
-- Design Name: 
-- Module Name: TOP_DCC - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: NEXYS 4 DDR
-- Tool Versions: 
-- Description: Partie 4 de l'UE FPGA
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: In this design, we'll assemble all the modules
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

entity TOP_DCC is
    Port ( Reset : in STD_LOGIC; -- Reset Asynchrone
           Clk : in STD_LOGIC; -- Horloge 100 MHz de la carte Nexys
           Sortie_DCC : out STD_LOGIC);
end TOP_DCC;

architecture Behavioral of TOP_DCC is
--signaux du module compteur_tempo
Signal  Start_Tempo	:  STD_LOGIC;		-- Commande de Démarrage de la Temporisation
Signal  Fin_Tempo	:  STD_LOGIC;		-- Drapeau de Fin de la Temporisation

--signaux du module clk_div
signal Clk_Out :  STD_LOGIC; -- Horloge 1 MHz

--signaux du module dcc_frame_gen
signal Interrupteur	:  STD_LOGIC_VECTOR(7 downto 0); -- Interrupteurs de la Carte
signal Trame_DCC 	:  STD_LOGIC_VECTOR(50 downto 0); -- Trame

--declaration des components
component Compteur_Tempo 
    Port ( Clk 			: in STD_LOGIC;		-- Horloge 100 MHz
           Reset 		: in STD_LOGIC;		-- Reset Asynchrone
           Clk1M 		: in STD_LOGIC;		-- Horloge 1 MHz
           Start_Tempo	: in STD_LOGIC;		-- Commande de Démarrage de la Temporisation
           Fin_Tempo	: out STD_LOGIC		-- Drapeau de Fin de la Temporisation
		);
end component ;

component CLK_DIV 
port (	Reset 	: in STD_LOGIC;		-- Reset Asynchrone
        Clk_In 	: in STD_LOGIC;		-- Horloge 100 MHz de la carte Nexys
        Clk_Out : out STD_LOGIC);	-- Horloge 1 MHz de sortie
end component ;

component DCC_FRAME_GENERATOR
port ( Interrupteur	: in STD_LOGIC_VECTOR(7 downto 0);	-- Interrupteurs de la Carte
       Trame_DCC 	: out STD_LOGIC_VECTOR(50 downto 0));	-- Trame DCC de Test
end component ;

begin

   -- Compteur_tempo
   Compteur : Compteur_Tempo 
   PORT MAP(
          Clk => Clk,		-- Horloge 100M
		  Reset => Reset,			
          Clk1M => Clk_Out,	-- Horloge 1M
          Start_Tempo => Start_Tempo,	
          Fin_Tempo => Fin_Tempo );
        
           -- Compteur_tempo
   Diviseur : CLK_DIV 
   PORT MAP (
		  Reset => Reset,          
		  Clk_In   => Clk,	 -- Horloge 100M			
          Clk_Out => Clk_Out   ); -- Horloge 1M
          
    DCC_FRAME : DCC_FRAME_GENERATOR 
    PORT map (
		  Interrupteur => Interrupteur,
		  Trame_DCC => Trame_DCC );
      

end Behavioral;
