;***************************************************************************
	THUMB	
	REQUIRE8
	PRESERVE8
;**************************************************************************


;***************VARIABLES**************************************************
	 AREA  MesDonnees, data, readwrite
;**************************************************************************


					
;**************************************************************************



;***************CODE*******************************************************
   	AREA  moncode, code, readonly
;**************************************************************************



  

		;AREA Lumiere, data, readwrite
			
Barrette1       SPACE      48         ; R�servation de 48 octets pour la variable Barrette1
;Barrette1 DCB 48 dup(0)			; Initialiser � 0 
		

	DCB 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Allume les deux premi�res Leds en rouge (0xFF) et le reste �teint (0x00)
	DCB 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Allume les deux premi�res Leds en rouge (0xFF) et le reste �teint (0x00)
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Eteint toutes les Leds
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Eteint toutes les Leds
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Eteint toutes les Leds
	DCB 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Eteint toutes les Leds
		END
			
			
			

