; Mx -> mx
; Call with:
; $00 :: *long const u8   - pointer to start of utf-8 byte sequence
; Returns:
; A                       - codepoint (16-bit)
; $00 :: *long const u8   - pointer to end of utf-8 byte sequence
Utf8Decode:
	ldx $00
	lda [$00] : bpl .singleByte
	; if our first byte is a trail byte, it's invalid
	bit #$40 : beq .badChar
	; 4-byte characters are unsupported
	cmp #$f0 : bcs .badChar

	inx : stx $00
	cmp #$e0
	and #$1f
	bcc .twoByte
.threeByte:
	sta $06
	lda [$00] : bpl .badChar : cmp #$c0 : bcs .badChar
	inx : stx $00
	and #$3f
	bra .threeBytesPt2
.twoByte:
	stz $06
.threeBytesPt2:
	sta $05
	lda [$00] : bpl .badChar : cmp #$c0 : bcs .badChar
	rep #$20
	and #$003f
	sta $03
	lda $04 : lsr : lsr
	tsb $03
	lda $05 : and #$0f00 : asl #4
	ora $03
	inx : stx $00
	rts

.badChar:
	inx : stx $00
	rep #$20
	lda #$fffd
	rts

.singleByte:
	inx : stx $00
	rep #$20
	and #$007f
	rts

; call with A = font ID
InitFont:
	php
	sep #$30
	asl : tax
	rep #$30
	lda.l fontPtrs,x : sta.l !fontDataPtr
	plp
	rts

; same args as DrawChar
; returns number of tiles advanced in A,
; auto-newline in carry
DrawAndUprq:
	jsr DrawChar
	bcs .drew
	rts
.drew:
	rep #$30
	; save number of tiles advanced
	pha
	; if we advanced, set $02
	ldx.w #0
	cmp.w #0 : beq +
	inx
+	stx $02

	; tilemap: left and right half of the latest char
	lda.l !stimIdx : tax
	lda.w !tmVAddr : xba : sta.l !stimTable,x
	; upload two tilenames if need be
	lda $02 : asl : inc : xba : sta.l !stimTable+2,x : xba
	; also get our end offset
	lda $02 : asl : adc.w #6 : sta $04
	; set carry if we crossed tiles
	cmp #$0008
	lda.w !charId : ora.w !textProps : sta !stimTable+4,x
	bcc +
	inc : sta.l !stimTable+6,x
	clc
+	txa : adc $04 : tax

	; character buffers:
	; we upload the left buffer always, and the right buffer
	; if we crossed a boundary
	lda.w !charVAddr : xba : sta.l !stimTable,x
	lda.w #xb(16-1)
	ldy $02 : beq +
	lda.w #xb((16*2)-1)
+	sta.l !stimTable+2,x

	phb
	txa : clc : adc.w #!stimTable+4 : tay
	; MVN: 16 bytes from left ch buf -> !stimTable
	ldx $08
	lda.w #16-1
	mvn !stimTable>>16,!chBuf>>16

	ldx $02 : beq +
	; MVN: 16 bytes from right ch buf -> !stimTable
	ldx $0a
	lda.w #16-1
	mvn !stimTable>>16,!chBuf>>16
+
	lda #$ffff : sta $0000,y
	tya : sec : sbc.w #!stimTable : sta.w !stimIdx
	plb

	; advance to the next tile in VRAM if needed

	ply ; number of tiles advanced
	; move to the next tile if we need to
	beq .noAdvance
.singleAdvance:
	cpy #$0001 : bne .doubleAdvance
	; next character pattern
	lda.w !charVAddr : clc : adc #$0008 : sta.w !charVAddr
	; next character ID
	inc.w !charId
	; next entry in the row tilemap
	inc.w !tmVAddr
.noAdvance:
	sec
	tya
	rts

.doubleAdvance:
	; next character pattern
	lda.w !charVAddr : clc : adc #$0010 : sta.w !charVAddr
	; next character ID
	inc.w !charId : inc.w !charId
	; next entry in the row tilemap
	inc.w !tmVAddr : inc.w !tmVAddr
	sec
	tya
	rts

DrawCharOtherBuf:
	sta $0e
	bra DrawChar_noBufSet

