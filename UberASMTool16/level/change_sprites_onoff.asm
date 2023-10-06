!SpriteOff	= $0F
!SpriteOn	= $C4

!freeram	= $13C8|!addr
!switch		= $14AF|!addr

init:
	lda !switch
	sta !freeram
	rtl

main:
	lda $9D
	bne .return
	lda !switch
	cmp !freeram
	sta !freeram
	beq .return
	ldy #!sprite_slots-1
-	lda !14C8,y
	cmp #$08
	bcc +
	ldx !switch
	lda.w !9E,y
	cmp.l .sprites,x
	bne +
	txa
	eor #$01
	tax
	lda.l .sprites,x
	sta.w !9E,y
	lda !157C,y
	pha
	phy
	tyx
	jsl $07F7D2|!bank
	ply
	pla
	sta !157C,y
	lda #$01
	sta !14C8,y
+	dey
	bpl -
.return
	rtl

.sprites
	db !SpriteOff,!SpriteOn
