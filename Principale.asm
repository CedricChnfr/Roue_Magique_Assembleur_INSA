		

;************************************************************************
	THUMB	
	REQUIRE8
	PRESERVE8
;************************************************************************

	include REG_UTILES.inc
	include Lumiere.asm


;************************************************************************
; 					IMPORT/EXPORT Syst�me
;************************************************************************

	IMPORT ||Lib$$Request$$armlib|| [CODE,WEAK]


; IMPORT/EXPORT de proc�dure           

	IMPORT Init_Cible
	IMPORT Driverglobal
	IMPORT Set
	IMPORT Reset
	IMPORT Tempo
	
	

	EXPORT main
	
;*******************************************************************************


;*******************************************************************************
	AREA  mesdonnees, data, readwrite

	


;*******************************************************************************
	
	AREA  moncode, code, readonly
		


;*******************************************************************************
; Proc�dure principale et point d'entr�e du projet
;*******************************************************************************
main  	PROC 
;*******************************************************************************


		
		MOV R0,#0
		BL Init_Cible;			;Initialisation de la cible
			
		BL Tempo
		BL Driverglobal
					

		
		
		B .			 ; boucle inifinie terminale...

		ENDP

	END

;*******************************************************************************
