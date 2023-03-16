		

;************************************************************************
	THUMB	
	REQUIRE8
	PRESERVE8
;************************************************************************

	include REG_UTILES.inc
	


;************************************************************************
; 					IMPORT/EXPORT Syst�me
;************************************************************************

	IMPORT ||Lib$$Request$$armlib|| [CODE,WEAK]

	IMPORT Allume_LED
	IMPORT Eteint_LED
	;IMPORT Capteur


; IMPORT/EXPORT de proc�dure           

	IMPORT Init_Cible
	

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
;
;
;Var DCB 1,2,3
;	 DCB 4, 5, 6
;
;
;LDR R4,= Var

		
		MOV R0,#0
		BL Init_Cible;			;Initialisation de la cible
			

					
		
boucle

			
			LDR  R4 ,= 0X40010808	; Charge l'adresse 0X40010808 dans le registre R5.
			LDRH R5,[R4]			; Stock la valeur de l'adresse de R4 dans R5
			AND R5,R5, #0x0100		; V�rifier si le bit 8 de l'adresse charg�e dans R5 est � 1 ou � 0.
									;TST R4, #0x0100		; V�rifie si le bit 8 de R5 est � 1 ou � 0
			CMP R5, #0				; Compare R5 � z�ro
			BNE Eteint				; Si R5 est �gal � z�ro, saute � l'�tiquette Allume_LED (BEQ n'affecte pas LR, il fait un saut)
			BL Allume_LED			; Si R5 est diff�rent de z�ro, saute � l'�tiquette Eteint_LED. Avec R5 � 0x80 pour 8eme bit � 1 (BEQ)
		
			B boucle	       


Eteint
		BL Eteint_LED
		B boucle
		
		
		
		
		
		B .			 ; boucle inifinie terminale...

		ENDP

	END

;*******************************************************************************
