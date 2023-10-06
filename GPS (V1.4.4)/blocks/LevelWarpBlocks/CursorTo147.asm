;level-specific teleport block (cursor click)

!CursorSpr = $1D	;Change this to the same sprite number you inserted the cursor at!

!Level	= $0147		;The level to teleport to.

!Secondary = 0		;Secondary exit? 0 = no, 1 = yes.
!Water = 0		;If secondary exit, water level? 0 = no, 1 = yes.

!SFX = $00		;sound effect played when teleporting.
!SFXPort = $1DFC	;port used for above SFX.

if !sa1
!extra_byte_1 = $400099
else
!extra_byte_1 = $7FAB40
endif

db $42
JMP Return : JMP Return : JMP Return 
JMP Run : JMP Run : JMP Return : JMP Return
JMP Return : JMP Return : JMP Return

Run:
LDA !7FAB9E,x		;load custom sprite number
CMP #!CursorSpr		;compare to value
BNE Return		;if not equal, return.

LDA !extra_byte_1,x	;load first extension byte of sprite
CMP #$05		;compare to value
BNE Return		;if not equal, return.

;Code below is the spot which can be modified.

LDA #!SFX		;load SFX number
STA !SFXPort|!addr	;store to address to play it.

REP #$20
LDA #!Level|(((!Water<<3)|(1<<2)|(!Secondary<<1))<<8)
%teleport()

Return:
RTL		;Return.

if !Secondary
	if !Water
		!TeleType = "secondary entrance (water level)"
	else
		!TeleType = "secondary entrance"
	endif
else
	!TeleType = "level"
endif

!LvlNumDesc = "!Level"

print "A teleport block, that teleports the player to !TeleType #!LvlNumDesc when the Cursor sprite clicks over it."