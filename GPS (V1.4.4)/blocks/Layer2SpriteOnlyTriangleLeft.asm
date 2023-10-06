; that the other sprite-only triangle block has, i.e. if
; you just drop a shell on top of it.

; However, I've also added the compatibility to bounce while riding Yoshi.
; It's not quite the same as vanilla, but it's close enough (or possibly better, IMO).


db $37

JMP MarioBelow : JMP Yoshi : JMP MarioSide
JMP SpriteH : JMP SpriteV : JMP MarioCape : JMP MarioFireball
JMP TopCorner : JMP BodyInside : JMP HeadInside
JMP WallFeet : JMP WallBody

SpriteV:
    LDA !B6,x		; Comment out these
    BEQ +		; lines if you want
    BPL Return		; the kicked sprite to 
    +                   ; be bounced from both sides
    LDA !14C8,x         
    CMP #$0A            ; kicked state
    BNE Return
    LDA #$BB            ; bounce height
    STA !AA,x               
    RTL

Yoshi:
    LDA $187A   ; ORA?
    BEQ Return
    LDA #$9B    ; Bounce height if on Yoshi
    BPL +
    + STA $7D

    LDA #$08    ; SFX
    STA $1DFC

    RTL

SpriteH:
MarioBelow:
MarioSide:
TopCorner:
BodyInside:
HeadInside:
WallFeet:
WallBody:
MarioCape:
MarioFireball: 

Return:
RTL

print "This lets the sprite-only triangle work in layer 2 levels, where it normally doesn't work at all."
