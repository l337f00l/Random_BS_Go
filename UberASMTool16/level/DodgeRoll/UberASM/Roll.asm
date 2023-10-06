;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Dodge Roll - by dtothefourth
;
; Gives Mario a roll ability with invincibility frames
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


!RollSpeed = $2E ;Target X speed during roll
!RollLength = 4  ;How long the roll lasts, 1-6 (3-4 recommended)

!AllowMidair = 1   ;If 0 can't roll unless on the ground
!Cooldown    = $10 ;Frames after finishing a roll before can start another

!Flicker = 1	   ;If 1 use invulnerability flicker like after getting hurt

!PlaySound = 0	   ;If 1 play a sound when rolling
!RollSound = $0F
!SoundBank = $1DF9|!addr

!UseStamina  = 0	;If 1 use a stamina meter to limit rolling
!MaxStamina  = $30  ;How much stamina full meter is
!RollCost    = $10  ;Stamina usage per roll
!RecoverTime = $40  ;How long after roll stamina starts refilling
!RecoverRate = $03  ;How quickly stamina recovers, higher number = slower (Use 0,1,3,7,F,1F)

;Tiles to use for stamina meter, for each fill state from 0-8
Top:
	db $80, $80, $80, $80, $80, $81, $82, $83, $84
Bottom:
	db $90, $91, $92, $93, $94, $94, $94, $94, $94
Props:
	db $35, $35, $35, $35, $35, $35, $35, $35, $35

;FreeRAM
!RollDir  = $7FB600
!RollTime = $7FB601
!RollCool = $7FB602
!Stamina  = $7FB603
!Draining = $7FB604
!Recover  = $7FB605
;These 3 must match AdjustMarioGFX.asm
!Flip    = $7C
!XOffset = $1869|!addr
!YOffset = $186A|!addr





if !RollLength = 1
	!RollFrames = 8
elseif !RollLength = 2
	!RollFrames = 16
elseif !RollLength = 3
	!RollFrames = 24
elseif !RollLength = 4
	!RollFrames = 32
elseif !RollLength = 5
	!RollFrames = 48
elseif !RollLength = 6
	!RollFrames = 64
endif


XSpeed:
	db $100-!RollSpeed,!RollSpeed

Poses:
	db $06, $0C, $12, $10, $06, $0C, $12, $10
XFlip:
	db $00, $00, $01, $01, $01, $01, $00, $00
YFlip:
	db $00, $00, $01, $01, $01, $01, $00, $00

XOff:
	db $00, $04, $FA, $FB, $02, $FE, $08, $08
YOff:
	db $00, $01, $19, $12, $0E, $0C, $F8, $FD

XOffBig:
	db $00, $02, $F6, $F8, $01, $FE, $0C, $0B
YOffBig:
	db $00, $01, $17, $0C, $04, $04, $F6, $FD

macro nexttile()
	?loop:
	LDA $0201|!addr,y
	CMP #$F0
	BEQ ?end
	INY #$4
	CPY #$00
	BNE ?loop
	RTS
	?end:
endmacro




init:
	LDA #$00
	STA !RollDir
	STA !RollTime
	STA !RollCool
	if !UseStamina
	STA !Draining
	STA !Recover
	LDA #!MaxStamina
	STA !Stamina
	endif
	RTL

main:


	LDA $71
	BEQ +

	LDA #$00
	STA !XOffset
	STA !YOffset
	RTL
	+

	LDA $9D
	ORA $13D4|!addr
	BEQ +
	RTL
	+

	if !UseStamina
	LDA !Stamina
	CMP #!MaxStamina
	BEQ +
	JSR DrawMeter
	+

	LDA !Draining
	BEQ ++
	DEC
	STA !Draining
	LDA !Stamina
	BEQ +
	DEC
	STA !Stamina
	BRA +
	++
	LDA !Stamina
	CMP #!MaxStamina
	BEQ +

	LDA !Recover
	BEQ ++
	DEC
	STA !Recover
	BRA +
	++
	LDA $14
	AND #!RecoverRate
	BNE +
	LDA !Stamina
	INC
	STA !Stamina
	+
	endif

	LDA !RollTime
	BNE DoRoll

	LDA !RollCool
	BEQ ++
	DEC
	STA !RollCool
	BRA +
	++

	LDA $1470|!addr
	ORA $148F|!addr
	ORA $187A|!addr
	ORA $74
	ORA $75
	if !AllowMidair = 0
	ORA $72
	endif
	ORA $140D|!addr
	ORA $14A6|!addr
	BNE +

	LDA $18
	AND #$30
	BEQ +

	if !UseStamina
	LDA !Stamina
	SEC
	SBC !Draining
	CMP #!RollCost
	BCC +

	STA !Stamina
	LDA #!RollCost
	STA !Draining

	LDA #!RollFrames
	STA !Recover
	endif

	if !PlaySound
	LDA #!RollSound
	STA !SoundBank
	endif

	LDA #!RollFrames
	STA !RollTime
	LDX #!sprite_slots-1
	-
	STA !154C,x
	DEX
	BPL -
	CLC
	LDA #$01
	STA $1497|!addr

	LDA $76
	STA !RollDir

	+

	RTL

