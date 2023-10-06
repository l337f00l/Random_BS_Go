!FreeRAM = $[insert FreeRAM address]     ; match this to corresponding GPS trigger blocks

main:
LDA !FreeRAM    
BNE .StickyHands
RTL

.StickyHands
LDA $1470|!addr
ORA $148F|!addr
BEQ .notcarrying
LDA #$40
TSB $15
.notcarrying
RTL