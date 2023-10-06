; Slight modification by SJandCharlieTheCat


!Level		= $0103		;The level to teleport to.
!Secondary	= 0		; Secondary exit? 0 = false, 1 = true.
!Water		= 0		; If secondary exit, water level? 0 = false, 1 = true.

!Midair = 0
!WallRunEnabled = 0		;Lets you enter pipe while wall running
!MaxVertSpeed = $00		;Maximum vertical speed to enter, 0 = no limit
						;If wall running speed is ignored
						;will not work with negative value, keep it positive

!SoundID = $04
!SoundBank = $1DF9

db $37
JMP Exit : JMP Exit : JMP MarioSide
JMP Exit : JMP Exit : JMP Exit : JMP Exit
JMP Exit : JMP Exit : JMP Exit
JMP WallFeet : JMP Exit


WallFeet:

if !WallRunEnabled == 0		;If wall running not enabled just exit
	RTL
endif

MarioSide:

PHY
LDA $15					;Check if pressing left or right
LDY $93
BEQ .LeftFace
AND #$02
BRA .Compare
.LeftFace
AND #$01
.Compare
BEQ .Return

LDA $72    ; Let the player enter the pipe 
AND #$FF   ; if on ground or a solid platform sprite
BNE .Return

if !WallRunEnabled == 1		;If wall running enabled and currently wall running don't check speed and enter pipe
	LDA $13E3|!addr
	STZ $13E3|!addr
	BNE .EnterPipe
endif
if !MaxVertSpeed != $00		;If max speed enabled check if not too fast
	LDA $7D
	BPL .noInvert
	EOR #$FF : INC
	.noInvert
	CMP #!MaxVertSpeed
	BCS .Return
endif

.EnterPipe
;LDA #$05 : STA $71	, Pipe to screen exit?
REP #$20     ; Pipe to specific exit
LDA #!Level|(((!Water<<3)|(1<<2)|(!Secondary<<1))<<8)
%teleport_horizontalpipe()   ; newly aded routine
LDA #$30 : STA $88					;Enter pipe timer
TYA : EOR #$01 : STA $89		;Pipe facing for animation
LDY $148F|!addr : BEQ .SetMarioFacing		;If holding item
EOR #$01							;Invert Mario's direction
LDY #$08 : STY $1499|!addr			;Face camera for turn around effect
.SetMarioFacing
STA $76
LDA #$01 : STA $1419|!addr : STA $9D	;Set Yoshi pipe enter animation and lock sprites
LDA #!SoundID : STA !SoundBank|!addr	;Play sound

.Return
PLY
Exit:
RTL

print "A horizontal pipe with its own defined level exit, so that multiple pipes leading to different level numbers can be put on the same screen."