;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; On/Off Cooldown by dtothefourth
;
; Just an UberASM version of On/Off Cooldown
; Provides a frame window where On/Off should not
; trigger multiple times.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;FreeRAM for timer
!Timer = $18F6|!addr

!Cooldown = #$04 ; How many frames the ON/OFF block stays inactive after being hit

main:
	LDA !Timer
	BEQ +
	DEC
	STA !Timer
	+

	LDX #$03
	-
	LDA $1699|!addr,x
	CMP #$06
	BNE +

	LDA $16B1|!addr,x
	CMP #$D0
	BNE +

	LDA !Timer
	BNE ++

	LDA !Cooldown
	STA !Timer
	BRA +

	++
	LDA #$01
	STA $16C5|!addr,x
	LDA $14AF|!addr
	BNE +++
	INC
	BRA ++++
	+++
	LDA #$00
	++++
	STA $14AF|!addr

	+
	DEX
	BPL -

	RTL

