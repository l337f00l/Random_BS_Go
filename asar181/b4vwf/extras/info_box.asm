;==============================================================================
; b4vwf message box. for pixi
;------------------------------------------------------------------------------
; The extra byte determines the message id:
;    $00    no message
;    $01    level message 1
;    $02    level message 2
;    $03+   global messages
;==============================================================================

; 16x16 tile to use for graphics
!TILE = $c0
; set to 1 if you want the tile to be flipped for no reason,
; like the original; 0 otherwise
!FLIP_TILE = 1

print "INIT ", pc
	; move the sprite up a pixel. smh @ smw
	lda !D8,x
	bne +
	dec !14D4,x
+	dec
	sta !D8,x
	rtl

print "MAIN ", pc
Main:
	phb
	phk : plb

	jsl $01b44f|!BankB      ; be solid

	lda #$03
	%SubOffScreen()

	; check if we need to display the message
	lda !1558,x : dec : bne .noMsg
.msg:
	; idk why this is cleared here but the original sprite
	; does it. maybe something to do with $01b44f
	stz !C2,x

	; display the message
	lda !extra_byte_1,x
	beq .noMsg
	sta $1426|!Base2

	lda #$22 : sta $1dfc|!Base2   ; play sfx
.noMsg:

	jsr Gfx

	plb
	rtl

Gfx:
	lda !1558,x : and #$0e : tay
	lda !14D4,x : xba
	lda !D8,x
	rep #$21
	adc .bounceOfs,y
	sec : sbc $1c
	sta $08
	sep #$20
	; we might be able to skip this but idc it's an info box
	%GetDrawInfo()
	lda.b #!TILE : sta $0302|!Base2,y
	lda !15F6,x : ora $64
	if !FLIP_TILE
		ora #$40
	endif
	sta $0303|!Base2,y

	lda #$01 : sta $00
	lda !14E0,x : xba
	lda !E4,x
	rep #$20
	sec : sbc $1a
	cmp #$fff1 : bcs +
	cmp #$0100 : bcs .offscreen
+	sep #$20
	rol $00
	sta $0300|!Base2,y

	rep #$20
	lda $08
	cmp #$fff1 : bcs +
	cmp #$00e0 : bcs .offscreen
+	sep #$20
	sta $0301|!Base2,y

	tya : lsr #2 : tay
	lda $00 : sta $0460|!Base2,y
	rts

.offscreen:
	sep #$20
	rts

.bounceOfs:
	dw -0, -4, -7, -8, -8, -7, -4, -0
