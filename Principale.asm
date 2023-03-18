		

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
		
		MOV R9, #0					; Registre du compteur des 10 passages initialisé à 0
		MOV R10, #0					; Registre OlEtat
		
		AND R8,R8, #0x0100			; Vérifier si le bit 8 de l'adresse chargée dans R5 est à 1 ou à 0.
		CMP R8, #0					; Compare R8 à zéro OU CMP R8, #(0x01 << 8)
		BNE front_montant_allume	; Si zero alors j'allume			
		B boucle
			
front_montant_allume
		
		ADD R9, R9, #1				; Incrémentation du compteur des 10 passages
		CMP R9, #0x0A				; Vérifier si le compteur est à 10
		BEQ Allume					; Si oui, alors passer à l'étape d'allumage permanent de la LED
		
		BL Allume_LED				; Sinon, allume la LED
		MOV R10, #1					; Mettre à jour OldEtat
		
attente_allume
		BL Old_Etat_allume			; Récupérer l'état précédent du capteur
allume
		CMP R10, #0					; Compare le registre R10 à 0
		BEQ front_montant_eteint	; Si oui retourne à l'étiquette front_montant_eteint
		
		B attente_allume			; Sinon continuer l'étape d'allumage

front_montant_eteint
		
		ADD R9, R9, #1				; Incrémentation du compteur des 10 passages
		CMP R9, #0x0A				; Vérifier si le compteur est à 10
		BEQ Allume					; Si oui, alors passer à l'étape d'allumage permanent de la LED

		BL Eteint_LED				; Sinon, éteindre la LED
		MOV R10, #1					; Mettre à jour OldEtat
		
attente_eteint	
		BL Old_Etat_eteint			; Récupérer l'état précédent du capteur
eteint
		CMP R10, #0					; Compare le registre R10 à 0
		BEQ front_montant_allume	; Si oui retourne à l'étiquette front_montant_allume
		
		B attente_eteint
		
		
Old_Etat_allume
		MOV R10, #0					; Initialisation à 0 du registre OldEtat
		LDRH R8, [R4]				; Charge la valeur stockée à l'adresse R4 dans le registre R8
		AND R8,R8, #0x0100			; Effectue un ET binaire entre R8 et 0x0100 et stocke le résultat dans R8
		CMP R8, #0					; Compare la valeur stockée dans R8 à 0
		BEQ Second_check_allume		; Saute à l'étiquette allume2
		B Old_Etat_allume			; Sinon, retourne à l'étiquette Old_Etat_allume
Second_check_allume
		LDRH R8, [R4]				; Charge la valeur stockée à l'adresse R4 dans le registre R8
		AND R8,R8, #0x0100			; Effectue un ET binaire entre R8 et 0x0100 et stocke le résultat dans R8
		CMP R8, #0					; Compare la valeur stockée dans R8 à 0
		BNE allume					; Saute à l'étiquette allume2
		B Second_check_allume		; Sinon, retourne à l'étiquette Old_Etat_allume
		
Old_Etat_eteint
		MOV R10, #0					; Initialisation à 0 du registre OldEtat
		LDRH R8, [R4]				; Charge la valeur stockée à l'adresse R4 dans le registre R8
		AND R8,R8, #0x0100			; Effectue un ET binaire entre R8 et 0x0100 et stocke le résultat dans R8
		CMP R8, #0					; Compare la valeur stockée dans R8 à 0
		BEQ Second_check_eteint					; Si la comparaison n'est pas égale, saute à l'étiquette eteint2
		B Old_Etat_eteint			; Sinon, retourne à l'étiquette Old_Etat_eteint
Second_check_eteint
		LDRH R8, [R4]				; Charge la valeur stockée à l'adresse R4 dans le registre R8
		AND R8,R8, #0x0100			; Effectue un ET binaire entre R8 et 0x0100 et stocke le résultat dans R8
		CMP R8, #0					; Compare la valeur stockée dans R8 à 0
		BNE eteint					; Saute à l'étiquette allume2
		B Second_check_eteint		; Sinon, retourne à l'étiquette Old_Etat_allume



boucle2
Allume	
		BL Allume_LED
		B boucle2
		
	
		B .							; boucle inifinie terminale...

		ENDP

	END

;*******************************************************************************
