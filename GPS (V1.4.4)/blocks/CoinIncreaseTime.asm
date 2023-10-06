db $42

JMP Mario : JMP Mario : JMP Mario : JMP Return : JMP Return : JMP Return : JMP Return : JMP Mario : JMP Mario : JMP Mario

Mario:
        
	LDA $14AD	; \ Make sure P-switch isn't on
	BNE Return	; /
        LDA #$01   ; coin sound
        STA $1DFC 
	LDA $F32	; \ 
	CMP #$09	; | Make sure it's not 9 (this causes "A" to appear in the timer)
	BEQ Alt		; / 
	INC $F32	; \ Increment tens
	RTL		; / 
Alt:
	STZ $F32	; \ Same as above but increments hundreds and clears tens
	INC $F31	; | (may not seem logical, but it is)
        %erase_block()
	RTL		; / 
Return:
	RTL		; Now what could this do?