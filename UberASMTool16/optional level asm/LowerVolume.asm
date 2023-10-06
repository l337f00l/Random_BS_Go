main:
LDA $18
AND #$30
CMP #$20 ; L
BEQ LHit
CMP #$10 ; R
BEQ RHit

RTL

LHit:
LDA #$38 ; Fade
STA $1DFC
RTL

RHit:
LDA #$39 ; Return
STA $1DFC
RTL