;************************************************************************
	THUMB	
	REQUIRE8
	PRESERVE8
;************************************************************************

	include REG_UTILES.inc
	include Lumiere.asm


;************************************************************************
; 					IMPORT/EXPORT Syst?me
;************************************************************************

	IMPORT ||Lib$$Request$$armlib|| [CODE,WEAK]


; IMPORT/EXPORT de proc?dure           

	IMPORT Init_Cible
	IMPORT Driverglobal
	IMPORT DriverReg
	IMPORT Set_SCLK
	IMPORT Reset_SCLK
	IMPORT Set_SIN
	IMPORT Reset_SIN
	IMPORT Tempo
	
	

	EXPORT main
	
;*******************************************************************************


;*******************************************************************************
	AREA  mesdonnees, data, readwrite

	


;*******************************************************************************
	
	AREA  moncode, code, readonly
		


;*******************************************************************************
; Procédure principale et point d'entr?e du projet
;*******************************************************************************
main  	PROC 
;*******************************************************************************


		
		MOV R0,#1
		BL Init_Cible;			;Initialisation de la cible
		
		;Tempo
		MOV R0, #10
		BL Tempo
		
		
		;BL Driverglobal
		
		LDR R0, =BarretteN
		BL DriverReg

		
		
		B .			 ; boucle inifinie terminale...

		ENDP

	END

;*******************************************************************************