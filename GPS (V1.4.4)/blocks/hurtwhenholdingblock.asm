print "Hurts Mario if he is carrying an item"

db $42
JMP Mario : JMP Mario : JMP Mario : JMP Return : JMP Return : JMP Return : JMP Return : JMP Mario : JMP Mario : JMP Mario

Mario:
LDA $1470        ; if Mario carrying stuff flag is clear,
BEQ Return       ; return
JSL $00F5B7      ; else, hurt Mario

Return:
RTL