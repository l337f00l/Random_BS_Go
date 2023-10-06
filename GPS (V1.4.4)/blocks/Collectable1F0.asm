db $37

JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH
JMP Cape : JMP Fireball
JMP MarioCorner : JMP MarioBody : JMP MarioHead
JMP WallFeet : JMP WallBody

MarioBelow:
MarioAbove:
MarioSide:
	PHY					; \
	LDA #$02				; | Erase the current block.
	STA $9C					; |
	JSL $00BEB0				; |
	PLY					; /
	;%glitter()				; > Create glitter effect.


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

print "1F0 which disappears after item grabbed - useful for shell levels"