; call with:
;  A - codepoint (16-bit)
;  B - bank of !chBuf
;  !drawPos     :: u16            - position to draw into
;  !fontDataPtr :: *long const u8 - pointing at font data
; This returns:
;  $04 :: *long const u8          - character pattern address
;  $08 :: *short(!chBuf) mut u8   - left buffer address
;  $0a :: *short(!chBuf) mut u8   - right buffer address
;  !drawPos - updated to next character
;  carry - set if character was drawn normally, clear if auto-new line produced instead
DrawChar:
	rep #$30
	sta $0e
	; set up:
	; $08 =     left buffer  (*short(!freeram) mut u8)
	; $0a =     right buffer (*short(!freeram) mut u8)
	lda.w !drawPos : and #$0008 : asl
	pha
	adc.w #!chBuf : sta $08
	pla
	eor #$0010 : adc.w #!chBuf : sta $0a
.noBufSet:
	; $0c = letter spacing
	ldx.w !fontDataPtr
	lda.l !codeK+!FONT_SPACING,x : and #$00ff : sta $0c
	; $04 = source tile gfx (*long const u8)
	bra .gfxlookup

.fallback:
	lda.l !codeK+!FONT_FALLBACK,x
	; if we are about to fall back from a basis font, things are really ruined,
	; so we take $00:0000 to be our graphics since it will look ugly and isn't I/O
	; or anything
	bit #$0080 : beq .nonbasis
.basis:
	stz $04
	stz $05
	bra .gotPtr

.nonbasis:
	and #$003f : asl : tax
	lda.l fontPtrs,x
	tax
.gfxlookup:
	lda $0e
	cmp.l !codeK+!FONT_CHARS,x : bcs .fallback
	and #$ff00 : cmp #$d800 : bcc .gotPage
	cmp #$e000 : beq .pageE0
	cmp #$f900 : bcc .unsupport
; pages $f9...$ff
	sbc.w #($f900-$d900)
	bra .gotPage
.unsupport:
	lda #$fffd : sta $0e
	lda #$cf00
	bra .gotPage
.pageE0:
	lda.w #$d800
.gotPage:
	xba
	asl
	stx $00
	adc.b $00
	tax
	stz $05
	lda $0e : and #$00ff : asl #4 : sta $04
	lda.l !codeK+!FONT_PAGES,x
	beq .fallback
	adc $05
	sta $05
.gotPtr:

	; determine our shift amount
	lda.w !drawPos : and #$0007 : sta $00

	; determine letter width, add it to our pixel position
	; uses $02, $03 as temporaries
	; width is left in X
.getWidth:
	stz $02
	sep #$20
	ldy.w #0
	ldx.w #8
	-	lda [$04],y
		iny
		tsb $02
		lda [$04],y
		tsb $02
		tsb $03
		iny
		dex : bne -

	lda $02
	; x is already 0 from the above loop
	-	inx : asl : bne -
	txa : sta $02

	ldx.w #0
	lda $03
	beq +
	-	inx : asl : bne -
	stz $03
+

.spaceCheck:
	; If we are a space, we don't actually need to draw anything.
	; There are a lot of spaces in Unicode. Only a few are properly supported.
	; Unfortunately, the space characters are pretty sparse,
	; so we can't really just use a LUT here.
	; Checking each one in order is probably the best way.

	; Known absences:
	; U+1680 OGHAM SPACE MARK
	; U+180E MONGOLIAN VOWEL SEPARATOR
	; U+2028 LINE SEPARATOR
	; U+2029 PARAGRAPH SEPARATOR
	; U+202F NARROW NO-BREAK SPACE
	; U+205F MEDIUM MATHEMATICAL SPACE
	; U+FEFF ZERO WIDTH NON-BREAKING SPACE

	; There are probably others.

	rep #$20
	lda $0e
	; first check if we are a control code; we don't draw those
	cmp #$0020 : bcc .zeroWidth
	beq .isSpace                 ; U+0020 SPACE

	; most of our text will probably be ASCII-ish, so it's best
	; to get the low-numbered spaces out of the way first
	cmp #$00a0 : beq .isSpace    ; U+00A0 NO-BREAK SPACE
	; there are no other spaces below U+00A0 unless you count
	; U+007F DELETE, but we intentionally don't since that's
	; probably an error rather than something intentionally
	; placed in the text
	bcc .notSpace
