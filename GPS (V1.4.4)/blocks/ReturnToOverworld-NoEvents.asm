db $42

JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH : JMP MarioCape : JMP MarioFireBall
JMP TopCorner : JMP BodyInside : JMP HeadInside

MarioAbove:
MarioBelow:
MarioSide:
TopCorner:
HeadInside:
BodyInside:
        LDA #$01
        STA $1B96|!addr

        LDA #$06
        STA $13D9|!addr

        STZ $0109|!addr                
        STZ $0DD5|!addr              
        LDA #$0B                
        STA $0100|!addr 
SpriteV:
SpriteH:
MarioCape:
MarioFireBall:
	RTL
	
print "Exits the level without triggering any event."