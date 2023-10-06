;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print "A block that bounces you up if you're spinjumping or on Yoshi and does nothing if you are not."
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!LowHeight	= $D0	; Y speed gained when no buttons held
!HighHeight	= $A8	; Y speed gained when holding A/B

!SFX 	 	= $02
!SFXAddr 	= $1DF9|!addr

db $42
JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV    : JMP SpriteH    : JMP MarioCape : JMP MarioFireball
JMP TopCorner  : JMP BodyInside : JMP HeadInside

TopCorner:
MarioAbove:
	LDA $140D|!addr		; Spinjumping flag
	ORA $187A|!addr		; Riding Yoshi flag
	BEQ Return			; Do nothing if not spinjumping and not riding yoshi

	LDA #!LowHeight		; Low Bounce Height
	BIT $15				; Test controller bits
	BPL +				; Continue if holding A/B
	LDA #!HighHeight	; High Bounce Height
+	STA $7D				; Make the player bounce

	LDA #!SFX			; Play sound "Spin Jumping Off Enemy"
	STA !SFXAddr

	JML $01AB99|!bank	; Do Spin Jumping off spiked enemy effect.

Return:
MarioSide:
BodyInside:
HeadInside:
MarioBelow:
SpriteV:
SpriteH:
MarioCape:
MarioFireball:
	RTL

print "You can spin jump off this block."