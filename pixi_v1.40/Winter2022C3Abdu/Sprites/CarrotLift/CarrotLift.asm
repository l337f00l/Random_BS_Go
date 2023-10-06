;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Carrot lift platform disassembly based of all.log 
;; by Abdu
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;=======Misc sprite tables defines=======
!MovementTimer 	= !1540
!PlatformType 	= !1528 	; 0 up-right platform, anything else up-left.
!PreviousXPos	= !151C 	; used to see if the player is on the platform.
!MovementPhase	= !C2  		; current value mod 4, so 0/2: dont move, 1: moving left, 3: moving right. 
!ExtraBits 		= $04
;========================================

print "INIT ",pc
	LDY #$B7
	LDA !7FAB10,x
	AND #!ExtraBits
	STA !PlatformType,x	
	BEQ +
	INY
	+
	TYA
	STA !9E,x
RTL


print "MAIN ",pc
	PHB : PHK : PLB
	JSR CarrotTopLift
	PLB
RTL

InteractionYPos: 							; Interaction Y positions for the Carrot Top Lift at each X position. This effctively defines the shape of the platform.
	db $20,$20,$20,$20,$20,$20,$20,$20		; Up-Right platform
	db $20,$20,$20,$20,$20,$20,$20,$20
	db $20,$1F,$1E,$1D,$1C,$1B,$1A,$19
	db $18,$17,$16,$15,$14,$13,$12,$11
	db $10,$0F,$0E,$0D,$0C,$0B,$0A,$09
	db $08,$07,$06,$05,$04,$03,$02,$01
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	
	db $00,$00,$00,$00,$00,$00,$00,$00		; Up-Left platform
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $01,$02,$03,$04,$05,$06,$07,$08
	db $09,$0A,$0B,$0C,$0D,$0E,$0F,$10
	db $11,$12,$13,$14,$15,$16,$17,$18
	db $19,$1A,$1B,$1C,$1D,$1E,$1F,$20
	db $20,$20,$20,$20,$20,$20,$20,$20
	db $20,$20,$20,$20,$20,$20,$20,$20

Speed:							; Movement speeds for the Carrot Top Lift.
	db $00,$F8,$00,$08




	
CarrotTopLift:
	JSR Graphics
	LDA $9D						;\ Return if game frozen.
	BEQ +						;/
	RTS
	+

	%SubOffScreen()
	LDA !MovementTimer,x
	BNE .keepMoving
	INC !MovementPhase,x		; increment phase movement pointer
	LDA #$80					;\ Set timer for how long the next movement phase should last
	STA !MovementTimer,x		;/

.keepMoving:
	LDA !MovementPhase,x		;\ 
	AND #$03					;|
	TAY							;| Store X speed for the current movement.
	LDA Speed,y					;|
	STA !B6,x					;/

	LDY !PlatformType,x			; if the extra bit is clear...
	BNE .NoInvert				; Store Y speed for the current movement, as equal to the X speed.
	EOR #$FF					; If sprite B8 (up-left), reverse the Y speed.
	INC 						
	.NoInvert						
	STA !AA,x
	JSL $01801A|!BankB			; Update Y position.

	LDA !E4,x					;\ Preserve old X position, for moving Mario with the platform.
	STA !PreviousXPos,x			;/
	JSL $018022|!BankB			; Update X position.

	JSR GetClipping				;\ 
	JSL $03B69F|!BankB			;|
	JSL $03B72B|!BankB			;| Return if not in contact with the platform, or Mario is moving upwards.
	BCC .Ret					;|
	LDA $7D						;|
	BMI .Ret					;/

	LDA $94						;\ 
	SEC							;|
	SBC !PreviousXPos,x			;|
	CLC							;|
	ADC #$1C					;|
	LDY !PlatformType,x			;| Get the index to the to the Y pos table based on the X position.
	BEQ .skip					;| up-right platform so no need to index the second portion of the table.
	CLC							;|
	ADC #$38					;| so if its an up-left platform add #$38 to index the second portion.
	.skip						;|
	TAY							;/

	LDA $187A|!Base2			;\ 
	CMP #$01					;|
	LDA #$20					;|
	BCC .notOnYoshi				;| Get lower interaction point for Mario's Y position, accounting for whether he's on Yoshi or not.
	LDA #$30					;|  This point determines whether or not Mario is on top of the platform.
	.notOnYoshi					;|
	CLC							;|
	ADC $96						;|
	STA $00						;/

	LDA !D8,x					;\ 
	CLC							;|
	ADC InteractionYPos,y		;| If player is not touching the sprite at the current X position
	CMP $00						;|
	BPL .Ret					;/ the return.

	LDA $187A|!Base2			;\ 
	CMP #$01					;|
	LDA #$1D					;| Get upper interaction point for Mario's Y position, accounting for whether he's on Yoshi or not.
	BCC .noYoshiOnSpr			;|  This point indicates where Mario's feet are relative to his position.
	LDA #$2D					;|
