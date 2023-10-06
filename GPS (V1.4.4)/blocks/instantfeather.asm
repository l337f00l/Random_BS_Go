db $37

JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH
JMP Cape : JMP Fireball
JMP MarioCorner : JMP MarioBody : JMP MarioHead
JMP WallFeet : JMP WallBody

MarioBelow:
MarioAbove:
MarioSide:
LDA $19
CMP #$02
BEQ Return
LDA #$02 ; 02 for cape
STA $19
LDA #$0D        ; Sound effect
STA $1DF9       ; SFX Bank

SpriteV:
SpriteH:
Cape:
Fireball:
MarioCorner:
MarioBody:
MarioHead:
WallFeet:
WallBody:

Return:
RTL

print "Gives feather power-up with no delay"