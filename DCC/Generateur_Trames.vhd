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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DCC_FRAME_GENERATOR is
    Port ( Interrupteur	: in STD_LOGIC_VECTOR(7 downto 0);	-- Interrupteurs de la Carte
           Trame_DCC 	: out STD_LOGIC_VECTOR(50 downto 0));					-- Trame DCC de Test					
end DCC_FRAME_GENERATOR;

architecture Behavioral of DCC_FRAME_GENERATOR is

Signal preambule : std_logic_vector(14 downto 0); --synchronisatioon/debut de la tramme
Signal start_bit_1 : std_logic ; --separation des octets entre sync et data/adr
Signal start_bit_2 : std_logic; --separation entre paquet 1 et 2
Signal start_bit_3 : std_logic; --separation entre paquet 2 et 3
Signal champ_adresse : std_logic_vector(7 downto 0);
Signal champ_commande : std_logic_vector(15 downto 0); -- 1 � 2 octets
Signal champ_controle : std_logic_vector(7 downto 0); -- 1 � 2 octets
Signal stop_bit : std_logic; --separation des octets

begin
preambule <= (others=>'1');
start_bit_1 <= '0';
start_bit_2 <= '0';
start_bit_3 <= '0';
stop_bit <= '1';
-- Génération d'une Trame selon l'Interrupteur Tiré vers le Haut
-- Si Plusieurs Interupteurs Sont Tirés, Celui de Gauche Est Prioritaire
-- Compléter les Trames pour Réaliser les Tests Voulus

process(Interrupteur)
begin
	
	-- Interrupteur 7 Activé
		--> Trame Marche Avant du Train d'Adresse i
	if Interrupteur(7)='1' then
--	champ_adresse <= 
--	champ_commande <=
--	champ_controle <= 
		Trame_DCC <= 	preambule			-- Préambule
					& 	start_bit_1			-- Start Bit
					&	champ_adresse			-- Champ Adresse
					& 	start_bit_2			-- Start Bit
					&	champ_commande			-- Champ Commande
					& 	start_bit_3			-- Start Bit
					& 	champ_controle			-- Champ Contrôle
					& 	stop_bit;			-- Stop Bit

	-- Interrupteur 6 Activé
		--> Trame Marche Arrière du Train d'Adresse i
	elsif Interrupteur(6)='1' then
--	champ_adresse <= 
--	champ_commande <=
--	champ_controle <= 
		Trame_DCC <= 	preambule			-- Préambule
					& 	start_bit_1			-- Start Bit
					&	champ_adresse			-- Champ Adresse
					& 	start_bit_2			-- Start Bit
					&	champ_commande			-- Champ Commande
					& 	start_bit_3			-- Start Bit
					& 	champ_controle			-- Champ Contrôle
					& 	stop_bit;			-- Stop Bit		-- Stop Bit


	-- Interrupteur 5 Activé
		--> Allumage des Phares du Train d'Adresse i
	elsif Interrupteur(5)='1' then
--	champ_adresse <= 
--	champ_commande <=
--	champ_controle <= 
		Trame_DCC <= 	preambule			-- Préambule
					& 	start_bit_1			-- Start Bit
					&	champ_adresse			-- Champ Adresse
					& 	start_bit_2			-- Start Bit
					&	champ_commande			-- Champ Commande
					& 	start_bit_3			-- Start Bit
					& 	champ_controle			-- Champ Contrôle
					& 	stop_bit;			-- Stop Bit			-- Stop Bit

	-- Interrupteur 4 Activé
		--> Extinction des Phares du Train d'Adresse i
	elsif Interrupteur(4)='1' then
--	champ_adresse <= 
--	champ_commande <=
--	champ_controle <= 	
		Trame_DCC <= 	preambule			-- Préambule
					& 	start_bit_1			-- Start Bit
					&	champ_adresse			-- Champ Adresse
					& 	start_bit_2			-- Start Bit
					&	champ_commande			-- Champ Commande
					& 	start_bit_3			-- Start Bit
					& 	champ_controle			-- Champ Contrôle
					& 	stop_bit;			-- Stop Bit			-- Stop Bit

	-- Interrupteur 3 Activé
		--> Activation du Klaxon (Fonction F11) du Train d'Adresse i
	elsif Interrupteur(3)='1' then
--	champ_adresse <= 
--	champ_commande <=
--	champ_controle <= 	
		Trame_DCC <= 	preambule			-- Préambule
					& 	start_bit_1			-- Start Bit
					&	champ_adresse			-- Champ Adresse
					& 	start_bit_2			-- Start Bit
					&	champ_commande			-- Champ Commande
					& 	start_bit_3			-- Start Bit
					& 	champ_controle			-- Champ Contrôle
					& 	stop_bit;			-- Stop Bit			-- Stop Bit

	-- Interrupteur 2 Activé
		--> Réamorçage du Klaxon (Fonction F11) du Train d'Adresse i
	elsif Interrupteur(2)='1' then
--	champ_adresse <= 
--	champ_commande <=
--	champ_controle <= 	
		Trame_DCC <= 	preambule			-- Préambule
					& 	start_bit_1			-- Start Bit
					&	champ_adresse			-- Champ Adresse
					& 	start_bit_2			-- Start Bit
					&	champ_commande			-- Champ Commande
					& 	start_bit_3			-- Start Bit
					& 	champ_controle			-- Champ Contrôle
					& 	stop_bit;			-- Stop Bit			-- Stop Bit

	-- Interrupteur 1 Activé
		--> Annonce SNCF (Fonction F13) du Train d'Adresse i
	elsif Interrupteur(1)='1' then
--	champ_adresse <= 
--	champ_commande <=
--	champ_controle <= 	
		Trame_DCC <= 	preambule			-- Préambule
					& 	start_bit_1			-- Start Bit
					&	champ_adresse			-- Champ Adresse
					& 	start_bit_2			-- Start Bit
					&	champ_commande			-- Champ Commande
					& 	start_bit_3			-- Start Bit
					& 	champ_controle			-- Champ Contrôle
					& 	stop_bit;			-- Stop Bit			-- Stop Bit

	-- Interrupteur 0 Activé
		--> Annonce SNCF (Fonction F13) du Train d'Adresse i
	elsif Interrupteur(0)='1' then
--	champ_adresse <= 
--	champ_commande <=
--	champ_controle <= 	
		Trame_DCC <= 	preambule			-- Préambule
					& 	start_bit_1			-- Start Bit
					&	champ_adresse			-- Champ Adresse
					& 	start_bit_2			-- Start Bit
					&	champ_commande			-- Champ Commande
					& 	start_bit_3			-- Start Bit
					& 	champ_controle			-- Champ Contrôle
					& 	stop_bit;			-- Stop Bit

	-- Aucun Interrupteur Activé
		--> Arrêt du Train d'Adresse i
	else 
--	champ_adresse <= 
--	champ_commande <=
--	champ_controle <= 	
		Trame_DCC <= 	preambule			-- Préambule
					& 	start_bit_1			-- Start Bit
					&	champ_adresse			-- Champ Adresse
					& 	start_bit_2			-- Start Bit
					&	champ_commande			-- Champ Commande
					& 	start_bit_3			-- Start Bit
					& 	champ_controle			-- Champ Contrôle
					& 	stop_bit;			-- Stop Bit
	end if;
end process;

end Behavioral;

