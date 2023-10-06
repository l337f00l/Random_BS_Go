db $42
JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP FIAR
JMP Return : JMP Return : JMP Return

!RegularIce	= 	$030E

; ======================================================================
; ======================================================================

FIAR:		PHY
		PHB
		PHK
		PLB

		STZ $170B,x		; \ Erase fireball
		%fireball_smoke()

		REP #$20
		LDY #$06

MakingLoop1:	REP #$10
		LDX #!RegularIce
		%change_map16()
		SEP #$10

		LDA $98
		CLC
		ADC TilePositionY1-$02,y
		STA $98
		LDA $9A
		CLC
		ADC TilePositionX1-$02,y
		STA $9A

		DEY
		DEY
		BPL MakingLoop1
		SEP #$20

		PLB
		PLY
Return:		RTL

TilePositionX1:		dw $0010,$FFF0,$0010
TilePositionY1:		dw $0000,$0010,$0000

print "The top left of a 32x32 ice block that splits when thawed."