+
	; all further supported spaces are in $2000..$3000
	cmp #$2000 : bcc .notSpace
	cmp #$3000 : beq .isSpace    ; U+3000 IDEOGRAPHIC SPACE
	; there are no spaces past U+3000 at all
	bcs .notSpace
	cmp #$2060 : beq .zeroWidth  ; U+2060 WORD JOINER


	cmp #$2010 : bcs .notSpace
	; U+200B ZERO WIDTH SPACE
	; U+200C ZERO WIDTH NON-JOINER
	; U+200D ZERO WIDTH JOINER
	; U+200E LEFT-TO-RIGHT MARK
	; U+200F RIGHT-TO-LEFT MARK
	cmp #$200b : bcs .zeroWidth
	; U+2000 EN QUAD
	; U+2001 EM QUAD
	; U+2002 EN SPACE
	; U+2003 EM SPACE
	; U+2004 THREE-PER-EM SPACE
	; U+2005 FOUR-PER-EM SPACE
	; U+2006 SIX-PER-EM SPACE
	; U+2007 FIGURE SPACE
	; U+2008 PUNCTUATION SPACE
	; U+2009 THIN SPACE
	; U+200A HAIR SPACE

.isSpace:
	lda.w !drawPos
	and #$0007
	clc : adc $02
	lsr #3
	pha
	lda $02 : clc : adc.w !drawPos : sta.w !maskPos
	txa
	adc.w !drawPos : sta.w !drawPos
	cmp.w !lineWidth
	pla
	bcc .spaceSuccess
	rep #$31
	rts

.spaceSuccess:
.zeroWidth:
	; zero-width characters always "draw" successfully
	sec
	rep #$30
	rts

.notSpace:
	lda.w !drawPos
	and #$0007
	pha
	txa
	clc : adc $01,s
	adc $0c
	lsr #3
	sta $01,s
	lda $02 : clc : adc.w !drawPos : sta.w !maskPos
	txa : adc $0c : adc.w !drawPos : sta.w !drawPos
	cmp.w !lineWidth : bcs .autoNewLine

	; $04 points the character data.
	; if we use lda [$04],y, we'll get the byte we want in the low
	; byte of A.
	; we want it in the high byte, so move back one byte
	dec $04

	; erase the silhouette of the character before drawing
	; this is required when using color 1 as an outline
	; (or else color 2 on top of color 1 makes color 3)
	; and on the overworld to avoid muddling the BG
	; this loop runs 8 times, processing 2 bitplanes each iteration
	sep #$10
	ldy.b #16-1
	.silherase:
		; mask = hi bitplane | lo bitplane
		rep #$20
		lda [$04],y ; hi bitplane
		dey
		ora [$04],y ; lo bitplane
		iny
		; filter just to the actual mask
		and #$ff00
		ldx $00 : beq ..noshift
		-	lsr : dex : bne -
	..noshift:
		; invert mask so we can use it to erase
		eor #$ffff
		pha
		sep #$20
		; hi bitplane
		and ($0a),y : sta ($0a),y
		xba
		and ($08),y : sta ($08),y
		dey
		; lo bitplane
		pla : and ($0a),y : sta ($0a),y
		pla : and ($08),y : sta ($08),y
		dey : bpl .silherase

	; draw the character
	; this loop runs 16 times, processing 1 bitplane each iteration
	ldy.b #16-1
	.drawline:
		rep #$20
		lda [$04],y : and #$ff00
		ldx $00 : beq ..noshift
		-	lsr : dex : bne -
	..noshift:
		sep #$20
		ora ($0a),y : sta ($0a),y
		xba
		ora ($08),y : sta ($08),y
		dey : bpl .drawline

	rep #$30
	pla
	sec
	rts

.autoNewLine:
	rep #$31
	pla
	lda #$0000
	rts

; returns carry set if we couldn't newline
; (i.e. line number + 1 >= max)
NewLine:
	sep #$20
	lda.w !lineNumber : inc
	cmp.w !maxLines
	beq .noNewLine
	sta.w !lineNumber

	stz.w !drawPos
	stz.w !maskPos
	rep #$31
	inc.w !charId
	lda.w !charVAddr : clc : adc #$0008 : sta.w !charVAddr
	lda.w !tmVAddr : and #$ffe0 : adc #$0020 : sta.w !tmVAddr
	rts

.noNewLine:
	lda #$01 : sta.w !msgWaiting
	rep #$30
	sec
	rts
