		

;************************************************************************
	THUMB	
	REQUIRE8
	PRESERVE8
;************************************************************************

	include REG_UTILES.inc
	


;************************************************************************
; 					IMPORT/EXPORT Système
;************************************************************************

	IMPORT ||Lib$$Request$$armlib|| [CODE,WEAK]

	IMPORT Allume_LED
	IMPORT Eteint_LED
	;IMPORT Capteur


; IMPORT/EXPORT de procédure           

	IMPORT Init_Cible
	

	EXPORT main
	
;*******************************************************************************


;*******************************************************************************
	AREA  mesdonnees, data, readwrite

	


;*******************************************************************************
	
	AREA  moncode, code, readonly
		


;*******************************************************************************
; Procédure principale et point d'entrée du projet
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
			


OldEtat		DCW		0
;Cpt			DCB		0
N			EQU		10

boucle


		LDR  R4 ,= 0X40010808
		LDRH R8, [R4]
		AND R8,R8, #0x0100
		CMP R8, #0
		BEQ allume
		MOV R7,#0x00
		B boucle
		
		check
		LDR R6, =OldEtat
		LDRH R7,[R6]		
		MOV R7,#0x01
		AND R7,R7, #0x01
		CMP R6, #0
		BNE exstate1
		

		
		
		LDR R9, =N
		LDRH R10, [R9]
		AND R10,R10, #0x0A
		CMP R10, #0x0A
		BL Allume
		
		
	
	
allume

		BL Allume_LED
		ADD R10, #0x01
		
		AND R8,R8, #0x0100
		CMP R8, #0
		BNE eteint
		
		B boucle
		

check

		BL Eteint_LED
		MOV R7,#0x01
		
		B boucle


		

exstate1
		B boucle
	
	





boucle2
Allume	
		B boucle2

		
		
		
	
		B boucle







       

Eteint
		BL Eteint_LED
		B boucle
		
		
		
		
		
		B .			 ; boucle inifinie terminale...

		ENDP

	END

;*******************************************************************************
