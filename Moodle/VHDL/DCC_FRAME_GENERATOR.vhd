----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: J.DENOULET, Winter 2021
--
-- Module Name: DCC_FRAME_GENERATOR - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: NEXYS 4 DDR
-- 
--	Generateur de Trames de Test pour la Centrale DCC
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DCC_FRAME_GENERATOR is
    Port ( Interrupteur	: in STD_LOGIC_VECTOR(7 downto 0);	-- Interrupteurs de la Carte
           Trame_DCC 	: out STD_LOGIC_VECTOR(50 downto 0));					-- Trame DCC de Test					
end DCC_FRAME_GENERATOR;

architecture Behavioral of DCC_FRAME_GENERATOR is

signal adr : std_logic_vector(7 downto 0) := x"02";

begin

-- Generation d'une Trame selon l'Interrupteur Tire vers le Haut
-- Si Plusieurs Interupteurs Sont Tires, Celui de Gauche Est Prioritaire

-- Completer les Trames pour Realiser les Tests Voulus


       -- Trame_DCC <= "010101010101010101010101010101010101010101010101010";


process(Interrupteur)
begin
	
--	-- Interrupteur 7 Active
--		--> Trame Marche Avant du Train d'Adresse i
	if Interrupteur(7)='1' then

		Trame_DCC <= "11111111111111111111111"	-- Preambule
        			&  '0'	            -- Start Bit
        			& adr		-- Champ Adresse
        			&  '0'			    -- Start Bit
        			& "01111111"	    -- Champ Commande
        			&  '0'			    -- Start Bit
        			& (adr xor "01111111") 	    -- Champ Contrele
        			&  '1';			    -- Stop Bit  				
--        Trame_DCC <= "010101010101010101010101010101010101010101010101010";

--	-- Interrupteur 6 Active
--		--> Trame Marche Arriere du Train d'Adresse i
	elsif Interrupteur(6)='1' then
	
		Trame_DCC <= "11111111111111111111111"	-- Preambule
					&  '0'	            -- Start Bit
					& adr		-- Champ Adresse
					&  '0'			    -- Start Bit
					& "01011111"	    -- Champ Commande
					&  '0'			    -- Start Bit
					& (adr xor "01011111") 	    -- Champ Contrele
					&  '1';			    -- Stop Bit


--	-- Interrupteur 5 Active
--		--> Allumage des Phares du Train d'Adresse i
	elsif Interrupteur(5)='1' then
	
		Trame_DCC <= "11111111111111111111111"	-- Preambule
					&  '0'	            -- Start Bit
					& adr		-- Champ Adresse
					&  '0'			    -- Start Bit
					& "10010000"	    -- Champ Commande
					&  '0'			    -- Start Bit
					&  (adr xor "10010000")	    -- Champ Contrele
					&  '1';			    -- Stop Bit


--	-- Interrupteur 4 Active
--		--> Extinction des Phares du Train d'Adresse i
	elsif Interrupteur(4)='1' then
	
		Trame_DCC <= "11111111111111111111111"	-- Preambule
					&  '0'	            -- Start Bit
					& "00000010"		-- Champ Adresse
					&  '0'			    -- Start Bit
					& "10000000"	    -- Champ Commande
					&  '0'			    -- Start Bit
					& (adr xor "10000000")	    -- Champ Contrele
					&  '1';			    -- Stop Bit


--	-- Interrupteur 3 Active
--		--> Activation du Klaxon (Fonction F11) du Train d'Adresse i
    elsif Interrupteur(3)='1' then
	
		Trame_DCC <= "11111111111111111111111"	-- Preambule
					&  '0'	            -- Start Bit
					& "00000010"		-- Champ Adresse
					&  '0'			    -- Start Bit
					& "10100100"	    -- Champ Commande
					&  '0'			    -- Start Bit
					& (adr xor "10100100")	    -- Champ Contrele
					&  '1';			    -- Stop Bit


--	-- Interrupteur 2 Active
--		--> Reamoreage du Klaxon (Fonction F11) du Train d'Adresse i
	elsif Interrupteur(2)='1' then
	
		Trame_DCC <= "11111111111111111111111"	-- Preambule
					&  '0'	            -- Start Bit
					& "00000010"		-- Champ Adresse
					&  '0'			    -- Start Bit
					& "10100000"	    -- Champ Commande
					&  '0'			    -- Start Bit
					& (adr xor "10100000") 	    -- Champ Contrele
					&  '1';			    -- Stop Bit


--	-- Interrupteur 1 Active
--		--> Annonce SNCF (Fonction F13) du Train d'Adresse i
	elsif Interrupteur(1)='1' then
	
		Trame_DCC <= "11111111111111"	-- Preambule
					& '0'				-- Start Bit
					& adr		-- Champ Adresse
					& '0'				-- Start Bit
					& "11011110"	    -- Champ Commande (Octet 1)
					& '0'				-- Start Bit
					& "00000001"		-- Champ Commande (Octet 2)
					& '0'				-- Start Bit
					& (adr xor 	"11011110" xor "00000001") 	-- Champ Contrele
					& '1'	;			-- Stop Bit

--	-- Interrupteur 0 Active
--		--> Annonce SNCF (Fonction F13) du Train d'Adresse i
	elsif Interrupteur(0)='1' then
	
		Trame_DCC <= "11111111111111"	-- Preambule
					& '0'				-- Start Bit
					& adr		-- Champ Adresse
					& '0'				-- Start Bit
					& "11011110"	    -- Champ Commande (Octet 1)
					& '0'				-- Start Bit
					& "00000000"		-- Champ Commande (Octet 2)
					& '0'				-- Start Bit
					& (adr xor "11011110" xor "00000000") 		-- Champ Contrele
					& '1'	;			-- Stop Bit

--	-- Aucun Interrupteur Active
--		--> Arret du Train d'Adresse i
	else 

		Trame_DCC <= "11111111111111111111111"	-- Preambule
					&  '0'	            -- Start Bit
					& adr		-- Champ Adresse
					&  '0'			    -- Start Bit
					& "01100000"	    -- Champ Commande
					&  '0'			    -- Start Bit
					& (adr xor "01100000") 	    -- Champ Contrele
					&  '1';			    -- Stop Bit  
			
    end if;	
end process;

end Behavioral;

