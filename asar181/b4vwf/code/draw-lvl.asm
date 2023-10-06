LvlDispatch:
	lda.w !WB|$1b88 : beq .notShrinking
.shrinking:
	lda !WB|$1b89 : beq .doneShrinking

	jsr WindowDraw
	lda !WB|$1b89 : sec : sbc #!GROW_SPEED
	bcs +
	lda #$00
+	sta !WB|$1b89
	plb
	rtl

.doneShrinking:
	stz.w !WB|$1426
	stz.w !WB|$1b88
	jml MsgEndRetp

.notShrinking:
	lda.w !WB|$1b89 : beq .init
	cmp #$ff : bne .growing
	jsr StepMessage
	plb
	rtl

.growing:
	lda !WB|$1b89 : clc : adc.b #!GROW_SPEED
	bcc +
	lda #$ff
+	sta !WB|$1b89
	jsr WindowDraw
	plb
	rtl

.init:
	jsr InitMessage
	jsr InitForm
	plb
	lda #$01 : sta.l !WB|$1b89
	rtl

WindowDraw:
	phb
	pea $0000 : plb : plb
	if !LINE_SPACING
		pha
		lda.b #8+!LINE_SPACING : sta $4202
		lda.l !maxLines : sta $4203
		nop #2
		lda.b #!PADDING*2
		clc
		adc $4216
		sta $4202
		pla
		sta $4203
	else
		sta $4202
		lda.l !maxLines : asl #3 : clc : adc.b #!PADDING*2 : sta $4203
	endif

	rep #$30
	lda.l !irqTop : asl : adc.w #!mask-!DP
	tax
	ldy.w #!WINDOW_LEFT
	sep #$20

	lda.w $4217
	; don't draw super teeny-tiny message boxes bc that makes the second IRQ
	; too close to the first
	cmp.b #8 : bcs + : lda.b #8 : +
	pha
	adc.l !irqTop : sta.l !irqBtm
	pla
	-	sty $00,x
		inx #2
		dec
		bpl -

	sep #$30
	plb
	rts

MaskUpdate:
	php
	if !LINE_SPACING
		sep #$20
		lda.w !lineNumber : and #$1f : sta.l $004202
		lda.b #8+!LINE_SPACING : sta.l $004203
		rep #$31
		nop #2
		lda.l $004216
	else
		lda.w !lineNumber
		rep #$30
		and #$001f : asl #3
	endif
	adc.w !irqTop
	asl
	adc.w #!mask+(!PADDING*2)-!DP
	tax
	sep #$20
	lda.w !maskPos
	adc.b #!WINDOW_LEFT-1
	cmp.b #!WINDOW_R_MAX-2 : bcc +
	lda.b #!WINDOW_R_MAX-2
+
	sta $01,x
	sta $03,x
	sta $05,x
	sta $07,x
	sta $09,x
	sta $0b,x
	sta $0d,x
	sta $0f,x
	plp
	rts

InitMessage:
	if !LINE_SPACING
		rep #$10
		ldx.w #$1402 : stx.w $4300+(!SPACING_CHANNEL*$10)
		ldx.w #!spacingHdma : stx.w $4302+(!SPACING_CHANNEL*$10)
		lda.b #!spacingHdma>>16 : sta.w $4304+(!SPACING_CHANNEL*$10)
		sep #$10
		lda.b #$00 : sta.l !spacingHdma
		lda.b #1<<!SPACING_CHANNEL
		tsb.w !WB|$0d9f
	endif
	lda.b #1<<!WINDOW_CHANNEL
	tsb.w !WB|$0d9f

	lda.b #!LVL_FONT : jsr InitFont
	lda.b #0 : sta.l !lineNumber
	sta.l !msgWaiting
	sta.l !exitType
	lda.b #!LVL_LINES : sta.l !maxLines
	lda.w !WB|$1426
	cmp #$03 : bcs .global
	ldx.w !WB|$0109
	cpx #$e9 : beq .global
.level:
	dec : lsr
	lda.w !WB|$13bf
	rep #$30
	and #$00ff
	rol
	pha
	asl
	adc $01,s
	plx
	bra .haveOfs
.global:
	rep #$30
	and #$00ff
	pha
	asl
	adc $01,s
	plx
	adc.w #MsgPtrs_upper-MsgPtrs-3
