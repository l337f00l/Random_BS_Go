;YI pswitch
;by smkdan

;this reqiores dsx.asm in the patch directory to be applied to your ROM

;GRAPHICS ARE IN YIPSWITCH.bIN
;IT MUST BE IN THE SAME DIRECTORY AS THIS ASM FILE

;USES EXTRA BIT!
;If set, it activates the silver pow timer rather than the blue pow timer

;Extra Property 1:
;liftoff Y speed for Mario when he jumps on the switch.  00-7F.

;a large red pswitch that has a fixed position

prot GFX

!PROPRAM = $04

	!Temp = $09
	!Timers = $0B

	!SlotPointer = $0660|!Base2			;16bit pointer for source GFX
	!SlotBank = $0662|!Base2			;bank
	!SlotDestination = $0663|!Base2			;VRAM address
	!SlotsUsed = $06FE|!Base2			;how many slots have been used

	!MAXSLOTS = $04			;maximum selected slots

;CODE_01AAFD:        A9 0B         LDA.b #$0B                
;CODE_01AAFF:        8D F9 1D      STA.w $1DF9               ; / Play sound effect
;CODE_01AB07:        A9 0E         LDA.b #$0E
;CODE_01AB09:        8D FB 1D      STA.w $1DFB               ; / Change music            
;CODE_01AB1A:        A9 B0         LDA.b #$B0                
;CODE_01AB1C:        99 AD 14      STA.w RAM_BluePowTimer,Y  
;CODE_01AB1F:        A9 20         LDA.b #$20                ; \ Set ground shake timer 
;CODE_01AB21:        8D 87 18      STA.w RAM_ShakeGrndTimer  ; / 

;1570: stepped status
;1602: SQUISH index

YMARIO:	dw $0000,$0000,$0000,$0001,$0001,$0001,$0001,$0001,$0001,$0001,$0001,$0001,$0001,$0001,$0000,$0000
	dw $0000,$FFFF,$FFFE,$FFFE,$FFFD,$FFFD,$FFFC,$FFFC

PRINT "INIT ",pc	
	RTL

PRINT "MAIN ",pc
	PHB
	PHK
	PLB
	JSR Run
	PLB
	RTL

;$14 bit 7 set when spinning

RETURN_L:
	RTS

Run:
	LDA #$00 : %SubOffScreen()
	JSR GFXRoutine		;draw sprite

	LDA !14C8,x
	CMP #$08          	 
	BNE RETURN_L           
	LDA $9D			;locked sprites?
	BNE RETURN_L
	LDA !15D0,x		;yoshi eating?
	BNE RETURN_L

	LDA !1570,x		;check SQUISH status
	BNE SQUISH
	JMP NOSQUISH		;jump to nosqush

SQUISH:
	LDA !1602,x		;load SQUISH index
	ASL A			;2 bytes per entry
	TAY			;into Y
	REP #$20		;16bit math
	LDA YMARIO,y		;load disp
	CLC
	ADC $96			;add to mario y
	STA $96			;and store
	SEP #$20		;8bit A

	STZ $7D			;no yspd
	STZ $7B			;or xspd
	INC !1602,x		;advance SQUISH index
	LDA !1602,x
	CMP #$18		;total count reached?
	BNE SQUISHMORE

;squishing complete, go out with bang and erase sprite

	LDA !7FAB28,x		;liftoff Y speed from extra prop 1
	EOR #$FF		;two's complement
	INC A
	STA $7D

	LDA #$0B		;SFX
	STA $1DF9|!Base2
	LDA #$0E
	STA $1DFB|!Base2	;music
	LDA #$20
	STA $1887|!Base2	;ground
;	LDA #$B0
	
	LDA !7FAB10,x		;check extrabit
	AND #$04		;silver pow timer if bit is set
	BEQ BLUEPOW

;silver power
	LDA #$B0		;silver pow timer
	STA $14AE|!Base2
	JSL $02B9BD|!BankB	;>  LMPUNY EDIT: This makes every sprite on screen change to
				;   silver coins. The original switch didn't.
	BRA VISUALS		;skip setting blue
	
BLUEPOW:
	LDA #$B0		;blue pow timer
	STA $14AD|!Base2
	;LDA #$EF
	;STZ $01

VISUALS:
	LDA !D8,x		;adjust position for stars
	CLC
	ADC #$0C		;add 12
	STA !D8,x
	LDA !14D4,x
	ADC #$00		;carry
	STA !14D4,x

	LDA !E4,x		;xpos
	CLC
	ADC #$02		;adjustment
	STA !E4,x
	LDA !14E0,x		;carry
	ADC #$00
	STA !14E0,x
	JSL $07FC3B|!BankB	;stars

