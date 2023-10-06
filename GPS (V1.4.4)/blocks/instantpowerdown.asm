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
CMP #$00
BEQ .Return
STZ $19     ; kill powerup
STZ $1407   ; kill actual flight, viz. floating
LDA #$10        ; Sound effect (default: Magikoopa Magic)
STA $1DF9       ; SFX Bank

.Return
RTL

SpriteV:
SpriteH:
Cape:
Fireball:
MarioCorner:
MarioBody:
MarioHead:
WallFeet:
WallBody:
RTL

print "Instant power-down, with no temporary invincibility"