.haveOfs:
	tax
	lda.l MsgPtrs,x : sta.l !msgPtr
	lda.w #!DFLT_PROPS : sta.l !textProps
	lda.w #!LVL_WIDTH : sta.l !lineWidth
	sep #$20
	lda.l MsgPtrs+2,x : sta.l !msgPtr+2
	lda.b #0 : sta.l !irqBtm
	rts

InitForm:
	sep #$20
	rep #$10
	lda.b #!freeram>>16 : pha : plb
	stz.w !lineNumber

	stz.w !irqBtm
	lda.b #!LVL_POS_Y : sta.w !irqTop
	stz.w !irqTop+1

	ldx.w !msgPtr : stx $00
	lda.w !msgPtr+2 : sta $02
	lda [$00] : cmp #$01 : bne +
	jsr ReadHeader
+
	lda.l !WB|$1b89
	jsr WindowDraw

	rep #$20
	lda.w #((!LVL_VRAM-!BG4_TM)*8)-!PADDING-1
	sec : sbc.w !irqTop
	sta.w !bg4ofs
	if !LINE_SPACING
		; this is all ordered so that we never even temporarily
		; get a table not ending in $00
		ldx.b #0
		stx.w !spacingHdma+0
		stx.w !spacingHdma+3
		stx.w !spacingHdma+6
		lda.w !irqTop
		clc : adc.w #8+!LINE_SPACING+!PADDING
		cmp #$0080 : bcc +
		sbc.w #$007f
		pha
		stx.w !spacingHdma+9
		lda.w #$007f : sta.w !spacingHdma
		stz.w !spacingHdma+1
		ldy.b #$7f : sty.w !spacingHdma
		ldx.b #3
		pla
	+	sta.w !spacingHdma,x
		lda.w #8+!LINE_SPACING
		sta.w !spacingHdma+3,x
		lda.w !bg4ofs : sta.w !spacingHdma+1,x
		sec : sbc.w #!LINE_SPACING
		sta.w !bg4ofs
		sta.w !spacingHdma+4,x
		txa : clc : adc.w #6 : tax
		stx.w !spacingIdx
	endif

	lda.w #!LVL_VRAM>>1 : sta.w !tmVAddr

	; A = (!maxLines&$1f)*32
	lda.l !maxLines-1 : and #$1f00 : lsr #3

	adc.l #!LVL_VRAM>>1 : sta.w !charVAddr

	and #$1fff : lsr #3 : sta.w !charId

	stz.w !drawPos : stz.w !maskPos

	rep #$10
	jsr ClearBuffers
	sep #$30
	rts

ReadHeader:
	php
	rep #$20
	inc.w !msgPtr
	sep #$20
	sep #$10
	lda $13 : pha
	stz $13
	.loop:
		jsr StepMessage
		lda.w !msgWaiting
		beq .loop
	pla : sta $13
	stz.w !msgWaiting
	plp
	rts

StepMessage:
	pea.w !chBuf>>8 : plb : plb
	; if we are waiting, don't go
	lda.w !msgWaiting : bne .wait
	; if the player is pressing something, always go
	lda $15 : bne .go
	; otherwise only go every other frame
	lda $13 : lsr : bcc .go
	rts

.go:
	jsr MaskUpdate
	rep #$10
	ldx.w !msgPtr : stx $00
	lda.w !msgPtr+2 : sta $02
	lda [$00]
	beq .terminator
	cmp #$20 : bcc .ctrlChar
	jmp .getLetter
.ctrlChar:
	cmp #$0a : beq .newLine
	cmp #$0c : beq .formFeed
	cmp #$1b : beq .escape
	cmp #$02 : beq .endHeader
	bra .unusedCtrlChar

.newLine:
	inx : stx.w !msgPtr
	rep #$20
	lda.w #!chBuf : sta $08
	lda.w #!chBuf+$10 : sta $0a
	jsr LvlLineAdvance
	sep #$30
	rts

.terminator:
	sep #$30
	lda.b #2 : sta.w !msgWaiting
	rts

.formFeed:
.endHeader:
	inc.w !msgWaiting
.unusedCtrlChar:
	inx : stx.w !msgPtr
	sep #$30
	rts

.wait:
	; blink until the player presses A/B
	sep #$30
	lda $13 : and #$03 : bne +
	lda.l !WB|$1df5
	dec
	sta.l !WB|$1df5
