;---------------------------------------------
; pink mushroom v1.0

; Modified by Bucket.
;  -> Added volocity-sync for mario. Meaning, when mario jumps off of this
;     platform, the speed of the platform will be converted to mario.

;---------------------------------------------
; extra bytes 1 - color (00-07)
;---------------------------------------------
; extra bytes 2 - speed (00-7F)
;---------------------------------------------
; extra bytes 3 - size (00-0F)
;---------------------------------------------
; extra bytes 4 - type 00 - always moving
;                 type 01 - move start on platform
;                 type 02 - stop if on platform
;                 type 03 - move if on platform
;---------------------------------------------
; config
;---------------------------------------------

!tile = $E0

;---------------------------------------------
; do not change
;---------------------------------------------
!size = !1510

!guide_state   = !C2     ; $00:search , $01:moving , $02:derailed
!jump_timer    = !1540   ; derailed timer
!direction     = !157C   ; $00 or $01

!pointer_low   = !151C   ; ram value low byte ?
!pointer_high  = !1528   ; ram value high byte ?

!line_add      = !1534   ; count up 0 to 10
!line_subtract = !1570   ; count down 10 ro 0

!line_tile     = !160E   ; value = map16 - #$76
!line_flag     = !1626   ; $00 or $01

!line_speed    = !187B   ; platform speed
!line_frac     = !1602   ; fraction of speed


; Common Addresses
!Address_Table_Mario_Standing_Flag = $1594
!Address_Table_Sprite_X_Speed = $B6
!Address_Table_Sprite_Y_Speed = $AA
!Address_Player_X_Speed = $7B
!Address_Player_Y_Speed = $7D
!Address_Buttons_B = $16
!Address_Buttons_A = $18

;---------------------------------------------
print "INIT ",pc
	LDA #$02
	STA !jump_timer,x
	
	LDA !extra_byte_1,x
	AND #$07
	STA !extra_byte_1,x
	
	LDA !extra_byte_2,x
	BPL +
	EOR #$FF
	INC A
+
	STA !line_speed,x
	
	LDA !extra_byte_3,x
	AND #$0F
	STA !extra_byte_3,x
	
	LDA !extra_byte_4,x
	AND #$03
	STA !extra_byte_4,x
	AND #$01
	BEQ +
	INC !line_flag,x
+
	RTL

print "MAIN ",pc
	PHB
	PHK
	PLB
	JSR sprite
	PLB
	RTL
	
sprite:

	%GetDrawInfo()
	LDA !extra_byte_3,x
	INC A
	STA $03                       ; $03 - tile count
	
	ASL #3
	STA $02                       ; $02 - size value
	STA !size,x
	
	EOR #$FF
	SEC
	SBC #$06
	STA $04                       ; $04 - x offset addr
	
	LDA !extra_byte_1,x
	ASL A
	INC A
	STA $05                       ; $05 - tile prop
	
	PHX
	LDX $03
-
	CPX #$00
	BNE +
	LDA #!tile+2
	STA $0302|!Base2,y
	BRA ++
+
	CPX $03
	BNE +
	LDA #!tile
	STA $0302|!Base2,y
	BRA ++
+
	LDA #!tile+1
	STA $0302|!Base2,y
++
	LDA $00
	CLC
	ADC $04
	STA $0300|!Base2,y
	
	LDA $01
	SEC
	SBC #$06
	STA $0301|!Base2,y

	LDA $05
	ORA $64
	STA $0303|!Base2,y
	
	LDA $04
	CLC
	ADC #$10
	STA $04
	
	INY #4
	DEX
	BPL -
	
	PLX
	LDY #$02
	LDA $03
	%FinishOAMWrite()
	
;---------------------------------------------
; sprite
;---------------------------------------------
	LDA #$01
	%SubOffScreen()
	LDA $9D
	BEQ +
	RTS
