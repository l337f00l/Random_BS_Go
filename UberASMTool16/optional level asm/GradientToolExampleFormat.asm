; A couple small things were changed from the code that GradientTool auto-generates 
; when you have "Generate Initialization Code" checked.
; The first part of this only deals with the HDMA channels.
; You usually only need to concern yourself with replacing the tables at the bottom
; with the ones you generate.

init:
	REP   #$20 ; 16-bit A

	; Set transfer modes.
	LDA   #$3202
	STA   $4330 ; Channel 3
	LDA   #$3200
	STA   $4340 ; Channel 4

	; Point to HDMA tables.
	LDA   #Gradient1_RedGreenTable
	STA   $4332
	LDA   #Gradient1_BlueTable
	STA   $4342

	SEP   #$20 ; 8-bit A

	; Store program bank to $43x4.
	PHK
	PLA
	STA   $4334 ; Channel 3
	STA   $4344 ; Channel 4

	; Enable channels 3 and 4.
	LDA.b #%00011000
	TSB   $0D9F

	RTL ; <-- Was originally RTS.

; --- HDMA Tables below this line ---
Gradient1_RedGreenTable:
db $14,$22,$40
db $17,$21,$40
db $80,$20,$40
db $35,$20,$40
db $00

Gradient1_BlueTable:
db $01,$8C
db $05,$8B
db $04,$8A
db $05,$89
db $05,$88
db $04,$87
db $05,$86
db $05,$85
db $04,$84
db $05,$83
db $05,$82
db $04,$81
db $80,$80
db $2C,$80
db $00