;	LDA !D8,x		;positions for smoke
;	STA $01			;01 = ypos of smoke
;	LDA !E4,x
;	SEC
;	SBC #$08		;4px to left (4px was done by stars)
;	STA $00			;00 = x pos of smoke

	STZ $01
	LDA #$FC
	STA $00
	LDA #$10
	STA $02
	LDA #$01
	%SpawnSmoke()

;	LDA $00			;16px to the right
;	CLC
;	ADC #$10
;	STA $00			;new xpos

	LDA #$0C
	STA $00
	LDA #$01
	%SpawnSmoke()

	STZ !14C8,x		;erase
	
	STZ !1570,x		;then zero SQUISH status
	STZ !1602,x		;zero SQUISH index

SQUISHMORE:
	CMP #$10		;time to turn yellow yet?
	BNE KEEPPAL

;change palette
	LDA !15F6,x		;load palette etc.
	AND #$F1		;mask palette
	ORA #$04		;yellow palette now
	STA !15F6,x		;new palette

KEEPPAL:
	BRA RETURN		;just RETURN
		
NOSQUISH:
	JSL $01802A|!BankB	;speed

;contact routine
	JSL $01A7DC|!BankB	;mario
	BCC RETURN		;RETURN on no contact

	LDA $0E			;difference between ypos
	CMP #$F0
	BPL CHECKSIDES		;CHECKSIDES if too low

	LDA $0F			;sub spr x from Mario x
	CMP #$02		;too much on right?
	BMI RETURN

	CMP #$1C		;too much on left?
	BPL RETURN

	LDA $7D			;RETURN on rising mario speed
	BMI RETURN

;now Mario is ontop, set to SQUISH and activate
	LDA #$01		;set 'riding sprite'
	STA $1471|!Base2
	LDA #$06		;"set riding megamole"
	STA !154C,x

	LDA #$EE		;displacement without Yoshi, must be within clipping field, -2 from range check
	LDY $187A|!Base2	;load yoshi flag
	BEQ NOYOSHI
	LDA #$DE		;displacement with Yoshi, -12
NOYOSHI:
	CLC
	ADC !D8,x		;add spritey
	STA $96			;store marioY
	LDA !14D4,x
	ADC #$FF
	STA $97	

	LDA #$01		;set stepped status
	STA !1570,x

RETURN:
	RTS

CHECKSIDES:
	%SubHorzPos()		;different clipping depending on what side mario is on.
	BEQ ONRIGHT

;onleft
	LDA $0E			;xdifference
	CMP #$F3		;allow a bit of entrance from the left.  same amount as on the right
	BMI RETURN

	BIT $7B			;only allow left speed
	BMI RETURN
	STZ $7B
	BRA RETURN
ONRIGHT:
	BIT $7B			;only allow right speed
	BPL RETURN
	STZ $7B

	BRA RETURN		;RETURN
		
;=====

FRAMES:	db $00,$02,$03,$10
	db $11,$12,$13,$20
	db $21,$22,$23,$30
	db $31,$32,$33,$33
	db $33,$33,$31,$23
	db $21,$11,$02,$00

XDISP:	db $00,$10,$00,$10
YDISP:	db $00,$00,$10,$10
TILEMAP:
	db $00,$02,$20,$22	;test map

EORS:	db $0F,$00

GFXRoutine:
	%GetDrawInfo()
	PHY
	LDY !1602,x	;SQUISH index
	LDA FRAMES,y	;SQUISH index = frame index
	PLY
	
	JSR GETSLOT	;A = frame
	BEQ RETURNG	;RETURN without drawing if returned tile # is zero
	STA !Temp	;store to !TEMP

	LDA !15F6,x	;properties...
	STA !PROPRAM

NOFLIPMIRROR:
	LDX #$00	;zero index

OAM_LOOP:
	LDA $00
	CLC
	ADC XDISP,x
	STA $0300|!Base2,y

	LDA $01
	CLC
	ADC YDISP,x
	STA $0301|!Base2,y

	LDA TILEMAP,x
	CLC
	ADC !Temp	;add calculated tile
	STA $0302|!Base2,y

	LDA !PROPRAM
	ORA $64
	STA $0303|!Base2,y

	INY #4
	INX
	CPX #$04
	BNE OAM_LOOP

	LDX $15E9|!Base2	;restore sprite index 

        LDY #$02
        LDA #$03               ;4 tiles
        JSL $01B7B3|!BankB

	RTS
RETURNG:
	LDX $15E9|!Base2	;restore sprite index 
	RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Dynamic sprite routine
