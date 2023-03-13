		

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
	IMPORT Capteur


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


		
		MOV R0,#0
		BL Init_Cible;			;Initialisation de la cible
			

					
		
boucle

		BL Capteur
		
			B boucle	       


		
		
		
		
		B .			 ; boucle inifinie terminale...

		ENDP

	END

;*******************************************************************************
