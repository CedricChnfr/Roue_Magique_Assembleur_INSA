;***************************************************************************
	THUMB	
	REQUIRE8
	PRESERVE8

;**************************************************************************
;  Fichier Vierge.asm
; Auteur : V.MAHOUT
; Date :  12/11/2013
;**************************************************************************

;***************IMPORT/EXPORT**********************************************
	EXPORT Driverglobal
	EXPORT Set
	EXPORT Reset
	EXPORT Tempo
	IMPORT DataSend

;**************************************************************************



;***************CONSTANTES*************************************************

	include REG_UTILES.inc 
	include Lumiere.asm
	;AREA MesConstantes, data, readwrite

	
	
						

		

;**************************************************************************


;***************VARIABLES**************************************************
	 AREA  MesDonnees, data, readwrite
;**************************************************************************



;**************************************************************************



;***************CODE*******************************************************
   	AREA  moncode, code, readonly
;**************************************************************************





;########################################################################
; Procédure ????
;########################################################################


;Fonction permettant d'envoyer en série les 576 bits du tableau
Driverglobal	PROC
				BL Set	
				MOV R1, #1						; Initialisation du compteur de LED à 1
				
BoucleLed
				LDR  R7 ,= Barrette1	
				LDRB R3, [R7, R1]				; Récupération de la valeur depuis Barrette1
				LSL	R4, R3, #24					; Décalage à gauche de 24 bits de R3, stocké dans R4
				
				MOV R5, #1
				
BoucleBit
				BL Reset
				
				CMP R4, #0x80000000				; Compare le bit de poid fort 32eme
				BEQ Bit0
				BL Set
				B NextBit
				
Bit0
				BL Reset
				
NextBit
				LSL	R4, R4, #1
				ADD R5, R5, #1
				CMP R5, #12
				BNE BoucleBit
				
				ADD R1, R1, #1
				CMP R1, #48
				BNE BoucleLed
				
				BL Reset
				
				LDR  R8 ,= DataSend	
				MOV R9, #0
				STRB R9, [R8]
				;MOV DataSend, #0
				
				BX LR
				ENDP


			; Procédure Set: envoie un signal HIGH au registre de données
Set 	PROC
		PUSH {R0, R1}
		LDR R0, = GPIOBASEA
		LDRH R1,[R0,#OffsetOutput]
		MOV R1,#(0x01 << 5)
		STR R1, [R0]
		POP {R0, R1}
		BX LR
		ENDP
		
	; Procédure Reset: envoie un signal LOW au registre de données
Reset 	PROC
		PUSH {R0, R1}
		LDR R0, =GPIOBASEA
		LDRH R1,[R0,#OffsetOutput]
		MOV R1,#(0x00 << 5)
		STR R1, [R0]
		POP {R0, R1}
		BX LR
		ENDP


;R1, R6, R10, R11, R12
;Vérifier tempo
Tempo 	PROC
	
		MOV R10, #0
		MOV R11, #0
		MOV R12, #10
		MOV R6, #MILSEC
		MUL R0, R6, R12		
		
boucle_10N
		MOV R10, #0
		ADD R11, R11, #1
		CMP R11, R0
		BXEQ LR
		
boucle
		ADD R10, R10, #1		
		CMP R10, #MILSEC	
		BNE boucle
		
		BEQ boucle_10N
		ENDP

		


;**************************************************************************
		END