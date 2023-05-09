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
    Port ( Switch : in std_logic_vector(7 downto 0);
           Reset : in STD_LOGIC; -- Reset Asynchrone
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

   signal Clk_1M:  STD_LOGIC;		-- Horloge 1 MHz
   signal GO_0:  std_logic;
   signal FIN_0:  std_logic;
   signal DCC_0:  std_logic;
   signal GO_1:  std_logic;
   signal FIN_1:  std_logic;
   signal DCC_1:  std_logic;
   signal DCC_BIT:  std_logic;
   signal COM_REG:  std_logic;
   signal Clk_In:  STD_LOGIC; -- Horloge 100 MHz 

--declaration des components
--component Compteur_Tempo 
--    Port ( Clk 			: in STD_LOGIC;		-- Horloge 100 MHz
--           Reset 		: in STD_LOGIC;		-- Reset Asynchrone
--           Clk1M 		: in STD_LOGIC;		-- Horloge 1 MHz
--           Start_Tempo	: in STD_LOGIC;		-- Commande de Démarrage de la Temporisation
--           Fin_Tempo	: out STD_LOGIC		-- Drapeau de Fin de la Temporisation
--		);
--end component ;

--component CLK_DIV 
--port (	Reset 	: in STD_LOGIC;		-- Reset Asynchrone
--        Clk_In 	: in STD_LOGIC;		-- Horloge 100 MHz de la carte Nexys
--        Clk_Out : out STD_LOGIC);	-- Horloge 1 MHz de sortie
--end component ;

--component DCC_FRAME_GENERATOR
--port ( Interrupteur	: in STD_LOGIC_VECTOR(7 downto 0);	-- Interrupteurs de la Carte
--       Trame_DCC 	: out STD_LOGIC_VECTOR(50 downto 0));	-- Trame DCC de Test
--end component ;

begin

   -- Compteur_tempo
compteur_tempo: entity work.Compteur_Tempo port map
(
     Clk=>Clk, -- Horloge 100 MHz
     Reset=>RESET,				-- Reset Asynchrone
     Clk1M =>Clk_1M,				-- Horloge 1 MHz
     Start_Tempo=>Start_Tempo,		-- Commande de D?marrage de la Temporisation
     Fin_Tempo=>Fin_Tempo	
);

diviseur_horloge: entity work.CLK_DIV port map
(
     Reset=>RESET,
     Clk_In=>clk,
     Clk_Out=>Clk_1M
 );
 
 dcc_bit_0 : entity work.DCC_BIT_0 port map
(
     Clk_1M=>Clk_1M,
     Clk_100M =>clk,
     RESET=>RESET,
     GO_0=>GO_0,
     FIN_0=>FIN_0,
     DCC_0=>DCC_0
);

dcc_bit_1 : entity work.DCC_BIT_1 port map
(    
     Clk_100M=>clk,
     Clk_1M=>Clk_1M,
     RESET=>RESET,
     GO_1=>GO_1,
     FIN_1=>FIN_1,
     DCC_1=>DCC_1
); 


reg_dcc :entity work.Reg_DCC port map
(
    --pour rappel, à gauche (composant) => à droite signaux de TOP
     CLK_100MHz=>clk,
     RESET=>RESET,
     COM_REG=>COM_REG,
     TRAME_DCC=>TRAME_DCC,
     DCC_BIT=>DCC_BIT
);

mae :  entity work.MAE port map
(
     CLK_100MHz=>clk,
     RESET=>RESET,
     DCC_BIT=>DCC_BIT,
     COM_REG=>COM_REG,
     START_TEMPO=>Start_Tempo,
     FIN_TEMPO=>Fin_Tempo,
     GO_1=>GO_1,
     FIN_1=>FIN_1,
     GO_0=>GO_0,
     FIN_0=>FIN_0
);

tramme :  entity work.DCC_FRAME_GENERATOR port map
(
     Interrupteur => Switch,
     Trame_DCC => Trame_DCC
);



sortie_dcc <= DCC_1 xor DCC_0;
      

end Behavioral;
