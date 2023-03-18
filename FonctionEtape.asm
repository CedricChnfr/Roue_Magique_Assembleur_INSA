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

	EXPORT Allume_LED
	EXPORT Eteint_LED
	;EXPORT Capteur

;**************************************************************************



;***************CONSTANTES*************************************************

	include REG_UTILES.inc 

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
;
; Paramètre entrant  : ???
; Paramètre sortant  : ???
; Variables globales : ???
; Registres modifiés : ???
;------------------------------------------------------------------------

		;Allumage de la led
Allume_LED	PROC
			;PUSH {R0, R1}			; Sauvegarde les valeurs des registres R0 et R1 dans la pile
			LDR  R0 ,= 0X40010C10	; Chargement de l'adresse de set dans le registre
			MOV R1,#(0x01 << 10)	; Déplace la valeur 0x01 qui a été décalée de 10 bits vers la gauche dans le registre R1
			STR R1, [R0]			; Décharge la valeur de R1 dans la mémoire à l'adresse stockée dans R0, ce qui a pour effet d'allumer la LED
			;POP {R0, R1}			; Restaure les valeurs précédemment sauvegardées des registres R0 et R1 à partir de la pile
			BX LR					; Retourne au point d'appel de la sous-routine
			ENDP
		
		;Eteindre de la led
Eteint_LED	PROC
			;PUSH {R2, R3}
			LDR  R2 ,= 0X40010C14	
			MOV R3,#(0x01 << 10)	
			STR R3, [R2]			
			;POP {R2, R3}
			BX LR					
			ENDP
				
;Capteur	PROC
;			LDR  R4 ,= 0X40010808	; Charge l'adresse 0X40010808 dans le registre R5.
;			LDRH R5,[R4]			; Stock la valeur de l'adresse de R4 dans R5
;			AND R5,R5, #0x0100		; Vérifier si le bit 8 de l'adresse chargée dans R5 est à 1 ou à 0.
									;TST R4, #0x0100		; Vérifie si le bit 8 de R5 est à 1 ou à 0
;			CMP R5, #0				; Compare R5 à zéro
;			BNE Eteint				; Si R5 est égal à zéro, saute à l'étiquette Allume_LED (BEQ n'affecte pas LR, il fait un saut)
;			BL Allume_LED			; Si R5 est différent de zéro, saute à l'étiquette Eteint_LED. Avec R5 à 0x80 pour 8eme bit à 1 (BEQ)
			
;Eteint
;			BL Eteint_LED
;			BL Capteur
			
;			ENDP

		


;**************************************************************************
	END