+	lda $16 : ora $18 : bpl .noExit
.pressed:
	dec.w !msgWaiting : bne .endMsg
.endBox:
	jmp InitForm

.endMsg:
	dec.w !msgWaiting
	lda.b #$01 : sta.l !WB|$1b88
	lda.w !exitType : beq .noExit
	cmp.b #$53 : beq .sideExit
.screenExit:
	jmp ScreenExit

.sideExit:
	phb
	lda.b #(!FR|$058000)>>16 : pha : plb
	lda.w !WB|$13d2 : beq +
	inc.w !WB|$1b87
	jsl !FR|$05b150 : bra .seDone
+	jsl !FR|$05b160
.seDone:
	plb
.noExit:
	rts

.escape:
	inx : stx.w !msgPtr : stx $00
	jsr Escape
	sep #$30
	rts

.getLetter:
	phx
	jsr Utf8Decode
	stx.w !msgPtr
.drawCall:
	jsr LvlProcessChar
	bcs .drew
.didntDraw:
	plx
	stx.w !msgPtr
	jsr LvlLineAdvance
	sep #$30
	rts

.drew:
	plx
	sep #$30
	rts

Escape:
	lda [$00]
	inx : stx.w !msgPtr : stx $00
	cmp #$46 : beq .cmdfont    ; $46 = 'F'
	cmp #$50 : beq .cmdpal     ; $50 = 'P'
	cmp #$59 : beq .setposy    ; $59 = 'Y'
	cmp #$48 : beq .setheight  ; $48 = 'H'
	cmp #$53 : beq .specialend ; $53 = 'S'
	cmp #$45 : beq .screenexit ; $46 = 'E'
	rts

.cmdfont:
	lda [$00]
	inx : stx.w !msgPtr
	eor #$40
	sep #$30
	jmp InitFont

.cmdpal:
	lda [$00]
	inx : stx.w !msgPtr
	eor #$60
	sta.w !textProps+1
	rts

.setposy:
	jsr Utf8Decode
	stx.w !msgPtr
	sec : sbc.w #$0020
	sta.w !irqTop
	rts

.setheight:
	lda [$00]
	inx : stx.w !msgPtr
	eor #$40
	sta.w !maxLines
	rts

.specialend:
	sta.w !exitType
	lda [$00]
	inx : stx.w !msgPtr
	eor #$30
	sta.l !WB|$13d2
	rts

.screenexit:
	sta.w !exitType
	lda [$00]
	inx : stx.w !msgPtr
	eor #$40
	sta.w !exitScreen
	rts

ScreenExit:
	sep #$30
	phb
	lda.b #0 : pha : plb
	jsl !FR|$03bcdc
	lda.l !exitScreen : tay
	lda.w !WB|$19b8,y : sta.w !WB|$19b8,x
	lda.w !WB|$19d8,y : sta.w !WB|$19d8,x
	plb
	lda.b #$06 : sta.b $71
	stz.b $88
	stz.b $89
	rts

LvlLineAdvance:
	jsr NewLine
	bcc .advanced
.outofroom:
	rep #$30
	rts

.advanced:
	if !LINE_SPACING
		sep #$31
		ldx.w !spacingIdx
		stz.w !spacingHdma+3,x
		lda.b #8+!LINE_SPACING
		sta.w !spacingHdma,x
		rep #$20
		lda.w !bg4ofs
		sbc.w #!LINE_SPACING
		sta.w !bg4ofs
		sta.w !spacingHdma+1,x
		inx #3
		stx.w !spacingIdx
	endif
	rep #$30
	; jmp ClearBuffers

ClearBuffers:
	lda.w #32-1-1
	ldx.w #!chBuf
	stz $0000,x
	txy
	iny
	mvn !chBuf>>16,!chBuf>>16
	rts

; call with $08 = left buffer
ClearLeft:
	lda.w #16-1-1
	ldx $08
	stz $0000,x
	txy
	iny
	mvn !chBuf>>16,!chBuf>>16
	rts

LvlProcessChar:
	jsr DrawAndUprq
	dec : bmi .noAdvance
	; relies on these routines not touching carry
	beq ClearLeft ; single advance
	bra ClearBuffers ; double advance
.noAdvance:
	rts


