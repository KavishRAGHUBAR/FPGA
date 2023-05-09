----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: J.DENOULET, Winter 2021
--
-- Module Name: DCC_FRAME_GENERATOR - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: NEXYS 4 DDR
-- 
--	Générateur de Trames de Test pour la Centrale DCC
-- 
----------------------------------------------------------------------------------

--Signal preambule : std_logic_vector(14 downto 0); --synchronisatioon/debut de la tramme
--Signal start_bit_1 : std_logic ; --separation des octets entre sync et data/adr
--Signal start_bit_2 : std_logic; --separation entre paquet 1 et 2
--Signal start_bit_3 : std_logic; --separation entre paquet 2 et 3
--Signal champ_adresse : std_logic_vector(7 downto 0);
--Signal champ_commande : std_logic_vector(15 downto 0); -- 1 � 2 octets
--Signal champ_controle : std_logic_vector(7 downto 0); -- 1 � 2 octets
--Signal stop_bit : std_logic; --separation des octets


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DCC_FRAME_GENERATOR is
    Port ( Interrupteur	: in STD_LOGIC_VECTOR(7 downto 0);	-- Interrupteurs de la Carte
           Trame_DCC 	: out STD_LOGIC_VECTOR(50 downto 0));					-- Trame DCC de Test					
end DCC_FRAME_GENERATOR;

architecture Behavioral of DCC_FRAME_GENERATOR is

begin

-- G�n�ration d'une Trame selon l'Interrupteur Tir� vers le Haut
-- Si Plusieurs Interupteurs Sont Tir�s, Celui de Gauche Est Prioritaire

-- Compl�ter les Trames pour R�aliser les Tests Voulus

process(Interrupteur)
begin
	
	-- Interrupteur 7 Activ�
		--> Trame Marche Avant du Train d'Adresse i
	if Interrupteur(7)='1' then
	
		Trame_DCC <= "11111111111111111111111"			-- Pr�ambule
					& 	"0"			-- Start Bit
					&	"00000100"			-- Champ Adresse/numero du train
					& 	"0"			-- Start Bit
					&	"01111111"			-- Champ Commande
					& 	"0"		-- Start Bit
					& 	"01111011"			-- Champ Contr�le
					& 	"1";			-- Stop Bit

	-- Interrupteur 6 Activ�
		--> Trame Marche Arri�re du Train d'Adresse i
	elsif Interrupteur(6)='1' then
	
		Trame_DCC <= "11111111111111111111111"				-- Pr�ambule
					& 	"0"			-- Start Bit
					&	"00000100"			-- Champ Adresse
					& 	"0"			-- Start Bit
					&	"01011111"			-- Champ Commande
					& 	"0"			-- Start Bit
					& 	"01011011"			-- Champ Contr�le
					& 	"1";			-- Stop Bit


	-- Interrupteur 5 Activ�
		--> Allumage des Phares du Train d'Adresse i
	elsif Interrupteur(5)='1' then
	
		Trame_DCC <= "11111111111111111111111"				-- Pr�ambule
					& 	"0"			-- Start Bit
					&	"00000100"			-- Champ Adresse
					& 	"0"				-- Start Bit
					&	"10010000"			-- Champ Commande
					& 	"0"			-- Start Bit
					& 	"01101011"			-- Champ Contr�le
					& 	"1";			-- Stop Bit

	-- Interrupteur 4 Activ�
		--> Extinction des Phares du Train d'Adresse i
	elsif Interrupteur(4)='1' then
	
		Trame_DCC <= "11111111111111111111111"				-- Pr�ambule
					& 	"0"			-- Start Bit
					&	"00000100"			-- Champ Adresse
					& 	"0"			-- Start Bit
					&	"10000000"			-- Champ Commande
					& 	"0"			-- Start Bit
					& 	"10000100"			-- Champ Contr�le
					& 	"1";			-- Stop Bit

	-- Interrupteur 3 Activ�
		--> Activation du Klaxon (Fonction F11) du Train d'Adresse i
	elsif Interrupteur(3)='1' then
	
		Trame_DCC <= "11111111111111111111111"			-- Pr�ambule
					& 	"0"			-- Start Bit
					&	"00000100"			-- Champ Adresse
					&	"0"			-- Start Bit
					&	"10100100"			-- Champ Commande
					& 	"0"				-- Start Bit
					& 	"10100000"			-- Champ Contr�le
					& 	"1";			-- Stop Bit

	-- Interrupteur 2 Activ�
		--> R�amor�age du Klaxon (Fonction F11) du Train d'Adresse i
	elsif Interrupteur(2)='1' then
	
		Trame_DCC <= "11111111111111111111111"				-- Pr�ambule
					& 	"0"			-- Start Bit
					&	"00000100"			-- Champ Adresse
					& 	"0"			-- Start Bit
					&	"10100000"			-- Champ Commande
					& 	"0"			-- Start Bit
					& 	"10100100"			-- Champ Contr�le
					& 	"1";			-- Stop Bit

	-- Interrupteur 1 Activ�
		--> Annonce SNCF (Fonction F13) du Train d'Adresse i (active)
	elsif Interrupteur(1)='1' then
	
		Trame_DCC <= "11111111111111"				-- Pr�ambule
					& 	"0"			-- Start Bit
					&	"00000100"			-- Champ Adresse
					& 	"0"			-- Start Bit
					&	"11011110"			-- Champ Commande (Octet 1)
					& 	"0"			-- Start Bit
					&	"00000001"			-- Champ Commande (Octet 2)
					& 	"0"			-- Start Bit 
					& 	"11011011"			-- Champ Contr�le Champ Adresse XOR Champ Commande (Octet 1) XOR Champ Commande (Octet 2)
					& 	"1";			-- Stop Bit

	-- Interrupteur 0 Activ�
		--> Annonce SNCF (Fonction F13) du Train d'Adresse i (desactive)
	elsif Interrupteur(0)='1' then
	
		Trame_DCC <= "11111111111111"				-- Pr�ambule
					&  "0"				-- Start Bit
					&  "00000100"				-- Champ Adresse
					&  "0"				-- Start Bit
					&  "11011110"				-- Champ Commande (Octet 1)
					&  "0"				-- Start Bit
					&  "00000000"			-- Champ Commande (Octet 2)
					&  "0"				-- Start Bit
					&  "11011010"				-- Champ Contr�le
					&  "1";			-- Stop Bit

	-- Aucun Interrupteur Activ�
		--> Arr�t du Train d'Adresse i
	else 
	
		Trame_DCC <= "11111111111111111111111"			-- Pr�ambule
					&  "0"				-- Start Bit
					&  "00000100"			-- Champ Adresse
					&  "0"			-- Start Bit
					&  "01100000"			-- Champ Commande
					&  "0"		-- Start Bit
					&  "01100100"				-- Champ Contr�le
					&  "1";		-- Stop Bit
end if;	
end process;

end Behavioral;