; Programmed mainly by SMKDan
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GETSLOT:
	PHY		;preserve OAM index
	PHA		;preserve frame
	LDA !SlotsUsed	;test if slotsused == maximum allowed
	CMP #!MAXSLOTS
	BNE +
		
	PLA
	PLY
	LDA #$00	;zero on no free slots
	RTS

+	PLA		;pop frame
	REP #$20	;16bit A
	AND.w #$00FF	;wipe high
	XBA		;<< 8
	LSR A		;>> 1 = << 7
	STA !Temp	;back to scratch
	LDA.w #GFX	;Get 16bit address
	CLC
	ADC !Temp	;add frame offset	
	STA !SlotPointer	;store to pointer to be used at transfer time
	SEP #$20	;8bit store
	PHB : PLA
	STA !SlotBank	;store bank to 24bit pointer

	PHX		;This is how I made your boi a routine
	LDX !SlotsUsed		;calculate VRAM address + tile number
	LDA.L SlotsTable,X	;get tile# in VRAM
	PLX
	PHA		;preserve for eventual pull
	SEC
	SBC #$C0	;starts at C0h, they start at C0 in tilemap
	REP #$20	;16bit math
	AND.w #$00FF	;wipe high byte
	ASL A		;multiply by 32, since 32 bytes/16 words equates to 1 32bytes tile
	ASL A
	ASL A
	ASL A
	ASL A
if !SA1 == 1
	CLC : ADC #$8000	;add 8000, base address of buffer
else
	CLC : ADC #$0B44	;add 0B44, base address of buffer	
endif
	STA !SlotDestination	;destination address in the buffer
	SEP #$20
	STZ !Timers

;;;;;;;;;;;;;;;;
;Tansfer routine
;;;;;;;;;;;;;;;;

;DMA ROM -> RAM ROUTINE

if !SA1 == 1
;set destination RAM address
	REP #$20
	LDY #$C4
	STY $2230
	LDA.w !SlotDestination
	STA $2235	;16bit RAM dest
	        
	         	;set 7F as bank

;common DMA settings
	         	;1 reg only
	        	;to 2180, RAM write/read
	         

;first line
	LDA !SlotPointer
	STA $2232	;low 16bits
	LDY !SlotBank
	STY $2234	;bank
	LDY #$80	;128 bytes
	STZ $2238
	STY $2238
	LDY #$41
	STY $2237
	
	LDY $318C
	BEQ $FB
	LDY #$00
	STY $318C
	STY $2230	;transfer

;lines afterwards
-	LDY #$C4
	STY $2230
	LDA.w !SlotDestination	;update buffer dest
	CLC
	ADC #$0200	;512 byte rule for sprites
	STA !SlotDestination	;updated base
	STA $2235	;updated RAM address

	LDA !SlotPointer	;update source address
	CLC
	ADC #$0200	;512 bytes, next row
	STA !SlotPointer
	STA $2232	;low 16bits
	LDY !SlotBank
	STY $2234	;bank
	LDY #$80
	STZ $2238
	STY $2238
	LDY #$41
	STY $2237
	
	LDY $318C
	BEQ $FB
	LDY #$00
	STY $318C
	STY $2230	;transfer
	LDY !Timers
	CPY #$02
	BEQ +
	INC !Timers
	BRA -
+
else
;common DMA settings
	REP #$20
	STZ $4300	;1 reg only
	LDY #$80	;to 2180, RAM write/read
	STY $4301
	
;set destination RAM address
	LDA !SlotDestination
	STA $2181	;16bit RAM dest
	LDY #$7F
	STY $2183	;set 7F as bank

	LDA !SlotPointer
	STA $4302	;low 16bits
	LDY !SlotBank
	STY $4304	;bank
	LDY #$80	;128 bytes
	STY $4305
	LDY #$01
	STY $420B	;transfer

;second line
-	LDA !SlotDestination	;update buffer dest
	CLC
	ADC #$0200	;512 byte rule for sprites
	STA !SlotDestination	;updated base
	STA $2181	;updated RAM address

	LDA !SlotPointer	;update source address
	CLC
	ADC #$0200	;512 bytes, next row
	STA !SlotPointer
	STA $4302	;low 16bits
	LDY !SlotBank
	STY $4304	;bank
	LDY #$80
	STY $4305
	LDY #$01
	STY $420B	;transfer
	LDY !Timers
	CPY #$02
	BEQ +
	INC !Timers
	BRA -
+
endif
	
	SEP #$20	;8bit A	
	INC !SlotsUsed	;one extra slot has been used

	PLA		;return starting tile number
	PLY
	RTS

SlotsTable:			;avaliable slots.  Any more transfers and it's overflowing by a dangerous amount.
	db $CC,$C8,$C4,$C0	

GFX:
incbin yipswitch.bin