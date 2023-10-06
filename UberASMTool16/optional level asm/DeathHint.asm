; Default FreeRAM same as D4's custom camera system, so watch out

; Teleports the player to another level after a specific number of deaths,
; where you can give the player a hint if they're not getting it.
; Unless you're using the message box sprite (1E) that lets sublevels have their own messages, 
; make sure you set the message in the original level (in the Edit Message Box menu), not the level you warp to.

; Use with TeleportToLevel.asm in Library

; Modifications by SJandCharlieTheCat, base code by Dtothefourth

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Cycle Players by dtothefourth
;
; UberASM which cycles the active player after a number
; of deaths
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!Cycles     = 3         ; How many deaths before the player teleports. Use a decimal to hex converter if you need.
!Level      = $0140     ; The level to teleport to.
!Secondary  = 0         ; Secondary exit flag.
!Water      = 0         ; If secondary = 1, water level flag.
						; If secondary = 0, midway exit flag (note: destination must use separate midway settings).

!Reset = 0	 ;If 1, keep the retry count even when going back to the OW or other levels

!Retries = $7FB500 ;FreeRAM to count retries
!Init    = $7FB501 ;FreeRAM to mark as started if using no reset


load:
	if !Reset = 1
	LDA !Init
	CMP #$AB
	BEQ +
	else
	LDA $141A|!addr
	BNE +
	endif
	LDA #$00
	STA !Retries
	if !Reset = 1
	LDA #$AB
	STA !Init
	endif
	RTL
	+

	LDA !Retries
	INC
	CMP #!Cycles
	BNE +
    
        REP #$20
        LDA #!Level|(((!Water<<3)|(1<<2)|(!Secondary<<1))<<8)
        JSL TeleportToLevel       

	LDA #$00
	+
	STA !Retries
	RTL

