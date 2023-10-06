; by Thomas

; SJC note: I had to apply this, because otherwise, the COURSE CLEAR
; text doesn't appear during the fade to black at level end.



org $00AF35
	JMP CheckIfBossBeaten
	NOP
    FadeBoss:
    

org $00B090
    DontFade:
	RTS

    CheckIfBossBeaten:
	LDA $13C6
	BEQ DontFade
	LDA $13
	AND #$03
	JMP FadeBoss