+
	LDA !sprite_x_low,x
	PHA
	
	JSR sub_ling_guide
	
	PLA
	SEC
	SBC !sprite_x_low,x
	
	LDY !pointer_high,x
	PHY
	
	EOR #$FF
	INC A
	STA !1528,x
	
	JSR sub_01B44F
	BCC not_contact2
	
	LDA !extra_byte_4,x
	CMP #$02
	BEQ eb4_3
	CMP #$03
	BEQ eb4_2
	LDA !line_flag,x
	BEQ +
	STZ !line_flag,x
	STZ !jump_timer,x
+
	BRA not_contact3
not_contact2:
	LDA !extra_byte_4,x
	CMP #$02
	BEQ eb4_2
	CMP #$03
	BEQ eb4_3
	BRA not_contact3
eb4_2:
	STZ !line_flag,x
	BRA not_contact3
eb4_3:
	LDA #$01
	STA !line_flag,x
	 
not_contact3:
	PLA
	STA !pointer_high,x
	RTS
	
;---------------------------------------------
; ling guide routine
;---------------------------------------------
sub_ling_guide:
	LDA !jump_timer,x
	ORA !line_flag,x
	BNE +
	
	LDA !guide_state,x
	JSL $0086DF|!BankB
	dw search
	dw moving
	dw derailed
+
	RTS

;----------------------------------------------------------------------------
; state = $00 search line tile
;----------------------------------------------------------------------------
	
x_low_table:
	db $FC,$04,$FC,$04
	
x_high_table:
	db $FF,$00,$FF,$00
	
y_low_table:
	db $FC,$FC,$04,$04
	
y_high_table:
	db $FF,$FF,$00,$00
	
bit_table:
	db $80,$40,$20,$10,$08,$04,$02,$01

count_max_table:
	; small circle line
	db $15,$15,$15,$15
	
	; large circle line
	db $0C,$10,$10
	db $10,$10,$0C
	db $0C,$10,$10
	db $10,$10,$0C
	
	; +-45.0 degree line
	db $15,$15
	
	; +-67.5 degree line
	db $10,$10,$10,$10
	
	; +-22.5 degree line
	db $10,$10,$10,$10
	
	; vertical line / horizontal line
	db $10,$10,$10,$10
	
	; on/off line
	db $15,$15

y_flag_table:  ; 00 - load x , 01 - load y , 02 - load y flip
	db $00,$00,$00,$00
	db $00,$00,$01
	db $02,$00,$00
	db $00,$00,$02
	db $01,$00,$00
	db $00,$00
	db $01,$02,$01,$02
	db $00,$00,$00,$00
	db $02,$02,$00,$00
	db $00,$00

y_speed_table:
	db $00,$10,$00,$F0,$F4,$FC,$F0,$10
	db $04,$0C,$0C,$00,$10,$F0,$FC,$F4
	db $F0,$10,$F0,$10,$F0,$10,$F8,$F8
	db $08,$08,$10,$10,$00,$00,$F0,$10
	db $10,$00,$F0,$F0,$0C,$04,$10,$F0
	db $00,$F4,$F4,$FC,$F0,$10,$00,$0C
	db $10,$F0,$10,$00,$10,$F0,$08,$08
	db $F8,$F8,$F0,$F0,$00,$00,$10,$F0

x_speed_table:
	db $10,$00,$10,$00,$0C,$10,$04,$00
	db $10,$0C,$0C,$10,$04,$00,$10,$0C
	db $10,$10,$08,$08,$08,$08,$10,$10
	db $10,$10,$00,$00,$10,$10,$10,$10
	db $00,$F0,$00,$F0,$F4,$F0,$00,$FC
	db $F0,$F4,$F4,$F0,$00,$FC,$F0,$F4
	db $F0,$F0,$F8,$F8,$F8,$F8,$F0,$F0
	db $F0,$F0,$00,$00,$F0,$F0,$F0,$F0

