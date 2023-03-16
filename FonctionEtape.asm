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

;			ENDP

		


;**************************************************************************
	END