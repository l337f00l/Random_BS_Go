; note: irq takes longer to get out of waiting for h-blank in this version
; than the non-sa-1 version, so we dec before $4209 writes

pushpc
	org !FR|$0082b0
		jml Nmi
		nop #2
	NmiBack:
pullpc

Nmi:
	lda.w !WB|$0dae : sta.w $2100
	lda.w !WB|$0d9b : bne .noMsgIrq
	lda.w !WB|$1426 : beq .noMsgIrq
	lda.w !WB|$1b89 : cmp.b #8 : bcc .noMsgIrq
	rep #$20
	if !HAS_STATUS_BAR
		lda.w #IrqPre : sta.w !sa1irqptr
	else
		lda.w #IrqTop : sta.w !sa1irqptr
		lda.l !irqTop : dec : sta.w $4209 : stz.w $420a
	endif
	sep #$20
	lda.b #IrqTop>>16 : sta.w !sa1irqptr+2
	lda.b #1 : sta.w !sa1irqctl
	ldx.b #$a1
	stz $11
	lda.w !WB|$0dae : sta.w $2100
	jml NmiBack
.noMsgIrq:
	stz.w !sa1irqctl
	jml NmiBack

if !HAS_STATUS_BAR
IrqPre:
	; this is (mostly) a copy of the SMW status bar routine
	; (the version from `snes_irq.asm` in the SA-1 pack)
	; we need to do this. i am sad.
	phd
	lda $25 : xba
	lda $22
	ldx $23
	ldy $24
	pea $2100 : pld
	jsr WaitForHBlank
	sta $11
	stx $11
	sty $12
	xba
	sta $12

	lda.w $303e : sta $05
	lda.w $3040 : sta $31

	pld

	lda.l !irqTop : dec : sta.w $4209
	rep #$20
	lda.w #IrqTop : sta.w !sa1irqptr
	sep #$20

	rtl
endif

IrqTop:
	phd
	pea $2100 : pld
	rep #$10
	if !DYNAMIC_PALETTE
		ldy.w #$2200 : sty.w $4320
		ldy.w #paletteVals : sty.w $4322
		lda.b #paletteVals>>16 : sta.w $4324
		ldy.w #$0008 : sty.w $4325
		lda.b #!LVL_PALETTE : sta $21
	endif

	lda #$80
	jsr WaitForHBlank
	sta $00
	if !DYNAMIC_PALETTE
		lda.b #$04 : sta.w $420b
	endif
	stz $05

	lda #$08 : sta $2c : sta $2d
	sta $2e : sta $2f

	lda.b #$04|(!BG4_GFX>>9) : sta $0c
	lda.b #!BG4_TM>>9 : sta $0a

	lda.b #!BG4_POS_X : sta $13
	lda.b #xb(!BG4_POS_X) : sta $13
	if !LINE_SPACING == 0
		; if line spacing is on, this is taken care of by HDMA
		lda.l !bg4ofs : sta $14
		lda.l !bg4ofs+1 : sta $14
	endif

	lda.w !DP|$42 : and #$0f : ora #$30 : sta $24
	stz $25
	lda #$12 : sta $30

	ldx.w #IrqBtm : stx.w !sa1irqptr

	lda.l !irqBtm : dec : sta $4209

	; we're in a black region, but turning on the display mid-screen
	; can generate garbage
	lda.w !WB|$0dae
	jsr WaitForHBlank
	sta $00

	sep #$10
	pld
	rtl

IrqBtm:
	phd
	pea $2100 : pld
	rep #$10
	if !DYNAMIC_PALETTE
		ldy #$2200 : sty.w $4320
		ldy.w #!WB|($0703+(!LVL_PALETTE*2)) : sty.w $4322
		stz.w $4324
		ldy.w #$0008 : sty.w $4325
		lda.b #!LVL_PALETTE : sta $21
	endif

	; taking advantage of the fact that we are in a black region
	; of the screen
	lda #$80 : sta $00

	if !DYNAMIC_PALETTE
		lda.b #$04 : sta $420b
	endif

	lda.w !DP|$40 : sta $31
	lda.w !DP|$44 : sta $30

	ldx.w !DP|$41 : stx $23
	lda.w !DP|$43 : sta $25
	ldx.w !WB|$0d9d : stx $2c : stx $2e

	sep #$30
	lda.w !WB|$0dae
	ldy.w !DP|$3e
	ldx.w !DP|$40
	jsr WaitForHBlank
	sta $00
	sty $05
	stx $31

	stz.w !sa1irqctl
	; this a routine the SA-1 pack uses to set up IRQ-as-NMI
	; it is probably better to call it than to break that
	pld
	jsr $1d08
	rtl


WaitForHBlank:
-	bit $4212
	bvc -
-	bit $4212
	bvs -
	nop #64
	rts