if !EXLEVEL
	!LayerLookUp	= $0BF6|!Base2
	!L1_Lookup_Lo	= !LayerLookUp+96+96
	!L2_Lookup_Lo	= !LayerLookUp+96+96+16
	!L1_Lookup_Hi	= !LayerLookUp+96+96+32
	!L2_Lookup_Hi	= !LayerLookUp+96+96+32+16
endif

search:
	
	LDY #$03                ; loop
-
	STY $1695|!Base2
	
	LDA !sprite_y_low,x     ;\
	CLC                     ;| $00 - check y low
	ADC y_low_table,y       ;|
	STA $00                 ;/
	
	LDA !sprite_y_high,x    ;\
	ADC y_high_table,y      ;| $01 - check y high
	STA $01                 ;/
	
	LDA !sprite_x_low,x     ;\
	CLC                     ;| $02 - check x low
	ADC x_low_table,y       ;|
	STA $02                 ;/
	
	LDA !sprite_x_high,x    ;\
	ADC x_high_table,y      ;| $03 - check x high
	STA $03                 ;/
	
	LDA !jump_timer,x
	BNE +
	
	LDA $00                 ;\
	AND #$F0                ;| $04 - tile y pos ($?0)
	STA $04                 ;/
	
	LDA !sprite_y_low,x     ;\
	AND #$F0                ;| check x pos if y low is $?0
	CMP $04                 ;|
	BNE +                   ;/
	
	LDA $02                 ;\
	AND #$F0                ;| $05 - tile x pos ($?0)
	STA $05                 ;/
	
	LDA !sprite_x_low,x     ;\
	AND #$F0                ;| skip if x low is $?0
	CMP $05                 ;|
	BEQ loop35              ;/
+
	
	JSR sub_set_pos
	BNE sub_alt_index
	
	LDA $1693|!Base2
	CMP #$94
	BEQ +
	CMP #$95
	BNE ++
	
	LDA $14AF|!Base2
	BEQ loop35
	BNE ++
+
	LDA $14AF|!Base2
	BNE loop35
++
	LDA $1693|!Base2
	CMP #$76
	BCC loop35
	CMP #$9A
	BCC sub_line_tiles
	
loop35:
	LDY $1695|!Base2
	DEY
	BPL -
	
	LDA #$02
	CMP !guide_state,x
	BEQ ++
	STA !guide_state,x
	
	LDY !line_tile,x
	LDA !direction,x 
	BEQ +
	TYA
	CLC
	ADC #$20
	TAY
+
	LDA y_speed_table,y
	BPL $01
	
	ASL
	PHY
	ASL
	STA !sprite_speed_y,x
	PLY
	
	LDA x_speed_table,y
	ASL
	STA !sprite_speed_x,x
	
	LDA #$10
	STA !jump_timer,x
++
	RTS
	
sub_line_tiles:
	PHA
	SEC
	SBC #$76
	TAY
	PLA
	CMP #$96
	BCC +
	
sub_alt_index:
	LDY !line_tile,x
	BRA ++
+
	LDA !sprite_y_low,x
	STA $08
	LDA !sprite_y_high,x
	STA $09
	LDA !sprite_x_low,x
	STA $0A
	LDA !sprite_x_high,x
	STA $0B
	
	LDA $00
	STA !sprite_y_low,x
	LDA $01
	STA !sprite_y_high,x
	LDA $02
	STA !sprite_x_low,x
	LDA $03
	STA !sprite_x_high,x
++
	PHB
	LDA #$07
	PHA
	PLB
	
	LDA $FBF3,y
	STA !pointer_low,x
	
	LDA $FC13,y
	STA !pointer_high,x
	PLB
	
	LDA count_max_table,y
	STA !line_subtract,x
	
	STZ !line_add,x
	TYA
	STA !line_tile,x
	
	LDA !jump_timer,x
	BNE set_state1
	
	STZ !direction,x
	
	LDA y_flag_table,y
	BEQ ++
	TAY
	
	LDA !sprite_y_low,x
	CPY #$01
	BNE +
	EOR #$0F
+
	BRA +
