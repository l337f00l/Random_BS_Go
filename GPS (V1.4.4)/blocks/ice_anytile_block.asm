db $42
JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP FIAR
JMP Return : JMP Return : JMP Return

!Map16tile	=	$012F		;Map16 tile the iceblock should turn into

FIAR:		STZ $170B,x		; \ Erase fireball
		%fireball_smoke()

		REP #$10
		LDX #!Map16tile
		%change_map16()
		SEP #$10

Return:		RTL

print "A frozen version of tile ", hex(!Map16tile), "."