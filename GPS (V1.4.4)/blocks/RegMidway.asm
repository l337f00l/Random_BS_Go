;Make it act like whatever you want

db $42

JMP MarioBelow : JMP MarioAbove : JMP MarioSide 
JMP Sprite : JMP Sprite 
JMP MarioCape : JMP MarioFireBall
JMP MarioCorner : JMP MarioBodyInside : JMP MarioHeadInside

MarioBelow:
LDA #$05		;\ Sound
STA $1DF9	;/
LDA #$01		;\ Set the midway point flag
STA $13CE	;/ 

MarioAbove:
MarioSide:
Sprite:
MarioCape:
MarioFireBall:
MarioCorner:
MarioBodyInside:
MarioHeadInside:
RTL

print "Block that will activate the midway flag and play a sound effect."