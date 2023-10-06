;This block will act just like normal for Mario, but act like a different block for sprites
;(by default it's the blank tile 0025)
;This can be used to easily make blocks, slopes and ledges that are only solid for Mario
;by assigning this block to multiple map16 tiles and changing their acts like in Lunar Magic


!FireballRules	= 0	;Should Mario's fireballs follow the same rules as Mario?    (0=No)
!YoshiRules	= 0	;Should Yoshi and Baby Yoshi follow the same rules as Mario? (0=No)
!ActsLike	= $01B4	;Acts Like number which should be used for non-Mario block interactions



db $37
JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH : JMP MarioCape : JMP MarioFireball
JMP TopCorner : JMP BodyInside : JMP HeadInside
JMP WallFeet : JMP WallBody


SpriteV: : SpriteH:
if !YoshiRules == 1
LDA !9E,x
CMP #$2D
BEQ MarioBelow
CMP #$35
BEQ MarioBelow
endif

if !FireballRules == 0
MarioFireball:
endif

LDY.b #!ActsLike>>8
LDA.b #!ActsLike
STA $1693|!addr

MarioBelow: : MarioAbove: : MarioSide:
TopCorner: : BodyInside: : HeadInside:
WallFeet: : WallBody:
MarioCape:

if !FireballRules == 1
MarioFireball:
endif

RTL

print "Triangle that's only solid for sprites, and doesn't require 1EB block underneath"