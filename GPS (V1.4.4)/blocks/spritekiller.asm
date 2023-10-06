; SJC: I basically made a hybrid of Nowieso's Customizable Sprite Killer 
; and MarioFanGamer's Destroy Yoshi block, in order to also destroy Yoshi
; if he's being ridden, and also destroy items in his mouth.  


; I've also noted a very obscure glitch here: in one level where I had baby Yoshi placed toward the top
; of the screen, with adult Yoshi toward the bottom, the sprite killer wouldn't kill
; Yoshi while Mario is riding him. But when baby Yoshi is brought down, it's fine.



!deathtype		=	1		;0 = sprite disappears without SFX
!killIfCarried	=	1		;1 = kill the sprite if it gets carried
!playSFX		=	1		;1 = play a SFX when !deathtype is 1
!SFX			=	$08		;sfx to play
!SFXBank		= 	$1DF9

db $42

JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH
JMP Cape : JMP Fireball
JMP MarioCorner : JMP MarioInside : JMP MarioHead


SpriteV:
SpriteH:
if !killIfCarried == 0
	LDA !14C8,x
	CMP #$0B
	BEQ Return
endif
if !deathtype == 0
	STZ !14C8,x
else
	LDA #$04
	STA !14C8,x
        LDA #$1F
        STA $1540,x 
	PHY
	JSL $07FC3B
	PLY
	if !playSFX
	LDA #!SFX
	STA !SFXBank|!addr	
	endif
endif

	LDA $9E,x
	CMP #$35
	BEQ Delete_eaten_sprite
	CMP #$2D
	BEQ Yoshi

Return:
Fireball:
Cape:
RTL

MarioBelow:
MarioAbove:
MarioSide:
MarioCorner:
MarioInside:
MarioHead:
	LDX #$0B
-	LDA $14C8,x
	CMP #$08
	BCC .next
	LDA $9E,x
	CMP #$35
	BEQ .yoshi
	CMP #$2D
	BEQ .baby
.next
	DEX
	BPL -
RTL

.baby
	LDA $14C8,x
	CMP #$0A
	BEQ Yoshi
RTL

.yoshi
	LDA $187A
	BEQ Return

Delete_eaten_sprite:
; Thanks 33953YoShi for this
	LDA $18AC	;\ if Yoshi has sprite in mouth.
	BEQ .no		;/
	STZ $18AC	; Reset mouth timer.
	PHY		;
	LDY $160E,x	;
	BMI +		;
	LDA #$00	;\ Sprite of Yoshi in mouth will be deleted.
	STA $14C8,y	;/
+	PLY		;

.no
	STZ $187A
	LDA #$02
	STA $1FE2,x
	STZ $C2,x
	LDA #$03
	STA $1DFA
	STZ $0DC1

Yoshi:
	LDA #!SFX
	STA !SFXBank
	LDA #$04
	STA $14C8,x
	LDA #$1F
	STA $1540,x
	PHY
	JSL $07FC3B   ; delete sprite?
	PLY
.return
RTL

print "Kills all sprites which interact with blocks - even if you're riding Yoshi, and even if Yoshi has a sprite in his mouth. Note, though, that if you destroy a vanilla spring, it will warp Mario. This is an unavoidable behavior of all sprite killers, though custom sprite 20 is a spring disassembly, and won't be affected by this. I've also included another sprite killer, KillsTheSpritesYouSpecify.asm, where springs are automatically whitelisted."