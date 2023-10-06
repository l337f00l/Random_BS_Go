db $42

	!TYPE = $01		; 00 = Kills intantly
				; 01 = Hurts

JMP Mario : JMP Mario : JMP HitboxCheck
JMP Return : JMP Return
JMP Return : JMP Return
JMP HitboxCheck : JMP HitboxCheck : JMP HitboxCheck
table:	db $02,$0D

HitboxCheck:			; prevents janky hitbox
    	LDX $93                   
    	LDA $94
	AND #$0F
	CMP table,x
	BEQ Return
Mario:
	LDA $14AF|!addr               ;\ Load ON/OFF Switch Status
	BEQ Return      	 ; Change this to bne if you want it to switch when the switch is on
	LDA $1470|!addr
	ORA $148F|!addr
	BNE Return		; if holding an item, return
	if !TYPE == 1
	PHY 
	JSL $00F5B7|!bank       ; Hurts
	PLY
	else	
	JSL $00F606|!bank       ; Kill
	endif
	BRA Return
Return:
	RTL

print "Hurts or Kill if not holding a sprite"