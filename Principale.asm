		

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
		BL Init_Cible;			;Initialisation de la cible
			


OldEtat		DCW		0			;Variable pour stocker l'?tat pr?c?dent du capteur
Cpt			DCB		0		;Compteur de fronts montants d?tect?s
N			EQU		10			;Nombre de fronts montants ? d?tecter avant de rester allum?

boucle


		;Etat du capteur
		LDR  R4 ,= 0X40010808		; Chargement de l'adresse dans le registre
		LDRH R8, [R4]				; Stock la valeur de l'adresse de R4 dans R5
		LDR R9, =N
		LDRH R10, [R9]
		AND R8,R8, #0x0100			; V?rifier si le bit 8 de l'adresse charg?e dans R5 est ? 1 ou ? 0.
		CMP R8, #0					; Compare R8 ? z?ro OU CMP R8, #(0x01 << 8)
		BNE allume					; Si zero alors j'allume
		MOV R7,#0x00				; 
		B boucle
		
	
					
		
allume

		BL Allume_LED
		

		ADD R10, R10, #1
		AND R11,R10, #0x0A
		CMP R10, #0x0A
		BEQ Allume
		
		
		LDRH R8, [R4]				; Stock la valeur de l'adresse de R4 dans R5
		AND R8,R8, #0x0100
		CMP R8, #0
		BNE eteint
		
		B allume
		
		
		
		B boucle


	

eteint
		BL Eteint_LED
		
		ADD R10, #0x01
		AND R11,R10, #0x0A
		CMP R11, #0x0A
		BEQ Allume
		
		
		LDRH R8, [R4]				; Stock la valeur de l'adresse de R4 dans R5
		AND R8,R8, #0x0100
		CMP R8, #0
		BNE allume
		
		B eteint
		
		B boucle
		
		
		
		
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
