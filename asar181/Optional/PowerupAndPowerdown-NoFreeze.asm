; SJandCharlie note: removed feather section, because broken for some reason


;==================================================================================================
; Disable Mario Powerup Animations
;
; Disables the "power-down when hurt," "touched Mushroom/growing up," "touched Fire Flower" and
; "touched Feather" animations, causing the player to change powerup state without freezing the
; game briefly.
;
;	Author: Maarfy
;
; v1.0
;==================================================================================================

!show_smoke	= 1			; 0 = do not show the smoke puff when touching a feather
						; 1 = show the smoke puff when touching a feather

;==================================================================================================

if read1($00FFD5) == $23
	sa1rom
	!addr	= $6000
else
	lorom
	!addr	= $0000
endif

;==================================================================================================

org $00F5FC				; Disable "power down" animation
	STZ $19				;  Make player small
	LDA #$7F			;  
	STA $1497|!addr		;  Set flashing invulnerability timer
	BRA $1C				;  Skip over animation setup
	NOP					;  

;--------------------------------------------------------------------------------------------------

org $01C554				; Disable "growing big" animation from collecting Mushroom while small
	db $6D				;  Repoints jump table past animation setup
						; 
org $01C56C				; 
	NOP					; 
	INC $19				;  Make player big



;--------------------------------------------------------------------------------------------------

org $01C55C				; Disable "collected Fire Flower" animation
	db $F7				;  Repoints jump table past animation setup


