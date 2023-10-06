db $37
JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH : JMP MarioCape
JMP TopCorner : JMP BodyInside : JMP HeadInside
JMP WallFeet : JMP WallBody


SpriteV:
SpriteH:
        
        PHY

	LDA !166E,x : ORA #$40 : STA !166E,x    ; disables buoyancy splash GFX
	LDA #$01                ; sprite buoyancy
	STA !164A,x             ;

	STZ !14C8,x				; | Instant destroy
	LDA #$40				; |
	STA !1558,x				; /
        JSL $028528                             ; Actual lava splash
        PLY
        RTL
		

MarioBelow:
MarioAbove:
MarioSide:
TopCorner:
BodyInside:
HeadInside:
WallFeet:
WallBody:
JSL $00F606   ; Kill instead of hurt

MarioCape:

Return:
RTL

print "This is, in effect, a fixed version of vanilla lava, which doesn't allow Mario to swim in the top of it, and destroys sprites kicked into it with a lava splash (except for podoboos), no matter what part of it they touch."