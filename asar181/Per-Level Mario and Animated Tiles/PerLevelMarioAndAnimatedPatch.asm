lorom
!sa1 = 0
!addr = $0000
!bank = $800000

if read1($00FFD5) == $23
	sa1rom
	!sa1 = 1
	!addr = $6000
	!bank = $000000
endif

;========================
; DEFINES
;========================

!FreeRAM = $010B|!addr
!PreviousGFX = $0DC3|!addr

;========================
; HIJACKS
;========================

org $009476
autoclean JSL Label3
NOP

;org $00A0B9
;STZ $0DDA : LDX $0DB3 ; Remove the semi-colon if you applied an earlier version of this patch

org $00A0BF
autoclean JML Label5

org $00A5D5
autoclean JSL Label2
NOP

;==========================
; FROM LEVELASM, NOT BY ME
;==========================

ORG $05D8B7
BRA +
NOP #3;the levelnum patch goes here in many ROMs, just skip over it
+
REP #$30
	LDA $0E		
	STA !FreeRAM
	ASL		
	CLC		
	ADC $0E		
	TAY		
	LDA.w $E000,Y
	STA $65		
	LDA.w $E001,Y
	STA $66		
	LDA.w $E600,Y
	STA $68		
	LDA.w $E601,Y
	STA $69		
	BRA +
ORG $05D8E0
	+

;-----------------------
; CUSTOM CODE
;-----------------------

freecode

Label2:
PHK                        ; \ Because of a hijack, we need...
PEA.w .ReturnAZ-$01          ;  | ... to jump to a routine, ending in RTS...
PHB                        ;  | ... this way.
LDA #$00                   ;  |
PHA                        ;  |
PLB			   ;  |
PEA $84CD		   ;  |
JML $008E1A|!bank  ; /

.ReturnAZ:
PHB                        ; \ Preserve bank.
PHK                        ;  | PBR into DBR.
PLB                        ; /
LDA #$00
STA $00
LDA #$20
STA $01
LDA #$7E
STA $02
REP #$30                   ; 
LDA !FreeRAM               ; \ Level num * 2
ASL A                      ;  |
TAY                        ; / Into index
LDA.w MarGFX,y      ; \ Get GFX file num.
if !PreviousGFX
CMP !PreviousGFX
BEQ .ReturnBnk
STA !PreviousGFX
endif
CMP #$0032
BEQ .NoLoad
JSL $0FF900|!bank
BRA .Return+1

.NoLoad:
PHP
SEP #$20
PHK
PEA.w .Return-1
PHB
LDA #$00
PHA
PLB
PEA $84CD
JML $00B888|!bank

.Return:
PLP

if !sa1
; MFG:
; Okay, I have no other choice (that is: I have but they all are more complicated) but to clear the
; sprite load state afterwards. The problem is that both, the player and animation graphics take up
; in total 0x8D00 but SA-1 pack only reserves 0x8000 bytes in total (0x8800 if I add the buffer for
; dynamic sprites which still leaves me 0x500 bytes short, arg!). Now to the problem: The sprite
; load state (which keeps track which sprite has been killed) is part in that overshoot area!
; This isn't as much of a problem when Mario's graphics are only decompressed during the Nintendo Presents
; (after all, it not only appears once but also because the Nintendo Presents doesn't contain any level
; data and the title screen loads after the Nintendo Presents which also clears the sprite load data)
; but it surely is with this patch applied.
; A quick but (IMO) dirty fix is to clear $8A00 to including $8AFE.
; A side effect: All of BW-RAM from $418AFF to $418CFF cannot be used a freeRAM unless they don't carry
; information between overworld and levels (or at least if the sublevels don't change these graphics if
; the graphic numbers are remembered). Just treat it as one of the freeRAM which is cleared at level load.
;
; I know it likely breaks lots of stuff but let's be honest: Decompression is dumb, period.
; And yes, I spend 20 minutes writing this wall of text but let's be honest: Worth it!
SEP #$10
LDX #$41
PHX
REP #$10
PLB
LDX.w #$8AFE-$8A00
.ClearLoop
STZ $8A00,x
DEX
DEX
BPL .ClearLoop
REP #$10
endif

.ReturnBnk:
PLB
RTL

;----------------------------------;
; Mario GFX and Animated Tiles GFX ;
;----------------------------------;

MarGFX:
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 0-F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 10-1F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 20-2F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 30-3F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 40-4F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 50-5F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 60-6F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 70-7F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 80-8F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 90-9F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels A0-AF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels B0-BF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels C0-CF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels D0-DF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels E0-EF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels F0-FF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 100-10F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 110-11F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 120-12F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 130-13F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 140-14F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 150-15F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 160-16F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 170-17F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 180-18F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 190-19F
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 1A0-1AF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 1B0-1BF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 1C0-1CF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 1D0-1DF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 1E0-1EF
dw $0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 1F0-1FF

;-----------;
; Credits   ;
;-----------;

Label3:
STA $1931|!addr
CPX #$08
BNE .Label
PHK
PER .Label4-1
PHB
LDA #$00
PHA
PLB
PEA $84CD
JML $00B888|!bank

.Label4:
LDX $13C6|!addr
.Label:
LDA #$14
RTL

;-----;
; OW  ;
;-----;

Label5:
PHX
PHK
PER .Label-1
PHB
LDA #$00
PHA
PLB
PEA $84CD
JML $00B888|!bank

.Label:
PLX
LDA $0DBE|!addr
BPL .CODE_00A0C7
JML $00A0C4|!bank

.CODE_00A0C7:
JML $00A0C7|!bank

print freespaceuse