!TILE_START_VRAM #= !OW_VRAM
!TILE_START_ID #= ((!TILE_START_VRAM-$8000)/16)&$3ff

!NAME_PROPS #= $2000|((!OW_PALETTE/4)<<10)
!TM_X #= !OW_POS_X/8
!TM_Y #= !OW_POS_Y/8
!TM_START_VRAM #= $a000+(64*!TM_Y)+(2*!TM_X)

bgGfx:
	incbin "../owname-bg.bin"

InitLevelName:
	pha : asl : clc : adc $01,s : plx : tax
	lda.l levelNames,x
	sta.l !msgPtr
	sep #$20
	lda.l levelNames+2,x : sta.l !msgPtr+2
	lda.b #!OW_FONT
	jsr InitFont
	jsr BgToBuffers
	sep #$20
	stz.w !lineNumber
	lda.b #!OW_LINES : sta.w !maxLines
	stz.w !msgWaiting
	rep #$20
	stz.w !drawPos
	stz.w !maskPos
	; for some reason line wrap gets way too eager
	; and tends to stop 8px short
	lda.w #!OW_WIDTH : sta.w !lineWidth
	lda.w #!NAME_PROPS : sta.w !textProps
	lda.w #!TM_START_VRAM>>1 : sta.w !tmVAddr
	; these values skip the BG tile
	lda.w #(!TILE_START_VRAM+$10)>>1 : sta.w !charVAddr
	lda.w #!TILE_START_ID+1 : sta.w !charId

	sep #$20
	lda.l !WB|$0100
	cmp #$0c : beq .instant
	rep #$20
.later:
	lda.l !stimIdx : tax
	; upload the bg character
	lda.w #xb(!TILE_START_VRAM>>1) : sta.l !stimTable,x
	lda.w #xb(16-1) : sta.l !stimTable+2,x
	txa : clc : adc.w #!stimTable+4 : tay
	ldx.w #bgGfx
	lda.w #16-1
	mvn !stimTable>>16,bgGfx>>16
	tya : sec : sbc.w #!stimTable : tax
	; upload a tilemap consisting of the bg character
	lda.w #xb(!TM_START_VRAM>>1) : pha
	ldy.w #!OW_LINES
	clc
	-	pla : sta.w !stimTable,x
		adc.w #xb($20) : pha
		lda.w #xb($4000|((!OW_WIDTH/8)*2)) : sta.w !stimTable+2,x
		lda.w #!TILE_START_ID|!NAME_PROPS : sta.w !stimTable+4,x
		txa : adc.w #6 : tax
		dey : bne -
	pla
	lda.w #$ffff : sta.w !stimTable,x
	stx.w !stimIdx
	sep #$20
	rtl

.instant:
	; save the ram our hijack was using
	pei ($00)
	pei ($04)

	lda.b #$00 : pha : plb

	; upload the tilemap
	lda.b #$80 : sta $2115
	lda.b #!OW_LINES : sta $00
	ldx.w #!TM_START_VRAM>>1
	ldy.w #!TILE_START_ID|!NAME_PROPS
.tmLine:
	stx.w $2116
	rep #$21 : txa : adc #$0020 : tax : sep #$20
	lda.b #!OW_WIDTH/8
-	sty $2118 : iny : dec : bne -
	dec $00 : bne .tmLine

	; set stuff up so we can quickly start uploading characters later
	ldx.w #!TILE_START_VRAM>>1 : stx.w $2116
	ldx.w #$1801 : stx.w $4320
	lda.b #!owLineBuf>>16 : sta.w $4324

	lda.b #!freeram>>16 : pha : plb
	; prep the first line
	jsr BgToLineBuf
.loop:
	sep #$20
	lda.w !msgPtr+2 : sta $02
	ldx.w !msgPtr : stx $00
	lda [$00]
	cmp.b #$0a : beq .newLine
	cmp.b #$20 : bcc .endOfString
	phx
	jsr Utf8Decode
	stx.w !msgPtr
	jsr DrawCharOtherBuf
	plx
	bcc .autoNewLine
	asl #4
	adc $08 : sta $08
	adc.w #$0010 : sta $0a
	bra .loop

