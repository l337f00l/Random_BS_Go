;======================================================================================
;Silver P-Switch OFF
;By Rabees
;
;Description: Sets the Silver P-Switch timer to 0 and plays the "incorrect" sound effect.
;In other words, reverses the effect of my "Blue P-Switch Max" block.
;======================================================================================
print "Reverses the effect of my 'Silver P-Switch' Max block."
db $42
JMP Mario : JMP Mario : JMP Mario : JMP end : JMP end : JMP end : JMP end
JMP Mario : JMP Mario : JMP Mario

Mario:
;LDA #$20	; Remove comments if you want to shake screen
;STA $1887

STZ $14AE;

LDA #$2A;	\ Plays "Incorrect" sound effect.
STA $1DFC;	/

LDA $0DDA
STA $1DFB

end:
RTL;	Finish him again!
