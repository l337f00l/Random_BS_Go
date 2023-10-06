; Add jump check

db $37
JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH : JMP MarioCape
JMP TopCorner : JMP BodyInside : JMP HeadInside
JMP WallFeet : JMP WallBody

SpriteV:
SpriteH:

LDA #$30 ;\
STA $1693 ; |Act like a cement block
LDY #$01 ;/
RTL

MarioBelow:
MarioAbove:
MarioSide:
TopCorner:
BodyInside:
HeadInside:
WallFeet:
WallBody:
MarioCape:

        LDA $72					; \ If the player is not in air...
	BNE Kill				; /
	LDA $73					; \ If the player is ducking...
	BEQ Kill				; /
        BRA Return
Kill:
	JSL $00F606				; > Kill the player.


Return:
RTL