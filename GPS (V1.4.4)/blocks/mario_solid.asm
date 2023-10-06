; by ASMagician Maks

; Edited by SJandCharlieTheCat, to work well with 1F0s, etc.


!ActsLike	= $0025	;Acts Like number which should be used for non-Mario block interactions
!ActsLikeMario	= $0130	;Acts Like number which should be used for Mario
!AllowSprite      = 0   ;You can exempt sprites from passing below

db $37
JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH : JMP MarioCape
JMP TopCorner : JMP BodyInside : JMP HeadInside
JMP WallFeet : JMP WallBody


SpriteV:
SpriteH:
;if !AllowSprite = 0
;LDA !9E,x
;CMP #$xx   ;  replace with sprite number
;BEQ MarioBelow
;endif

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

print "Solid for Mario, but allows sprites to pass. If you don't like the look of the normal yellow sprite-pass block, I've also included a block graphic in the same style as the red light switch, set to act the same as this."