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
	EXPORT DriverReg
	EXPORT Set_SCLK
	EXPORT Reset_SCLK
	EXPORT Set_SIN
	EXPORT Reset_SIN
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
				BL Set_SCLK	; Set(SCLK)
				MOV R1, #1	; Initialisation du compteur de LED ? 1
				
BoucleLed
				LDR  R7 ,=Barrette1	; On load les valeur de la barette dans R7
				LDRB R3, [R7, R1] ; R3 = ValCourante, On met la valeur de Barette[n] dans R3
				LSL	R4, R3, #24	; (ValCourante) <- (ValCourante) << 24
				
				MOV R5, #0
				
BoucleBit
				BL Reset_SCLK
				
				TST R4, #(0x1<<31)				; Compare le bit de poid fort 32eme
				BNE Bit1
				BL Reset_SIN
				B NextBit
				
Bit1
				BL Set_SIN
				
NextBit
				LSL	R4, R4, #1
				BL Set_SCLK
				
				ADD R5, R5, #1 ; i++
				CMP R5, #12
				BNE BoucleBit
				
				ADD R1, R1, #1
				CMP R1, #48
				BNE BoucleLed
				
				BL Reset_SCLK
				
				LDR  R8 ,=DataSend	
				MOV R9, #0
				STRB R9, [R8]
				;MOV DataSend, #0
				
				BX LR
				ENDP


			; Procédure Set: envoie un signal HIGH au registre de donn?es
Set_SCLK 	PROC
			PUSH {R0, R1}
			LDR R0, =GPIOBASEA
			LDRH R1,[R0,#OffsetSet]
			MOV R1,#(0x01 << 5)
			STRH R1, [R0, #OffsetSet]
			POP {R0, R1}
			BX LR
			ENDP
		
	; Proc?dure Reset: envoie un signal LOW au registre de donn?es
Reset_SCLK 	PROC
			PUSH {R0, R1}
			LDR R0, =GPIOBASEA
			LDRH R1,[R0,#OffsetReset]
			MOV R1,#(0x01 << 5)
			STRH R1, [R0, #OffsetReset]
			POP {R0, R1}
			BX LR
			ENDP
			
Set_SIN 	PROC
			PUSH {R0, R1}
			LDR R0, = GPIOBASEA
			LDRH R1,[R0,#OffsetSet]
			MOV R1,#(0x01 << 7)
			STRH R1, [R0, #OffsetSet]
			POP {R0, R1}
			BX LR
			ENDP
		
	; Proc?dure Reset: envoie un signal LOW au registre de donn?es
Reset_SIN 	PROC
			PUSH {R0, R1}
			LDR R0, =GPIOBASEA
			LDRH R1,[R0,#OffsetReset]
			MOV R1,#(0x01 << 7)
			STRH R1, [R0, #OffsetReset]
			POP {R0, R1}
			BX LR
			ENDP


;R1, R6, R10, R11, R12
;Vérifier tempo
Tempo 	PROC
	
		MOV R11, #0		
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

		
		
		
		
DriverReg	PROC
				BL Set_SCLK	; Set(SCLK)
				MOV R1, #1	; Initialisation du compteur de LED ? 1
				
BoucleLed2
				MOV  R7 ,R0	; On load les valeur de la barette dans R7
				LDRB R3, [R7, R1] ; R3 = ValCourante, On met la valeur de Barette[n] dans R3
				LSL	R4, R3, #24	; (ValCourante) <- (ValCourante) << 24
				
				MOV R5, #0
				
BoucleBit2
				BL Reset_SCLK
				
				TST R4, #(0x1<<31)				; Compare le bit de poid fort 32eme
				BNE Bit2
				BL Reset_SIN
				B NextBit2
				
Bit2
				BL Set_SIN
				
NextBit2
				LSL	R4, R4, #1
				BL Set_SCLK
				
				ADD R5, R5, #1 ; i++
				CMP R5, #12
				BNE BoucleBit2
				
				ADD R1, R1, #1
				CMP R1, #48
				BNE BoucleLed2
				
				BL Reset_SCLK
				
				LDR  R8 ,=DataSend	
				MOV R9, #0
				STRB R9, [R8]
				
				BX LR
			
			ENDP


;**************************************************************************
		END