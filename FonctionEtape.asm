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
; Proc�dure ????
;########################################################################
;
; Param�tre entrant  : ???
; Param�tre sortant  : ???
; Variables globales : ???
; Registres modifi�s : ???
;------------------------------------------------------------------------

		;Allumage de la led
Allume_LED	PROC
			;PUSH {R0, R1}			; Sauvegarde les valeurs des registres R0 et R1 dans la pile
			LDR  R0 ,= 0X40010C10	; Chargement de l'adresse de set dans le registre
			MOV R1,#(0x01 << 10)	; D�place la valeur 0x01 qui a �t� d�cal�e de 10 bits vers la gauche dans le registre R1
			STR R1, [R0]			; D�charge la valeur de R1 dans la m�moire � l'adresse stock�e dans R0, ce qui a pour effet d'allumer la LED
			;POP {R0, R1}			; Restaure les valeurs pr�c�demment sauvegard�es des registres R0 et R1 � partir de la pile
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
;			AND R5,R5, #0x0100		; V�rifier si le bit 8 de l'adresse charg�e dans R5 est � 1 ou � 0.
									;TST R4, #0x0100		; V�rifie si le bit 8 de R5 est � 1 ou � 0
;			CMP R5, #0				; Compare R5 � z�ro
;			BNE Eteint				; Si R5 est �gal � z�ro, saute � l'�tiquette Allume_LED (BEQ n'affecte pas LR, il fait un saut)
;			BL Allume_LED			; Si R5 est diff�rent de z�ro, saute � l'�tiquette Eteint_LED. Avec R5 � 0x80 pour 8eme bit � 1 (BEQ)
			
;Eteint
;			BL Eteint_LED
;			BL Capteur
			
;			ENDP

		


;**************************************************************************
	END