.autoNewLine:
	dex
.newLine:
	inx : stx.w !msgPtr
	jsr NewLine
	bcs .endOfString
	sep #$20
	jsr UploadLineBuf
	jsr BgToLineBuf
	bra .loop

.endOfString:
	rep #$20
	; restore ram for our hijack
	plx : stx $04
	plx : stx $00
	; mark the message complete
	sep #$20
	; upload the last line
	jsr UploadLineBuf
	lda.b #1 : sta.l !msgWaiting
	rtl

.bgtm:
	dw !TILE_START_ID|!NAME_PROPS

UploadLineBuf:
	pea.w (!freeram>>8)&$ff00 ; bank 0, then the freeram bank
	plb
	ldx.w #!owLineBuf : stx.w $4322
	ldx.w #(!OW_WIDTH/8)*16 : stx.w $4325
	lda.b #$04 : sta.w $420b
	plb
	rts

BgToLineBuf:
	php
	rep #$30
	ldy.w #!owLineBuf : sty $08
	ldy.w #!owLineBuf+$10 : sty $0a

	lda.w #!OW_WIDTH/8
	ldy.w #!owLineBuf
-	pha
	ldx.w #bgGfx
	lda.w #16-1
	mvn !freeram>>16,bgGfx>>16
	ldx.w #bgGfx
	lda.w #16-1
	mvn !freeram>>16,bgGfx>>16
	pla : dec : bne -
	plp
	rts

OwDispatch:
	lda #$03 : sta.w !WB|$13f9 ; hijack

	lda.l !msgWaiting : bne .earlyReturn
	; quit if the player is looking around the map
	; (this avoids conflicts with those dreadful arrows)
	lda.w !WB|$13d4 : bne .earlyReturn
	; this is running on the SA-1 CPU, but the stripe image table is in WRAM,
	; so we need to invoke the SNES
	if !vitorSA1
		lda.b #.notDone : sta.w $3183
		lda.b #.notDone>>8 : sta.w $3184
		lda.b #.notDone>>16 : sta.w $3185
		lda.b #$d0 : sta.w $2209
	-	lda $318a : beq -
		rtl
	endif

.notDone:
	phb
	lda.b #!freeram>>16 : pha : plb
	rep #$10
	ldx.w !msgPtr : stx $00
	lda.w !msgPtr+2 : sta $02
	lda [$00]
	cmp.b #$0a : beq .newLine
	cmp.b #$20 : bcc .endOfString
	phx
	jsr Utf8Decode
	stx.w !msgPtr
	jsr OwProcessChar
	plx
	bcs .return
.autoNewLine:
	dex
.newLine:
	inx : stx.w !msgPtr
	jsr NewLine
	lda.w #!TM_X : tsb.w !tmVAddr
	jsr BgToBuffers
.return:
	sep #$30
	plb
.earlyReturn:
	rtl

.endOfString:
	sep #$30
	; A = 0 so this gives us 1
	inc : sta.w !msgWaiting
	plb
	rtl

OwProcessChar:
	jsr DrawAndUprq
	dec : bmi .noAdvance
	; relies on these routines not touching carry
	beq BgToLeft ; single advance
	bra BgToBuffers ; double advance
.noAdvance:
	rts

BgToBuffers:
	rep #$30
	ldy.w #!chBuf
	ldx.w #bgGfx
	lda.w #16-1
	mvn !chBuf>>16,bgGfx>>16
	ldx.w #bgGfx
	lda.w #16-1
	mvn !chBuf>>16,bgGfx>>16
	rts

; call with $08 = left buffer
BgToLeft:
	lda.w #16-1
	ldx.w #bgGfx
	ldy $08
	mvn !chBuf>>16,bgGfx>>16
	rts


