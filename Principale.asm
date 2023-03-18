		

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
	BL Init_Cible;				;Initialisation de la cible

boucle

		;Etat du capteur
		LDR  R4 ,= 0X40010808		; Chargement de l'adresse dans le registre
		LDRH R8, [R4]				; Stock la valeur de l'adresse de R4 dans R8
		
		MOV R9, #0					; Registre du compteur des 10 passages
		
		MOV R10, #0					; Registre OlEtat
		
		AND R8,R8, #0x0100			; Vérifier si le bit 8 de l'adresse chargée dans R5 est à 1 ou à 0.
		CMP R8, #0					; Compare R8 à zéro OU CMP R8, #(0x01 << 8)
		BNE front_montant_allume	; Si zero alors j'allume			
		B boucle
			
front_montant_allume
		
		ADD R9, R9, #1
		CMP R9, #0x0A
		BEQ Allume
		
		BL Allume_LED
		MOV R10, #1
		
allume
		
		BL Old_Etat
allume2
		CMP R10, #0
		BEQ front_montant_eteint
		
		B allume

front_montant_eteint
		
		ADD R9, R9, #1
		CMP R9, #0x0A
		BEQ Allume
		
		BL Eteint_LED
		MOV R10, #1
		
eteint	
		BL Old_Etat2
		MOV R10, #1
eteint2
		
		CMP R10, #0
		BEQ front_montant_allume
		
		B eteint
		
		
Old_Etat
		MOV R10, #0
		LDRH R8, [R4]				; Stock la valeur de l'adresse de R4 dans R5
		AND R8,R8, #0x0100
		CMP R8, #0
		BEQ allume2
		B Old_Etat
		
Old_Etat2
		MOV R10, #0
		LDRH R8, [R4]				; Stock la valeur de l'adresse de R4 dans R5
		AND R8,R8, #0x0100
		CMP R8, #0
		BNE eteint2
		B Old_Etat2

boucle2
Allume	
		BL Allume_LED
		B boucle2
		
	
		
		
		
;check
;		LDR R6, =OldEtat
;		LDRH R7,[R6]		
;		MOV R7,#0x01
;		AND R7,R7, #0x01
;		CMP R6, #0
;		BNE exstate1
		
		B .			 ; boucle inifinie terminale...

		ENDP

	END

;*******************************************************************************
