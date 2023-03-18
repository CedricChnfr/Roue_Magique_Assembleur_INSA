		

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


;OldEtat = 0
;Cpt = 0
;N=10
;
;Tant que 1
;
;FrontMontant:
;	Si OldEtat == 0 et Capteur == 1
;		Led = !Led
;		Cpt = Cpt + 1 
;	Si Compteur >= N
;		Led = 1
;	
;	OldEtat = Capteur
;
;Fin tant que
;
;


		
		MOV R0,#0
		BL Init_Cible;				;Initialisation de la cible
			


;OldEtat		DCW		0				;Variable pour stocker l'?tat pr?c?dent du capteur
;Cpt			DCW		0				;Compteur de fronts montants d?tect?s
;N			EQU		10				;Nombre de fronts montants ? d�tecter avant de rester allum�

boucle

		;Etat du capteur
		LDR  R4 ,= 0X40010808		; Chargement de l'adresse dans le registre
		LDRH R8, [R4]				; Stock la valeur de l'adresse de R4 dans R8
		
		MOV R9, #0					; Registre du compteur des 10 passages
		
		;MOV R10, #0					; Registre de OlEtat
		
		AND R8,R8, #0x0100			; V�rifier si le bit 8 de l'adresse charg�e dans R5 est ? 1 ou ? 0.
		CMP R8, #0					; Compare R8 ? z�ro OU CMP R8, #(0x01 << 8)
		BNE front_montant_allume	; Si zero alors j'allume			
		B boucle
			
front_montant_allume
		
		ADD R9, R9, #1
		CMP R9, #0x0A
		BEQ Allume
		
allume
		BL Allume_LED
		
		CMP R8, #0
		BNE front_montant_eteint
		
		B allume

front_montant_eteint
		
		ADD R9, R9, #1
		CMP R9, #0x0A
		BEQ Allume
		
		
eteint	
		BL Eteint_LED
		LDRH R8, [R4]				; Stock la valeur de l'adresse de R4 dans R5
		AND R8,R8, #0x0100
		CMP R8, #0
		BNE front_montant_allume
		
		B eteint
		
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