DoRoll:
	DEC
	STA !RollTime
	BNE +
	LDA #!Cooldown
	STA !RollCool
	if !UseStamina
	LDA #!RecoverTime
	STA !Recover
	endif
	LDA #$00
	+
	EOR #$FF
	INC
	CLC
	ADC #!RollFrames

	if !RollLength = 2
	LSR
	elseif !RollLength = 3
	JSR Div3
	elseif !RollLength = 4
	LSR #2
	elseif !RollLength = 5
	JSR Div3
	elseif !RollLength = 6
	LSR #2
	endif
	AND #$07
	TAX
	LDA Poses,X

	STA $72
	STA $13E0|!addr

	if !Flicker
	LDA $14
	AND #$01
	INC
	else
	LDA #$01
	endif
	STA $1497|!addr


	LDA !RollDir
	EOR XFlip,X
	STA $76

	LDA YFlip,x
	STA !Flip

	LDA $19
	BNE +++
	LDA !RollDir
	BEQ +
	LDA XOff,x
	BRA ++
	+
	LDA XOff,x
	EOR #$FF
	INC
	++
	STA !XOffset
	

	LDA YOff,x
	STA !YOffset	
	JMP Finish

	+++
	LDA !RollDir
	BEQ +
	LDA XOffBig,x
	BRA ++
	+
	LDA XOffBig,x
	EOR #$FF
	INC
	++
	STA !XOffset
	

	LDA YOffBig,x
	STA !YOffset	

Finish:

	LDA !RollDir
	BNE +
	
	LDA $15
	AND #$BE
	ORA #$02
	STA $15

	LDA $7B
	BPL ++

	CMP XSpeed
	BCC +++

	-
	++
	DEC
	DEC
	STA $7B 
	
	RTL
	+
	LDA $15
	AND #$BD
	ORA #$01
	STA $15

	LDA $7B
	BMI +++

	CMP XSpeed+1
	BCS -

	+++
	INC
	INC
	STA $7B 
	
	RTL

Div3:
	REP #$20
	AND #$00FF
	STA $00
	ASL #2
	CLC
	ADC $00
	STA $00
	ASL #4
	CLC
	ADC $00
	CLC
	ADC #$0030
	SEP #$20
	XBA
	RTS


DrawMeter:

	LDA #!MaxStamina
	BEQ -
	LSR #3
	STA $00
	STZ $01
	STZ $02

	REP #$20
	LDA $7E
	BMI -
	CMP #$0100
	BCS -

	CMP #$0018
	BCS ++
	SEP #$20
	LDA #$02
	STA $02
	BRA +++
	++
	CMP #$00E8
	BCC +++
	SEP #$20
	LDA #$01
	STA $02
	+++

	REP #$20
	LDA $80
	BMI -
	CMP #$00F0
	BCS -
	SEP #$20

	LDA $02
	BNE ++

	LDA $140D|!addr
	BEQ +++

	LDA $7B
	BMI ++++
	LDA #$02
	STA $02
	BRA ++
	++++
	LDA #$01
	STA $02
	BRA ++

	+++
	LDA $76
	INC
	STA $02

	++

	LDY #$30


	LDA !Stamina
	-
	SEC
	SBC $00
	BMI ++
	INC $01
	BRA -

	++


	LDA $01
	TAX

	%nexttile()

	LDA $02
	CMP #$01
	BNE ++

	LDA $7E
	CLC
	ADC #$12
	BRA +++
	++
	LDA $7E
	SEC
	SBC #$0A
	+++
	STA $0200|!addr,Y

	LDA $80
	CLC
	ADC #$08
	STA $0201|!addr,Y

	LDA.L Top,X
	STA $0202|!addr,Y
 
	LDA.L Props,X
	STA $0203|!addr,Y

	%nexttile()

	LDA $01FC|!addr,Y
	STA $0200|!addr,Y

	LDA $80
	CLC
	ADC #$10
	STA $0201|!addr,Y

	LDA.L Bottom,X
	STA $0202|!addr,Y
 
	LDA.L Props,X
	STA $0203|!addr,Y	


	+
	SEP #$20

	RTS

	