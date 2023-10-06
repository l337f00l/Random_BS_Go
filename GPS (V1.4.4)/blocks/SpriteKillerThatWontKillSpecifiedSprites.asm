; Can act as 25, or as 12F so that it also kills Mario.

; By default, this will kill all sprites, vanilla or custom, except for vanilla springs (sprite $2F).
; Vanilla springs can't by killed by sprite killers without glitches, 
; so they're automatically included in the whitelist below (SpriteTableStart).
; However, custom sprite 20 is a spring disassembly, and can be destroyed normally.

; Remember that sprites DA-DD aren't actually shells, but just stunned koopas. 
; So if you want to whitelist the blue koopa shell (DC), for example, you'll also have to whitelist 06 (normal blue koopa).



db $42

JMP Return : JMP Return : JMP Return : JMP SpriteCheck : JMP SpriteCheck : JMP Return : JMP Return : JMP Return : JMP Return : JMP Return

!NumberOfSpritesToCheck		= SpriteTableEnd-SpriteTableStart-1				;	don't change this!
!NumberOfCustomSpritesToCheck	= CustomSpriteTableEnd-CustomSpriteTableStart-1			;	don't change this!


SpriteTableStart:	; sprite numbers of vanilla sprites that you want to exclude from being killed ($2F is the spring)
db $2F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
SpriteTableEnd:

CustomSpriteTableStart:	   ; sprite numbers of custom sprites that you want to exclude from being killed
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

print "This sprite killer allows you to put specific vanilla and custom sprites on a whitelist, so they won't be killed by it. Note, however, that it currently doesn't kill Yoshi if you go through these blocks while riding him. (The other sprite killer does, though.)"