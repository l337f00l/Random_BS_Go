; Doesn't increment coin count


db $37

JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH
JMP Cape : JMP Fireball
JMP MarioCorner : JMP MarioBody : JMP MarioHead
JMP WallFeet : JMP WallBody

MarioBelow:
MarioAbove:
MarioSide:
        LDA #$01   ; coin sound
        STA $1DFC 
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




print "Not a real coin, so that it doesn't increment coin count."