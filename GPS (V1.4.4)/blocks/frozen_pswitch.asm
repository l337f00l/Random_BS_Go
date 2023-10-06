db $42
JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return : JMP FIAR
JMP Return : JMP Return : JMP Return

!SPRITENUMBER = $3E

FIAR:		STZ $170B,x		; \ Erase fireball
		%fireball_smoke()
		JSR Genspr

		%erase_block()

Return:		RTL

Genspr:	LDX #$0B
GLoop:	LDA $9E,x
	BEQ Cont
	DEX
	BPL GLoop
	LDA #$0E
	STA $1DF9
	RTS

Cont:	LDA #$01		;set to init
	STA $14C8,x		;status

	LDA #!SPRITENUMBER	;sprite to generate
	STA $9E,x		;sprite type
	JSL $07F7D2		;clear

	REP #$20	;apply xdisp
	LDA $9A
	AND #$FFF0
	SEP #$20
	STA $E4,x
	XBA
	STA $14E0,x

	REP #$20	;apply ydisp
	LDA $98
	AND #$FFF0
	SEP #$20
	STA $D8,x
	XBA
	STA $14D4,x

	RTS

print "A frozen version of sprite ", hex(!SPRITENUMBER), "."