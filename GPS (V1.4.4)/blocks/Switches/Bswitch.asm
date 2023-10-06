;=================================================================================
;Blue P-Switch Max
;by Rabees
;
;Description: Hitting this block from the top, bottom, or
;sides will set the blue p-switch timer to max, and play the correct sound effect.
;==================================================================================
print "Sets the blue p-switch timer to max, and play the correct sound effect."
db $42
JMP Mario : JMP Mario : JMP Mario : JMP end : JMP end : JMP end : JMP end
JMP Mario : JMP Mario : JMP Mario

Mario:
;LDA #$20
;STA $1887

LDA #$FF;	\ Sets Blue P-Switch Timer to maximum.
STA $14AD;	/

LDA #$29;	\ Plays "Correct" sound effect.
STA $1DFC;	/

LDA #$0E
STA $1DFB

end:
RTL;	Finish him!
