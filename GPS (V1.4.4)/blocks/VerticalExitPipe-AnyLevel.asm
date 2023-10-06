; Slight mods by SJandCharlieTheCat


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Custom Vertical Pipes by West
;
;Use with the UberASMTool code to hide the player as they enter the pipe. 
;
;These blocks act similar to traditional vertical pipe blocks except it no longer 
;checks for your position making it much easier to enter the pipe.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!Level		= $0103		;The level to teleport to.
!Secondary	= 0		; Secondary exit? 0 = false, 1 = true.
!Water		= 0		; If secondary exit, water level? 0 = false, 1 = true.


;!HidePlayer = !true	;Reccomended so that the player doesn't get cut-off if they enter the pipe from the sides.
;!FreeRAM = $1864|!addr	;Used to hide the player when set and then cleared when the pipe timer reaches 0.

!Give_Powerup = !false	;Give the player a specific powerup upon entering the pipe. 		
!Powerup = $00 		;Unused if the selection above is false. $00 = Small, $01 = Big, $02 = Cape, $03 = Fire Flower
!NoYoshi = !false	;true = don't allow yoshi when entering pipes, false = allow yoshi when entering pipes.

!PipeTimer = $32	;Time until the player exits the screen. 
!PipeSFX = $04
!PipeSFXPort = $1DF9|!addr
	
!false	= 0	;\ Don't change these.
!true	= 1	;/

db $42

print "A vertical pipe with its own defined level exit, so that multiple pipes leading to different level numbers can be put on the same screen."

JMP MarioBelow	;MarioBelow
JMP MarioAbove	;MarioAbove
JMP Return		;MarioSide
JMP Return		;SpriteV
JMP Return		;SpriteH
JMP Return		;MarioCape
JMP Return		;MarioFireBall
JMP Return		;MarioCorner
JMP Return		;MarioBody
JMP Return		;MarioHead

MarioAbove:	
		LDY #$01		;\
		LDA #$30		;| Act as a cement block.
		STA $1693|!addr	;/
		if !NoYoshi
		LDA $187A|!addr	;\If on Yoshi, return
		BNE Return		;/
		endif
		LDA $15		;\
		AND #$04	;| Check if the player is pressing down.
		BEQ Return	;/
                REP #$20
	        LDA #!Level|(((!Water<<3)|(1<<2)|(!Secondary<<1))<<8)
	        %teleport()
		;LDA #$06	, Enter the pipe and Teleport to the current screen exit
		;STA $71		
		;STA $9D
		LDA #$02			;\ Set yoshi pose.
		STA $1419|!addr		;/
		LDA #!PipeTimer	;Time until the player exits the screen.
		STA $88		
		LDA #$03		;\ Enter an up-facing vertical pipe
		STA $89			;/
		;if !HidePlayer
		;LDA #$01
		;STA !FreeRAM
		;endif
		if !Give_Powerup
		LDA #!Powerup
		STA $19
		endif
		LDA #!PipeSFX	 ;\ Pipe sound effect.
		STA !PipeSFXPort ;/ 
Return:		RTL	

MarioBelow:	
		LDY #$01		;\
		LDA #$30		;| Act as a cement block.
		STA $1693|!addr	;/
		if !NoYoshi
		LDA $187A|!addr	;\If on Yoshi, return
		BNE Return		;/
		endif
		LDA $15		;\
		AND #$08	;| Check if the player is pressing up.
		BEQ Return	;/
                REP #$20
	        LDA #!Level|(((!Water<<3)|(1<<2)|(!Secondary<<1))<<8)
	        %teleport()
		;LDA #$06	, Enter the pipe and Teleport to the current screen exit
		;STA $71			
		;STA $9D
		LDA #$02		;\ Set yoshi pose.
		STA $1419|!addr	;/
		LDA #!PipeTimer	;\Time until the player exits the screen.
		STA $88			;/
		LDA #$02		;\Enter an down-facing vertical pipe.
		STA $89			;/
		;if !HidePlayer
		;LDA #$01
		;STA !FreeRAM
		;endif
		if !Give_Powerup
		LDA #!Powerup
		STA $19
		endif
		LDA #!PipeSFX	 ;\ Pipe sound effect
		STA !PipeSFXPort ;/ 
RTL
	

		

















