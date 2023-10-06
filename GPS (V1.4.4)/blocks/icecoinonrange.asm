db $42
JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP FIAR
JMP Return : JMP Return : JMP Return

FIAR:		STZ $170B,x		; \ Erase fireball
		%fireball_smoke()

		PHB
		LDA #$02
		PHA			;show coin and stuff
		PLB
		JSL $02889D
		PLB

		%erase_block()

Return:		RTL

print "A frozen block that gives a coin."