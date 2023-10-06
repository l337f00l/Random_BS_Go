; by ASMagician Maks

; Edited by SJandCharlieTheCat, to work well with 1F0s, etc.


!ActsLike	= $0025	;Acts Like number which should be used for non-Mario block interactions
!ActsLikeMario	= $012F	;Acts Like number which should be used for Mario
!BlockSprite      = 0   ;By default, vine will eat through it. Set as 1 to change.

db $37
JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH : JMP MarioCape
JMP TopCorner : JMP BodyInside : JMP HeadInside
JMP WallFeet : JMP WallBody


SpriteV:
SpriteH:
if !BlockSprite = 1
LDA !9E,x
CMP #$79   ;  vine
BEQ MarioBelow
endif

LDY.b #!ActsLike>>8
LDA.b #!ActsLike
STA $1693|!addr

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

LDY.b #!ActsLikeMario>>8
LDA.b #!ActsLikeMario
STA $1693|!addr

RTL

print "Hurts Mario, but allows sprites to pass. By default, it's set so that a vine will eat through the blocks. You can change this, though."