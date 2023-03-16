		

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


;Bool Capteur
;Bool Led
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
;Var DCB 1,2,3
;	 DCB 4, 5, 6
;
;
;LDR R4,= Var

		
		MOV R0,#0
		BL Init_Cible;			;Initialisation de la cible
			

					
		
boucle

			
			LDR  R4 ,= 0X40010808	; Charge l'adresse 0X40010808 dans le registre R5.
			LDRH R5,[R4]			; Stock la valeur de l'adresse de R4 dans R5
			AND R5,R5, #0x0100		; Vérifier si le bit 8 de l'adresse chargée dans R5 est à 1 ou à 0.
									;TST R4, #0x0100		; Vérifie si le bit 8 de R5 est à 1 ou à 0
			CMP R5, #0				; Compare R5 à zéro
			BNE Eteint				; Si R5 est égal à zéro, saute à l'étiquette Allume_LED (BEQ n'affecte pas LR, il fait un saut)
			BL Allume_LED			; Si R5 est différent de zéro, saute à l'étiquette Eteint_LED. Avec R5 à 0x80 pour 8eme bit à 1 (BEQ)
		
			B boucle	       


Eteint
		BL Eteint_LED
		B boucle
		
		
		
		
		
		B .			 ; boucle inifinie terminale...

		ENDP

	END

;*******************************************************************************
