; By SJandCharlieTheCat

; Note that in its current state, buttons are still disabled even during the retry prompt.
; So don't kill Mario.


main:

        LDA #$FF
        STA $0DAA
        STA $0DAC
        STZ $15
        STZ $17

        LDA #$0B        ; Walking speed, very slow by default
        STA $7B 

	LDA #$7F        ; Invisible Mario  
	STA $78

	RTL