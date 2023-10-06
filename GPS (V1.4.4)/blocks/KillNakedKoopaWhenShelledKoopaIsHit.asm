; When shelled koopas are on this block and you jump on them, 
; the naked koopa shot out of them will instantly be destroyed 

; Act as 130, not 25

; By MarioE. Very minor contributions, SJC.

db $42

JMP Return : JMP Return : JMP Return : JMP SpriteCheck : JMP SpriteCheck : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return

!NumberOfSpritesToCheck		= SpriteTableEnd-SpriteTableStart-1				;	don't change this!
!NumberOfCustomSpritesToCheck	= CustomSpriteTableEnd-CustomSpriteTableStart-1			;	don't change this!


SpriteTableStart:						;	edit these values (sprite number, makes it not die if it hits the muncher)
db $2F,$04,$05,$06,$06,$08,$09,$0A,$0B,$0C,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
SpriteTableEnd:

CustomSpriteTableStart:						;	and these values (custom sprite number, makes it not die if it hits the muncher)
db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
CustomSpriteTableEnd:

SpriteCheck:
	LDA !7FAB10,x
	AND #$08
	BNE .customsprite

	LDA !9E,x

	PHX
	LDX.b #!NumberOfSpritesToCheck

.loop
	CMP SpriteTableStart,x
	BEQ .dontkill

	DEX
	BPL .loop

.back
	PLX
	LDA #$04
	STA !14C8,x

	LDA #$1F
	STA !1540,x
        ; add STA !14C8,x here for smoke puff, too
	PHY
	JSL $07FC3B|!bank
	PLY

	LDA #$08
	STA $1DF9|!addr
	RTL

.dontkill
	PLX
	RTL

.customsprite
	LDA !7FAB9E,x

	PHX
	LDX.b #!NumberOfCustomSpritesToCheck

.loop2
	CMP CustomSpriteTableStart,x
	BEQ .dontkill

	DEX
	BPL .loop2

	BRA .back
	
Return:
	RTL

print "A muncher that kills sprites."