.noYoshiOnSpr:					;|
	STA $00						;/

	LDA !D8,x					;\ 
	CLC							;|
	ADC InteractionYPos,y		;|
	PHP							;|
	SEC							;|
	SBC $00						;| Move Mario on top of the platform.
	STA $96						;|
	LDA !14D4,x					;|
	SBC #$00					;|
	PLP							;|
	ADC #$00					;|
	STA $97						;/

	STZ $7D						;| Clear Mario's Y speed.

	LDA #$01					;\ On Sprite flag is set.
	STA $1471|!Base2			;/

	LDY #$00					;\ 
	LDA $1491|!Base2			;|
	BPL .movePlayer				;|
	DEY							;|
	.movePlayer					;|
	CLC							;| Move player horizontally with the platform.
	ADC $94						;|
	STA $94						;|
	TYA							;|
	ADC $95						;|
	STA $95						;/

	.Ret
	RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Routine that sets up some scratch RAM to get 
; Mario's clipping data for Carrot Top platform.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GetClipping:
	LDA $94						;\ 
	CLC							;|
	ADC #$04					;|
	STA $00						;| Get clipping X position.
	LDA $95						;|
	ADC #$00					;|
	STA $08						;/

	LDA #$08					;\ 
	STA $02						;| Get interaction area as an 8x8 square.
	STA $03						;/

	LDA #$20
	LDY $187A|!Base2
	BEQ .notOnYoshi
	LDA #$30
.notOnYoshi:
	CLC							;\ 
	ADC $96						;|
	STA $01						;|Get clipping Y position.
	LDA $97						;|
	ADC #$00					;|
	STA $09						;/
	RTS



DiagPlatDispX:					; X offsets for each tile of the Carrot Top platform.
	db $10,$00,$10				; Down-left
	db $00,$10,$00				; Up-left

DiagPlatDispY:					; Y offsets for each tile of the Carrot Top platform.
	db $00,$10,$10				; Down-left
	db $00,$10,$10				; Up-left

DiagPlatTiles2:					; Tile numbers for each tile of the Carrot Top platform.
	db $E4,$E0,$E2				; Down-left
	db $E4,$E0,$E2				; Up-left

DiagPlatGfxProp:				; YXPPCCCT for each tile of the Carrot Top platform.
	db $0B,$0B,$0B				; Down-left
	db $4B,$4B,$4B				; Up-left

Graphics:
	%GetDrawInfo()
	PHX			
	LDA !PlatformType,x			
	CMP #$01
	LDX #$02					; Get index to the above tables, based on which platform this is.
	STX $02						
	BCC .loop				
	LDX #$05					
	.loop				
	
	LDA $00						;\ Get sprite X pos
	CLC							;| 
	ADC DiagPlatDispX,x			;| Add X displacement
	STA $0300|!Base2,y			;/

	LDA $01						;\ Get sprite Y pos
	CLC							;|
	ADC DiagPlatDispY,x			;| Get sprite Y pos
	STA $0301|!Base2,y			;/

	LDA DiagPlatTiles2,x		;\ Get tile number
	STA $0302,y					;/

	LDA DiagPlatGfxProp,x		;\ Store tile properties
	ORA $64						;|
	STA $0303|!Base2,y			;/
	INY #4					 
	DEX							;\ Decrease number of tiles to draw					
	DEC $02						;|
	BPL .loop					;/ not done yet so loop.

	PLX							; Get sprite index back		
	LDY #$02					; 16x16 tiles
	TYA
	JSL $01B7B3|!BankB
	RTS
