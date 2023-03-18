		

;************************************************************************
	THUMB	
	REQUIRE8
	PRESERVE8
;************************************************************************

	include REG_UTILES.inc
	


;************************************************************************
; 					IMPORT/EXPORT Syst?me
;************************************************************************

	IMPORT ||Lib$$Request$$armlib|| [CODE,WEAK]

	IMPORT Allume_LED
	IMPORT Eteint_LED
	;IMPORT Capteur


; IMPORT/EXPORT de proc?dure           

	IMPORT Init_Cible
	

	EXPORT main
	
;*******************************************************************************


;*******************************************************************************
	AREA  mesdonnees, data, readwrite

	


;*******************************************************************************
	
	AREA  moncode, code, readonly
		


;*******************************************************************************
; Proc?dure principale et point d'entr?e du projet
;*******************************************************************************
main  	PROC 
;*******************************************************************************


	
	MOV R0,#0
	BL Init_Cible;					;Initialisation de la cible

boucle

		;Etat du capteur
		LDR  R4 ,= 0X40010808		; Chargement de l'adresse dans le registre
		LDRH R8, [R4]				; Stock la valeur de l'adresse de R4 dans R8
		
		MOV R9, #0					; Registre du compteur des 10 passages initialis� � 0
		MOV R10, #0					; Registre OlEtat
		
		AND R8,R8, #0x0100			; V�rifier si le bit 8 de l'adresse charg�e dans R5 est � 1 ou � 0.
		CMP R8, #0					; Compare R8 � z�ro OU CMP R8, #(0x01 << 8)
		BNE front_montant_allume	; Si zero alors j'allume			
		B boucle
			
front_montant_allume
		
		ADD R9, R9, #1				; Incr�mentation du compteur des 10 passages
		CMP R9, #0x0A				; V�rifier si le compteur est � 10
		BEQ Allume					; Si oui, alors passer � l'�tape d'allumage permanent de la LED
		
		MOV R10, #1					; Mettre � jour OldEtat
		
attente_allume
		BL Allume_LED				; Sinon, allume la LED
		BL Old_Etat_allume			; R�cup�rer l'�tat pr�c�dent du capteur
allume
		CMP R10, #0					; Compare le registre R10 � 0
		BEQ front_montant_eteint	; Si oui retourne � l'�tiquette front_montant_eteint
		
		B attente_allume					; Sinon continuer l'�tape d'allumage

front_montant_eteint
		
		ADD R9, R9, #1				; Incr�mentation du compteur des 10 passages
		CMP R9, #0x0A				; V�rifier si le compteur est � 10
		BEQ Allume					; Si oui, alors passer � l'�tape d'allumage permanent de la LED

		MOV R10, #1					; Mettre � jour OldEtat
		
attente_eteint	
		BL Eteint_LED				; Sinon, �teindre la LED
		BL Old_Etat_eteint			; R�cup�rer l'�tat pr�c�dent du capteur
eteint
		CMP R10, #0					; Compare le registre R10 � 0
		BEQ front_montant_allume	; Si oui retourne � l'�tiquette front_montant_allume
		
		B attente_eteint
		
		
Old_Etat_allume
		MOV R10, #0					; Initialisation � 0 du registre OldEtat
		LDRH R8, [R4]				; Charge la valeur stock�e � l'adresse R4 dans le registre R8
		AND R8,R8, #0x0100			; Effectue un ET binaire entre R8 et 0x0100 et stocke le r�sultat dans R8
		CMP R8, #0					; Compare la valeur stock�e dans R8 � 0
		BEQ Second_check			; Saute � l'�tiquette allume2
		B Old_Etat_allume			; Sinon, retourne � l'�tiquette Old_Etat_allume
Second_check
		LDRH R8, [R4]				; Charge la valeur stock�e � l'adresse R4 dans le registre R8
		AND R8,R8, #0x0100			; Effectue un ET binaire entre R8 et 0x0100 et stocke le r�sultat dans R8
		CMP R8, #0					; Compare la valeur stock�e dans R8 � 0
		BNE allume					; Saute � l'�tiquette allume2
		B Second_check				; Sinon, retourne � l'�tiquette Old_Etat_allume
		
Old_Etat_eteint
		MOV R10, #0					; Initialisation � 0 du registre OldEtat
		LDRH R8, [R4]				; Charge la valeur stock�e � l'adresse R4 dans le registre R8
		AND R8,R8, #0x0100			; Effectue un ET binaire entre R8 et 0x0100 et stocke le r�sultat dans R8
		CMP R8, #0					; Compare la valeur stock�e dans R8 � 0
		BEQ Second_check2					; Si la comparaison n'est pas �gale, saute � l'�tiquette eteint2
		B Old_Etat_eteint			; Sinon, retourne � l'�tiquette Old_Etat_eteint
Second_check2
		LDRH R8, [R4]				; Charge la valeur stock�e � l'adresse R4 dans le registre R8
		AND R8,R8, #0x0100			; Effectue un ET binaire entre R8 et 0x0100 et stocke le r�sultat dans R8
		CMP R8, #0					; Compare la valeur stock�e dans R8 � 0
		BNE eteint					; Saute � l'�tiquette allume2
		B Second_check2				; Sinon, retourne � l'�tiquette Old_Etat_allume



boucle2
Allume	
		BL Allume_LED
		B boucle2
		
	
		B .							; boucle inifinie terminale...

		ENDP

	END

;*******************************************************************************
