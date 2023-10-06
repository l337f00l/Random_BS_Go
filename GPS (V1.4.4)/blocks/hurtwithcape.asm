


db $37

JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH
JMP Cape : JMP Fireball
JMP MarioCorner : JMP MarioBody : JMP MarioHead
JMP WallFeet : JMP WallBody

MarioBelow:
MarioAbove:
RTL

MarioSide:
	LDA $19					; \ If the player is caped...
	CMP #$02				; |
	BNE Label_0000				; /
	STZ $18BD|!addr				; > Stun the player for 0 frames.
Label_0000:					; > --------


SpriteV:
SpriteH:
RTL

Cape:
	LDA $72					; \ If the player is in air...
	BEQ Label_0001				; /
	STZ $18BD|!addr				; > Stun the player for 0 frames.
Label_0001:					; > --------


Fireball:
MarioCorner:
RTL

MarioBody:
	LDA $19					; \ If the player is caped...
	CMP #$02				; |
	BNE Label_0002				; /
	STZ $18BD|!addr				; > Stun the player for 0 frames.
Label_0002:					; > --------


MarioHead:
WallFeet:
WallBody:
RTL




print "Stun the player when caped"