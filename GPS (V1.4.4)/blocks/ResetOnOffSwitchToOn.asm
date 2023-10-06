; This invisible block will only flip the on-off switch on if Mario touches it.
; It won't do anything (it won't trigger the switch back to off) if it's already on.

db $37
JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH : JMP MarioCape
JMP TopCorner : JMP BodyInside : JMP HeadInside
JMP WallFeet : JMP WallBody


SpriteV:
SpriteH:
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
        LDA #$01
	STZ $14AF
	REP #$10
	LDX #$0025 : %change_map16()
	SEP #$10
RTL

print "Invisible block that, when Mario touches it, resets the on/off state to on if it's currently off, but does nothing if it's already off"