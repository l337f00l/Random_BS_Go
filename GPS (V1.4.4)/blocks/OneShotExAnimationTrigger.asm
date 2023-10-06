db $37

JMP MarioBelow : JMP MarioAbove : JMP MarioSide : JMP SpriteV
JMP SpriteH : JMP MarioCape : JMP MarioFireball : JMP TopCorner
JMP BodyInside : JMP HeadInside : JMP WallFeet : JMP WallBody


MarioBelow:
MarioAbove:
MarioSide:

TopCorner:
BodyInside:
HeadInside:

MarioCape:
MarioFireball:

WallFeet:
WallBody:
LDA $7FC0F8
ORA #$01      ; The specified trigger here is One Shot 00.
              ; Put #$02 for One Shot 01, etc.
              ; You can also trigger multiple slots simultaneously.
              ; #%0000000 format, from right to left. 
              ; For example, 4 slots would be #%00001111, or 0F in hex (#$0F as you'd put it after ORA) 
              ; 1F for 5 slots, etc.
STA $7FC0F8
%sprite_block_position()
%erase_block()

SpriteV:
SpriteH:
RTL

print "When Mario touches this block, it triggers the corresponding one-shot trigger in ExAnimation"