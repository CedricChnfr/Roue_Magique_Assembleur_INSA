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



Driverglobal	PROC
				BL Set
				
				MOV R1, #1						; Initialisation du compteur de LED à 1
				MOV R2, #48						; Initialisation de la limite supérieure de la boucle à 48
				
BoucleLed
				LDR  R7 ,= Barrette1	
				LDRB R3, [R7, R1]		; Récupération de la valeur depuis Barrette1
				LSL	R4, R3, #24					; Décalage à gauche de 24 bits de R3, stocké dans R4
				
				MOV R5, #1
				MOV R6, #12
				
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
				CMP R5, R6
				BNE BoucleBit
				
				ADD R1, R1, #1
				CMP R1, R2
				BNE BoucleLed
				
				BL Reset
				LDR  R8 ,= DataSend	
				LDRB R9, [R8, #0]
				;MOV DataSend, #0
				
				BX LR
				ENDP


			; Procédure Set: envoie un signal HIGH au registre de données
Set 	PROC
		LDR R0, =DataSend
		MOV R1, #1
		STR R1, [R0]
		BX LR
		ENDP
		
	; Procédure Reset: envoie un signal LOW au registre de données
Reset 	PROC
		LDR R0, =DataSend
		MOV R1, #0
		STR R1, [R0]
		BX LR
		ENDP



		;Tempo Proc
		
;ENDP

		


;**************************************************************************
		END