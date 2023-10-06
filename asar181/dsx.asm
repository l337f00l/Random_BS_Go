;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dynamic Sprites Patch
;; By smkdan & edit1754 
;;
;; Original description:
;; code to provide sprites with dynamic video memory updating
;; patched with asar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This update copies SA-1 method to handle the dynamic sprite slots.
;; 
;; Originally, dsx.asm just uploaded the whole lower half of SP4 every frame,
;; now it only uploads the graphics of the sprites that are on screen.
;;
;; It also has integrated garble.asm instead of having it on another file.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

lorom

!slots_used	= $06FE		;how many slots have been used
!dsx_buffer	= $7F0B44	;buffer for dynamic sprites gfx

!install_garble	= 1		;install garble.asm
				;change to 0 if you don't want to install it.

if !install_garble == 1
org $80A08A
	autoclean jml garble
endif

;FastROM registration data
org $80FFD5
	db $30

org $80816A
	autoclean jml dsx_main

;;;;;;;;;;;;;
;; Macro borrowed from SA-1 patch
;;;;;;;;;;;;;

; A is 16-bit, X is 8-bit.
macro transferslot(slot, bytes, shift)
	LDA.W #$7C00+(<slot>*256)+<shift>	; \ VRAM address + line*slot
	STA.W $2116				; /
	LDA.W #(!dsx_buffer&65535)+(<slot>*512)+(<shift>*2) ;\ Set Buffer location
	STA.W $4302				; /
	LDA.W #<bytes>				; \ Set bytes to transfer
	STA.W $4305				; /
	STY.W $420B				; Run DMA.
endmacro

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; start code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

freedata

dsx_main:
	sei 
	php 
	rep #$30		;initialize NMI
	pha 
	phx 
	phy 
	phb 
	sep #$30
	
	lda #$80		;set bank to zero in FastROM area
	pha 
	plb 
	
	lda #$01		;FastROM on
	sta $420D

	lda $0100		;check game mode to see if in game
	cmp #$07		;must be in either this mode (title screen)...
	beq GameModeOK		
	cmp #$14		;... or this mode (level)
	bne Return

GameModeOK:
	lda !slots_used		;and only if there's actual stuff to transfer
	beq Return
	
	rep #$20
	tdc			;clear A
	ldy #$80
	sty $2115		;setup some DMA transfer info
	lda #$1801
	sta $4300
	ldy.b #!dsx_buffer/65536
	sty $4304
	ldy #$01
	
	lda !slots_used
	asl
	tax			;upload gfx
	jsr (dsx_modes-2,x)
	dey
	sty !slots_used
Return:				
	sep #$30		;8bit AXY
	jml $808176		;jump to code just after pushing, into FastROM area

dsx_modes:
	dw .transfer_one
	dw .transfer_two
	dw .transfer_three
	dw .transfer_four

.transfer_one		;transfer a 32x32 square (one slot)
	%transferslot(0, $0080, $C0)
	%transferslot(1, $0080, $C0)	
	%transferslot(2, $0080, $C0)
	%transferslot(3, $0080, $C0)
	rts
.transfer_two		;transfer a 64x32 rectangle (two slots)
	%transferslot(0, $0100, $80)
	%transferslot(1, $0100, $80)	
	%transferslot(2, $0100, $80)
	%transferslot(3, $0100, $80)
	rts
.transfer_three		;transfer a 96x32 rectangle (three slots)
	%transferslot(0, $0180, $40)
	%transferslot(1, $0180, $40)	
	%transferslot(2, $0180, $40)
	%transferslot(3, $0180, $40)
	rts
.transfer_four		;transfer a 128x32 rectangle (four slots)
	%transferslot(0, $0800, $00)
	rts
	
if !install_garble == 1
garble:
	phk
	pea.w .return-1
	pea.w $8575-1
	jml $84DD40
.return
	lda $1B9C
	beq .branch
	jml $80A08F
.branch
	jml $80A093
endif