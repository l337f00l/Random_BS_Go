;xHF01x's consistent 8 frame float delay patch
; Note that a side effect of this is that when Yoshi has wings,
; you can flight upward infinitely just by holding B.

main:
    LDA $15 : AND #$80 : BEQ +
    LDA #$08 : STA $14A5            
    +
    RTL