++
	LDA !sprite_x_low,x
+
	AND #$0F
	CMP #$0A
	BCC +
	
	LDA !guide_state,x
	CMP #$02
	BEQ +
	
	INC !direction,x
+
	LDA !sprite_y_low,x
	STA $0C
	LDA !sprite_x_low,x
	STA $0D
	
	JSR moving
	
	LDA $0C
	SEC
	SBC !sprite_y_low,x
	CLC
	ADC #$08
	CMP #$10
	BCS +
	
	LDA $0D
	SEC
	SBC !sprite_x_low,x
	CLC
	ADC #$08
	CMP #$10
	BCS +
	
set_state1:
	LDA #$01
	STA !guide_state,x
	RTS
+
	LDA $08
	STA !sprite_y_low,x
	LDA $09
	STA !sprite_y_high,x
	LDA $0A
	STA !sprite_x_low,x
	LDA $0B
	STA !sprite_x_high,x
	
	JMP loop35

;----------------------------------------------------------------------------
; (state0) sub set position ($01D94D)
;----------------------------------------------------------------------------
	
sub_set_pos:
	
	LDA $00
	AND #$F0
	STA $06
	
	LDA $02
	LSR #4
	PHA
	ORA $06
	PHA
	
	LDA $5B
	AND #$01
	BEQ +
	
	PLA
	LDX $01
	CLC
	ADC $00BA80|!BankB
	STA $05
	
	LDA $00BABC|!BankB
	ADC $03
	STA $06
	BRA ++
+
	PLA
	LDX $03
	CLC
	
if !EXLEVEL
	ADC !L1_Lookup_Lo,x
else
	ADC $00BA60|!BankB,x
endif
	
	STA $05
	
if !EXLEVEL
	LDA !L1_Lookup_Hi,x
else
	LDA $00BA9C|!BankB,x
endif
	
	ADC $01
	STA $06
++
	
if !SA1
	LDA #$40
else
	LDA #$7E
endif
	
	STA $07
	LDX $15E9|!Base2
	
	LDA [$05]
	STA $1693|!Base2
	INC $07
	
	LDA [$05]
	PLY
	STY $05
	
	PHA
	LDA $05
	AND #$07
	TAY
	PLA
	AND bit_table,y
	RTS
	
;----------------------------------------------------------------------------
; state = $01 moving
;----------------------------------------------------------------------------
	
moving:
	LDA !direction,x
	BNE reverse_move
	
	LDY !line_add,x
	JSR sub_move_pos

	LDA !line_speed,x
	LSR #4
	STA $00
	LDA !line_speed,x
	AND #$0F
	ASL #4
	CLC
	ADC !line_frac,x
	STA !line_frac,x
	LDA !line_add,x
	ADC $00
	STA !line_add,x

	CMP !line_subtract,x
	BCC +
	STZ !guide_state,x
+
	RTS
	
reverse_move:
	LDY !line_subtract,x
	DEY
	JSR sub_move_pos
	
	LDA !line_speed,x
	LSR #4
	STA $00
	LDA !line_speed,x
	AND #$0F
	ASL #4
	STA $01
	LDA !line_frac,x
	SEC
	SBC $01
	STA !line_frac,x
	LDA !line_subtract,x
	SBC $00
	STA !line_subtract,x

	LDA !line_subtract,x
	DEC A
	BPL +
set_state0:
	STZ !guide_state,x
+
	RTS
	
;----------------------------------------------------------------------------
; (state1) sub move position routine
;----------------------------------------------------------------------------
	
sub_move_pos:
	PHB
	LDA #$07
	PHA
	PLB
	
	LDA !pointer_low,x
	STA $04
	LDA !pointer_high,x
	STA $05
	
	LDA ($04),y
	AND #$0F
	STA $06
	
	LDA ($04),y
	PLB
	LSR #4
	STA $07
	
	LDA !sprite_y_low,x
	AND #$F0
	CLC
	ADC $07
	STA !sprite_y_low,x
	
	LDA !sprite_x_low,x
	AND #$F0
	CLC
	ADC $06
	STA !sprite_x_low,x
