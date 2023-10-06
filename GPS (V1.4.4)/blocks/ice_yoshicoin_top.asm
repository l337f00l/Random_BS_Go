db $42
JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP FIAR
JMP Return : JMP Return : JMP Return

!Map16tileb	=	$002E		;bottom tile of regular Yoshi Coin
!Map16tilet	=	$002D		;top tile of regular Yoshi coin

FIAR:		STZ $170B,x		; \ Erase fireball
		%fireball_smoke()

		REP #$30		;\
		LDX #!Map16tilet	; |
		%change_map16()

		LDA $98
		CLC
		ADC #$0010
		STA $98

		LDX #!Map16tileb	;\
		%change_map16()
		SEP #$30
Return:		RTL

print "The top of a frozen Yoshi coin."