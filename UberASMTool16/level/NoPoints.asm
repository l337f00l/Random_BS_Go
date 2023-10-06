;Asceticism Patch - A Darkbloom Production
;Original code by Lexie, I just converted it to SA-1 Hybrid + added options

;Upon entering a level, your score and number of coins are set to zero.
;If you collect a coin or score a point, an event will trigger.

!event = 1 ;0 = warps the player to the screen exit, 1 = kills the player,
;2 = hurts the player, 3  = resets the game (Only use if you're a jerk)



init:
STZ $0F34|!addr ; These set Mario's score to 0
STZ $0F35|!addr ;
STZ $0F36|!addr ;
STZ $0F37|!addr ; These set Luigi's score to 0
STZ $0F38|!addr ;
STZ $0F39|!addr ;
STZ $0DBF|!addr ; This is the current player's coin count.
RTL

main:
LDA $0DBF|!addr ;Load coin count
ORA $0F34|!addr ;and Mario's score
ORA $0F35|!addr
ORA $0F36|!addr
ORA $0F37|!addr ; And Luigi's...
ORA $0F38|!addr ;
ORA $0F39|!addr ;
BEQ Return ; If you BEQ Return here, it branches when the addresses = 0
			;Instead of when the addresses =/= 0. This is a little faster.

if !event = 0
LDA #$06 ; Player animation trigger - enter vertical warp pipe. #0D is entering a door.
	STA $71 ; this is a table for player animation triggers.
	STZ $89 ; action to take when entering a pipe - this
			;triggers entering a pipe from the right.
	STZ $88 ; this is the flag for the time between entering a
			;pipe and warping to a new level. This skips the animation.
	LDA #$0F ; this is the value for the sound effect...
	STA $1DFC ; to be played in this I/O port (it's the door noise)
	;I put a BRA Return here but you don't actually need to do that because it jumps exactly 0 bytes oops
endif

if !event = 1
JSL $00F606|!bank

endif

if !event = 2
JSL $00F5B7|!bank

endif

if !event = 3
STZ $4200	;no interrupts from here on out
	SEI
	SEP #$30	;request upload
	LDA #$FF
	STA $2141
	LDA #$00	;DB must be zero, this is done by the h/w normally
	PHA
	PLB

	STZ $420C	;disable any HDMA, this is done by the h/w normally
	JML $008016|!bank

	endif
	
Return:
STZ $0F34|!addr ; These set Mario's score to 0
STZ $0F35|!addr ;
STZ $0F36|!addr ;
STZ $0F37|!addr ; These set Luigi's score to 0
STZ $0F38|!addr ;
STZ $0F39|!addr ;
STZ $0DBF|!addr ; This is the current player's coin count.
rtl
	