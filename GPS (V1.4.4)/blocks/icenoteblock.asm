db $42
JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP FIAR
JMP Return : JMP Return : JMP Return

FIAR:		STZ $170B,x		; \ Erase fireball
		%fireball_smoke()

		PHY
		LDA #$0E		;\
		STA $9C			; | Generate note block
		JSL $00BEB0		;/
		PLY

Return:		RTL

print "A frozen note block."