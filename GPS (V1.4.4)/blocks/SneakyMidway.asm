; Invisimidway
; By: HuFlungDu
; Block that will invisibly activate the midway flag, just put a line of these from floor to ceiling
; and the user will activate the midway point without being any the wiser.
; If you credit me for two lines of code I may have to slap you...
; Act (and look) like block 25 so mario will walk right through it without anyone knowing.

db $42
JMP MarioBelow : JMP MarioBelow : JMP MarioBelow : JMP SpriteV : JMP SpriteH : JMP MarioCape : JMP MarioFireBall
JMP MarioBelow : JMP MarioBelow : JMP MarioBelow

MarioBelow:
LDA #$01
STA $13CE
SpriteV: 
SpriteH: 
MarioCape: 
MarioFireBall:
RTL

print "Block that will activate the midway flag without playing a sound."