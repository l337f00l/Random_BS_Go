print "An ON/OFF switch that is controlled by Mario's fireball"
db $42

JMP Return : JMP Return : JMP Return
JMP Return : JMP Return
JMP Return : JMP Fireball
JMP Return : JMP Return : JMP Return

Fireball:
STZ $170B,x
LDA $14AF
EOR #$01
STA $14AF

Return:
RTL



