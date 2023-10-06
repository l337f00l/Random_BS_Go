db $42

JMP Return : JMP Return : JMP Return
JMP Return : JMP Return
JMP Return : JMP Return
JMP Return : JMP MarioInside : JMP Return

; Teleport settings
!FixTeleport = !True		; Set to !False so the door uses Mario's position
!FixedDestination = !False	; Set to !True so the destination is set by the door, not the current screen
!TeleDest = $106			; What level to teleport to
!TeleSecond = !False		; Activates secondary exits
!TeleMidwayWater = !False	; Teleports to the midway point (non-secondary) / transforms the level into a water level (secondary)

; Door settings
!TopPart = !False			; Only let Mario pass if he's small
!BossDoor = !True			; Doesn't check if Mario is really inside similar to boss doors.

; Don't change these!
!True = 1
!False = 0

MarioInside:
	LDA $16			;\  Only enter the door if you press up.
	AND #$08		; |
	BEQ Return		;/ 
	LDA $8F			;\  Surprise: It's a backup of $72
	BNE Return		;/
if !TopPart
	LDA $19			;   If it's the top door part
	BNE Return		;   don't enter if big.
endif
if not(!BossDoor)
	%door_approximity()
	BCS Return		;   Check if Mario is centered enough
endif

if !FixedDestination
	LDX $95			;   The teleport destination and settings are fixed.
	REP #$20
	LDA.w #(((!TeleDest&$1E00)<<3)|(!TeleSecond<<9)|(!TeleMidwayWater<<11)|(!TeleDest&$1FF)|$400)
	LDX #$FF
else
	if !FixTeleport
		LDX #$01
	else
		LDX #$00
	endif
endif
	%teleport_direct()
Return:
RTL

print "A small door that can be entered by pressing up if Mario is touching it anywhere, as opposed to the vanilla door, which has a much smaller hitbox. Note that in its default state, big Mario can enter this door, too. This can easily be changed, though."
