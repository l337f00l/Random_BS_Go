;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Spawn Wrapper - By dtothefourth
;;
;; This sprite just replaces itself with another sprite
;; while filling out extra bit and bytes, which is useful
;; for say spawning a sprite which needs extra bytes as
;; part of an enemy stack as long as it uses 4 or less
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; SJC notes on how to use: to get a custom sprite with its own extra bytes filled out
; into the stack, you need to have three things inserted through PIXI: the custom sprite, this sprite wrapper, and
; the SpriteStacker itself. First make sure you've put the name
; of the custom sprite itself in the PIXI list, and have chosen the number you want to insert it as. 
; (You won't actually need to put it in the level itself, though.) Then take the number you'll insert it as, 
; and put it below, after !Sprite (in this file), and fill out the settings you want for it. (!ExtraBit, etc.)
; Next, you'll need to pick a name and number for SpriteStackWrapper.cfg in your PIXI list, too. 
; (Though you won't insert this directly into your level, either.) 
; Note that for each sprite stack you make that needs this wrapper, it'll need its own new copy of SpriteStackWrapper. 
; So you may just want to make several copies of this file, each named WrapperForCustomGoombaStack.asm (+ a .cfg with ; the corresponding name) or whatever, etc.
; Finally, make sure that SpriteStacker.cfg itself is ALSO in your PIXI list, and then you can actually run 
; PIXI. Now it's time to actually put your wrapped sprite in the SpriteStacker itself. So open the Manual menu for the 
; SpriteStacker.cfg in Lunar Magic, and then you'll put the number of the WRAPPER in the relevant part of the 
; sprite stacker's extra property bytes (otherwise following the instructions for custom sprite insertion, as 
; described in SpriteStacker.asm), instead of the number of the custom sprite itself.


!Sprite = #$48	; Number of the custom sprite you want included, as you put in PIXI's list
!State  = #$01  ; Generally 1,8,9 (9 for carryable stuff like keys, 1 for stuff that needs to run its init routine)
!Custom = 1		; 1 to spawn a custom sprite
!ExtraBit  = 2		; 1 to set the extra bit

;Extra bytes to set on sprite
!ExByte1 = #$00  ; Set the extra property bytes for the custom sprite here
!ExByte2 = #$00 
!ExByte3 = #$00
!ExByte4 = #$00

print "MAIN ",pc
	RTL


print "INIT ",pc
	TXY

	LDA !Sprite
	if !Custom
	STA !7FAB9E,x
	else
	STA !9E,y
	endif

	JSL $07F7D2|!BankB

	if !Custom

		LDA #$08|(!ExtraBit*4)
		STA !7FAB10,x
		JSL $0187A7|!BankB

	endif

	LDA !ExByte1
	STA !extra_byte_1,x
	LDA !ExByte2
	STA !extra_byte_2,x
	LDA !ExByte3
	STA !extra_byte_3,x
	LDA !ExByte4
	STA !extra_byte_4,x


	LDA !State
	STA !14C8,y
	INX

	RTL                