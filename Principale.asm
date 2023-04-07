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


M		EQU 10

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
		
		
		
Clignotement
	
		
		;BL Driverglobal
		LDR R0, =BarretteN
		BL DriverReg
		
		;Tempo
		MOV R0, #500
		BL Tempo
		
		;BL Driverglobal
		LDR R0, =Barrette1
		BL DriverReg
		
		;Tempo
		MOV R0, #500
		BL Tempo
		
		LDR  R6 ,= GPIOBASEA
		LDR  R6, [R6, #OffsetInput]
		AND R6, R6, #0x0100
		CMP R6, #0x0100
		BNE Fin
		ADD R12, R12, #1
		CMP R12, #M
		BNE Clignotement
		
		

Fin
		
		B .			 ; boucle inifinie terminale...

		ENDP

	END

;*******************************************************************************