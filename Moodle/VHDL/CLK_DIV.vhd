----------------------------------------------------------------------------------
-- Company: UPMC
-- Designed by: E.PIMOR S.HAMOUM
-- Revision by: J.DENOULET
--	Diviseur d'Horloge: 100 MHz --> 1 MHz
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLK_DIV is
    Port ( Reset 	: in STD_LOGIC;		-- Reset Asynchrone
           Clk_In 	: in STD_LOGIC;		-- Horloge 100 MHz de la carte Nexys
           Clk_Out 	: out STD_LOGIC);	-- Horloge 1 MHz de sortie
end CLK_DIV;


architecture Behavioral of CLK_DIV is

signal Div    	: INTEGER range 0 to 49;	-- Compteur de cycles d'horloge
signal Clk_Temp : STD_LOGIC;			 	-- Signal temporaire

begin
	Clk_Out <= Clk_Temp;					-- Affectation du Port de Sortie

	process (Clk_In, Reset)
	begin
		-- Reset Asynchrone
		if Reset = '0' then 
			Clk_Temp <= '0';
			div <= 0;
		-- A Chaque Front montant d'Horloge
		elsif rising_edge (Clk_In) then
			Div <= Div + 1;		-- Incrementation du Compteur
			if Div = 49 then	-- Inversion du Signal d'Horloge Tous les 50 Cycles
				Div <= 0;
				Clk_Temp <= not Clk_Temp;
			end if;                       
		end if;
end process;

end Behavioral;
