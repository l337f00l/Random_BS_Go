db $42
JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP FIAR
JMP Return : JMP Return : JMP Return

FIAR:		STZ $170B,x		; \ Erase fireball
		%fireball_smoke()

		PHY
		LDA #$06		;\
		STA $9C			; | Generate coin block
		JSL $00BEB0		;/
		PLY
		
Return:		RTL

print "A frozen coin."