-
	RTS
	
;----------------------------------------------------------------------------
; state = $02 sprite is derailed
;----------------------------------------------------------------------------

derailed:
	
	JSL $01802A|!BankB
	LDA !jump_timer,x
	BNE -
	
	LDA !sprite_y_low,x
	CMP #$20
	BMI -
	
	JMP search
	
;---------------------------------------------
; invisible block routine kai
;---------------------------------------------
sub_01B44F:
	%SetPlayerClippingAlternate()
	
	LDA #$00
	XBA
	LDA !size,x
	
	REP #$20
	EOR #$FFFF
	SEC
	SBC #$0003
	STA $08
	
	SEP #$20
	
	LDA #$00
	XBA
	LDA !size,x
	ASL
	CLC
	ADC #$08
	REP #$20
	STA $0C
	
	LDA #$FFF8
	STA $0A
	LDA #$0008
	STA $0E
	SEP #$20
	
	%SetSpriteClippingAlternate()
	%CheckForContactAlternate()
	BCC not_contact
	
	; This means mario is on contact with the platform.
	; DO YOU THINK MAYBE, JUST MAYBE, IT WOULD HAVE BEEN NICE
	; TO ADD A COMMENT HERE SAYING THAT!?!?!

	; setting a flag to indicate mario is standing on the platform.
	LDA #$01
	STA !Address_Table_Mario_Standing_Flag,x

	LDA !sprite_y_low,x
	SEC
	SBC $1C
	STA $00
	LDA $80
	CLC
	ADC #$18
	CMP $00
	BPL not_contact
	LDA $7D
	BMI not_contact
	LDA $77
	AND #$08
	BNE not_contact
	LDA #$10
	STA $7D
	LDA #$01
	STA $1471|!Base2
	LDA #$21
	LDY $187A|!Base2
	BEQ +
	LDA #$31
+
	CLC
	ADC #$04
	STA $01
	LDA !sprite_y_low,x
	SEC
	SBC $01
	STA $96
	LDA !sprite_y_high,x
	SBC #$00
	STA $97
	LDA $77
	AND #$03
	BNE ++
	LDY #$00
	LDA !1528,x
	BPL +
	DEY
+
	CLC
	ADC $94
	STA $94
	TYA
	ADC $95
	STA $95
++
	SEC
	RTS
not_contact:


	; here mario is not in contact with the platform.
	; this could mario _just_ jumped off of it. so we can set some speed values here.
	LDA !Address_Table_Mario_Standing_Flag,x
	CMP #$00
	BEQ .dontdospeedstuff

	; check to see if we jumped as well.  we don't want to do anything if mario just walked off.
	LDA !Address_Buttons_B
	AND #$80
	CMP #$80
	BNE .afterbbuttoncheck

	; do the speed actions
	BRA .dothespeedthing

.afterbbuttoncheck

	LDA !Address_Buttons_A
	AND #$80
	CMP #$80
	BNE .afterabuttoncheck

	; do the speed actions
	BRA .dothespeedthing

.afterabuttoncheck
	
	; THE SPEEDS, THEY DO NOTHING D:
	BRA .dontdospeedstuff

.dothespeedthing

	; so here mario WAS on the platform and is not anymore.

	; now send the speed of the platform over to the player.
	LDA !line_speed,x
	; store it
	PHA
	LDA !direction,x
	BEQ .noflip
	; here we flip the x-direction
	PLA
	EOR #$FF
	BRA .speedset
.noflip
	; just load in the speed
	PLA

.speedset
	STA !Address_Player_X_Speed
	; LDA !Address_Table_Sprite_Y_Speed,x
	; STA !Address_Player_Y_Speed

	; shazam

.dontdospeedstuff

	; reset our flag
	STZ !Address_Table_Mario_Standing_Flag,x

	CLC
	RTS
	