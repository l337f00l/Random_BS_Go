;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 
; Adjust Mario GFX - by dtothefourth
;
; This patch includes a trigger for the vertical flipping of Mario's graphics
; from MarioE's gravity patch as well as RAM values which can move Mario's image
; relative to his position
;
; If using both patches make sure to set !BothPatches below and apply this one
; after reverse_gravity
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!addr = $0000
!bank = $800000

if read1($00FFD5) == $23
sa1rom
!addr = $6000
!bank  = $000000
endif

!Flip           = $7C         ;Free RAM, trigger to flip graphics
!XOffset        = $1864|!addr ;Free RAM, offsets Mario's graphics horizontally
!YOffset        = $1879|!addr ;Free RAM, offsets Mario's graphics vertically


!BothPatches    = 0         ; Set if also using reverse_gravity.asm
!reversed		= $60		; The reversed gravity flag as set in reverse_gravity.asm







org $00E46D
		autoclean JML flip_mario_gfx

org $00E4AE
		autoclean JSL offset


freecode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This section flips Mario's graphics.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

flip_mario_gfx:	
        LDA !Flip
        if !BothPatches
        ORA !reversed
        endif
		BNE .ud

		REP #$20
		LDA $80
		JML $00E471|!bank

	.ud	LDA $0303|!addr,y
		ORA #$80
		STA $0303|!addr,y

		REP #$20
		LDA $80
		SEC
		SBC $DE32,x
		BIT $03
		BMI +
		CLC
		ADC #$0008
	+	CLC
		ADC #$0010
		JML $00E475|!bank

offset:

		LDA !YOffset
		BPL YPos
		EOR #$FF
		INC
		STA $00
		BRA YNeg
	YPos:
		LDA $0301|!addr,y
        CMP #$F0
        BEQ +
        CLC
        ADC !YOffset
		BCS +++
		CMP #$E0
		BCC ++
		+++
		LDA #$F0
		++
        STA $0301|!addr,y
		BRA XOff
	YNeg:
		LDA $0301|!addr,y
        CMP #$F0
        BEQ +
        SEC
        SBC $00
		BCC +++
		CMP #$E0
		BCC ++
		+++
		LDA #$F0
		++
        STA $0301|!addr,y
		BRA XOff

	XOff:
		LDA !XOffset
		BPL XPos
		EOR #$FF
		INC
		STA $00
		BRA XNeg
	XPos:
		LDA $0300|!addr,y
        CMP #$F0
        BEQ +
        CLC
        ADC !XOffset
		BCC ++
		LDA #$F0
		++
        STA $0300|!addr,y
		BRA +
	XNeg:
		LDA $0300|!addr,y
        CMP #$F0
        BEQ +
        SEC
        SBC $00
		BCS ++
		LDA #$F0
		++
        STA $0300|!addr,y

        +
        INY #4
        RTL