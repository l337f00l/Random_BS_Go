db $42
JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP FIAR
JMP Return : JMP Return : JMP Return

FIAR:		STZ $170B,x		; \ Erase fireball
		%fireball_smoke()
		
		%erase_block()

Return:		RTL

print "A frozen block that disappears when thawed."