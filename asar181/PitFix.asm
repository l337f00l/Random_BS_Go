;This patch moves the bottomless pit routine's "kill boundary" a few blocks up to prevent
;the player from being able to go under the level and blocks and survive. This is much
;better than the “"Floor" Generator” made by Chdata, Ladida, and Ramp202 as it stops the
;player's horizontal movement, even when not touching a wall. The Y position of the kill
;boundary is customizable below:

!YKillBoundarySmall	= $00D6

!YKillBoundaryBig	= !YKillBoundarySmall+$08	;>Bigger mario is allowed to go deeper.

;The higher the value, the lower mario is allowed to go below the screen.

;By default, they work similar to NSMB; the position changes depending on how tall are
;you so that when you fall in a pit, Mario is always invisible. This can be proven using
;LRLRXXYY's 1-way scroll on NSMB in vertical levels and using mega mario powerup when
;half of his body is not too far below the screen, but shrinking after it wears off is.
;Another reason is that if the position always uses big mario, its possible to bypass
;by croucing (unlikely, but possible, like p-balloon).

;It should be compatable with "teleport by falling off screen" by MarioFanGamer since it
;only hijacks the call to mario's death routine. However, both patches share the bottom
;screen boundary that triggers death or teleport (meaning if you change the values
;above, the "teleport line" also moves). However, it may not be compatable with the
;reverse gravity patch (because it modifies the pit to be sometimes at the top when
;reversed), so do that at your own risk.

;Do note that small mario, when standing up is graphic is actually 18 pixels, due to his
;cap on his head, thats why it is #$00D8 and not #$00D0 by default.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SA1 detector:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if read1($00FFD5) == $23
	; SA-1 base addresses	;Give thanks to absentCrowned for this:
				;http://www.smwcentral.net/?p=viewthread&t=71953
	!Base1 = $3000		;>$0000-$00FF -> $3000-$30FF
	!Base2 = $6000		;>$0100-$0FFF -> $6100-$6FFF and $1000-$1FFF -> $7000-$7FFF
	!SA1 = 1
	sa1rom
else
	; Non SA-1 base addresses
	!Base1 = $0000
	!Base2 = $0000
	!SA1 = 0
endif
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Hijack
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
org $00F5A5		;\Hijack the code that checks if mario's Y position value on screen is
autoclean JML MovePit	;|higher than or equal to to kill the player.
nop #1			;/

freecode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Main code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MovePit:
	LDA #$00		;\Transfer high byte y position to high byte A
	XBA			;/(high byte not cleared when 8-bit-single-byte mode)
	LDA $73			;\If mario is crouching, branch to small hitbox
	BNE .SmallHitbox	;/
	LDA $19			;\While NOT crouching, if mario is small, branch to small hitbox.
	BEQ .SmallHitbox	;/
;.BigHitbox
	LDA.b #!YKillBoundaryBig
	BRA +
.SmallHitbox
	LDA.b #!YKillBoundarySmall
+
	REP #$20
	CMP $80			;>Mario Y position on-screen, formula: (MarioYPosScrn = MarioYPosLvl - ScreenLayerYPos)
	SEP #$20
	BPL +			;>If boundary is positioned higher than mario (or mario is below it), kill.
.Restore
	REP #$20
	LDA $1C			;\MarioYPositionLevel = ScrnYPos + MarioYPosScrn
	CLC			;|
	ADC $80			;/
	CLC			;\Set y position below the screen (not visible)
	ADC #$00E0		;/
	STA $96			;>Set Y pos.
	SEP #$20
;^This block of code is to prevent a graphical “glitch” that if you are big mario and is very close
;to the boundary and crouch, the pit “rises” and kills the 16x16 player size at a higher Y position
;This can be done on a vertical upwards autoscroll or riding on a lakitu cloud
	JML $00F5AA		;>Trigger either death or return to map if yoshi wings level.
+	JML $00F5B6		;>Must jump to a return when you JML to a freespace (mario survives).