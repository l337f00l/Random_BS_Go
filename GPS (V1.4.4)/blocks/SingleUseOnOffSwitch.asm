; A nice little block alternative to KevinM's UberASM,
; allowing you to retain vanilla multi-hit on/off switches 
; in a level alongside these single-hit ones.

; No bounce sprite.

db $42


JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH
JMP Cape : JMP Fireball
JMP MarioCorner : JMP MarioBody : JMP MarioHead
JMP WallFeet : JMP WallBody


SpriteV:
        %sprite_block_position()
        %check_sprite_kicked_vertical()
        bcs +
        rtl
SpriteH:
        %sprite_block_position()
        %check_sprite_kicked_horizontal()
        bcs +
        rtl
MarioBelow:
LDA $7D			;\Must be going up.
	BPL return		;/
Cape:
+
        LDA $14AF
	EOR #$01
	STA $14AF
        
	LDA #$37    ; 0B
	STA $1DFC   ; 1DF9
	
        PHX					; \ Is this needed?
	REP #$10				; |
	LDX #$0132				; | Change into Map16 tile, used brown block.
	%change_map16()				; |
	SEP #$10				; |
	PLX					; /	
        RTL
MarioSide:
Fireball:
MarioCorner:
MarioBody:
MarioHead:
WallFeet:
WallBody:
MarioAbove:
return:    
rtl