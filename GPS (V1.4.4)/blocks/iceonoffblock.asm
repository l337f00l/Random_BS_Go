db $42
JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP FIAR
JMP Return : JMP Return : JMP Return

FIAR:		STZ $170B,x		; \ Erase fireball
		%fireball_smoke()

		PHY
		LDA #$13		;\
		STA $9C			; | Generate on-off block block
		JSL $00BEB0		;/
		PLY

Return:		RTL

print "A frozen ON-OFF block."