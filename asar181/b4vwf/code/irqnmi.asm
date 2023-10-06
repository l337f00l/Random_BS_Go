pushpc
	org !FR|$008385
		jml Irq
		nop
	org !FR|$00838c
	IrqBack:
pullpc

if !HAS_STATUS_BAR == 0
	pushpc
		org !FR|$0082b0
			jml Nmi
			nop #2
		NmiBack:
	pullpc

	Nmi:
		lda.w !WB|$0d9b : bne .noMsgIrq
		lda.w !WB|$1426 : beq .noMsgIrq
		lda.w !WB|$1b89 : cmp.b #8 : bcc .noMsgIrq
		lda.l !irqTop : sta.w $4209
		stz.w $420a
		lda.b #$a1 : sta.w $4200
		stz $11
	.noMsgIrq:
		lda.w !WB|$0dae
		sta.w $2100
		jml NmiBack
endif

Irq:
	ldy.w !WB|$0d9b : bpl +
	lda #$81
	jml !FR|$0083ba
+
	lda.w !WB|$1426 : bne .msgIrq
.noMsgIrq:
	lda.b #$81
	jml IrqBack

.msgIrq:
	lda $11
	inc
	sta $11
	dec
	asl : tax
	rep #$10
	jmp (.irqSubs,x)

	if !HAS_STATUS_BAR
	.irqSubs:
		dw .pre, .top, .btm

	.pre:
		sep #$10
		lda.w !WB|$1b89 : cmp.b #8 : bcc .noMsgIrq
		lda.l !irqTop : sta.w $4209
		lda #$a1
		jml IrqBack
	else
	.irqSubs:
		dw .top, .btm
	endif

.top:
	if !DYNAMIC_PALETTE
		ldy.w #$2200 : sty.w $4320
		ldy.w #paletteVals : sty.w $4322
		lda.b #paletteVals>>16 : sta.w $4324
		ldy.w #$0008 : sty.w $4325
		lda.b #!LVL_PALETTE : sta.w $2121
	endif

	lda #$80
	-	bit.w $4212 : bvc -
	sta.w $2100

	if !DYNAMIC_PALETTE
		lda.b #$04 : sta.w $420b
	endif

	stz.w $2105

	lda #$08 : sta.w $212c : sta.w $212d
	sta.w $212e : sta.w $212f

	lda.b #$04|(!BG4_GFX>>9) : sta.w $210c
	lda.b #!BG4_TM>>9 : sta.w $210a

	lda.b #!BG4_POS_X : sta.w $2113
	lda.b #xb(!BG4_POS_X) : sta.w $2113
	if !LINE_SPACING == 0
		; if line spacing is on, this is taken care of by HDMA
		lda.l !bg4ofs : sta.w $2114
		lda.l !bg4ofs+1 : sta.w $2114
	endif

	lda $42 : and #$0f : ora #$30 : sta.w $2124
	stz.w $2125
	lda #$12 : sta.w $2130

	lda.l !irqBtm : sta.w $4209
	lda.w !WB|$0dae : sta.w $2100
	jml !FR|$0083b2

.btm:
	if !DYNAMIC_PALETTE
		ldy #$2200 : sty.w $4320
		ldy.w #!WB|($0703+(!LVL_PALETTE*2)) : sty.w $4322
		stz.w $4324
		ldy.w #$0008 : sty.w $4325
		lda.b #!LVL_PALETTE : sta.w $2121
	endif

	lda #$80
	-	bit.w $4212 : bvc -
	sta.w $2100

	if !DYNAMIC_PALETTE
		lda.b #$04 : sta $420b
	endif

	lda $40 : sta.w $2131
	lda $44 : sta.w $2130

	ldx $41 : stx.w $2123
	lda $43 : sta.w $2125
	ldx.w !WB|$0d9d : stx.w $212c : stx.w $212e

	sep #$30
	lda.w !WB|$0dae
	ldy $3e
	ldx $40
	-	bit.w $4212 : bvc -
	sty.w $2105
	stx.w $2131
	sta.w $2100
	jml !FR|$0083b2
