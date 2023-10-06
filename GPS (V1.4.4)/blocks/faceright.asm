db $42
JMP Mario : JMP Mario : JMP Mario
JMP Return : JMP Return : JMP Return : JMP Return
JMP Mario : JMP Mario : JMP Mario

Mario:
LDA #$01
STA $76
Return:
RTL 

print "When you touch this block, Mario will face right if he had been facing left"