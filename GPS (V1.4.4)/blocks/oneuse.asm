db $42

JMP Main2 : JMP Main : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return
JMP Main : JMP Return : JMP Return

Main:

LDA #$A0		; impulse Mario
STA $7D
STZ $140D|!addr
Main2:
LDA #$0F		; correct X and Y position for the block pieces.
TRB $9A
TRB $98
%shatter_block()	; shatter block.
Return:
RTL

print "A one-use note block"