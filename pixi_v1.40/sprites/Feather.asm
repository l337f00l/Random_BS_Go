;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Feather disassembly
;
;This is a disassembly of sprites 77 in SMW - Feather
;
;By RussianMan. Credit is optional.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Extra Byte 1 - YES
;1 - it'll ignore original init, and thus will start moving no matter blocked or not.
;2 - it'll initially start rising (as if it was rising out of block)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Sound Effects:
;check https://www.smwcentral.net/?p=viewthread&t=6665 for more info on sound effects and banks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!ItemBoxSound = $0B		;sound that is supposed to play when you pick it in your item box
!ItemBoxBank = $1DFC		;

!ItemBoxSound2 = $0A		;second sound effect that plays when taking it in item box, instead of !PickPowerup sound effect.
!ItemBoxBank2 = $1DF9		;

!PickPowerupSound = $0D		;sound effect that always plays
!PickPowerupBank = $1DF9	;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Speed Defines:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HorizAccel:			;how fast it gets speed
db $02,$FE

MaxXSpeed:			;Max X speed
db $20,$E0

YSpeed:				;Y-speed - $06
db $0A,$F6,$08

!InitialY = $D0			;Y-speed when extra byte is set to 2 - raise out of block

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Score:
;00 = 100
;01 = 200
;02 = 400
;03 = 800
;04 = 1000
;05 = 2000
;06 = 4000
;07 = 8000
;08 = 1up
;09 = 2up
;0A = 3up
;0B = 5up (may glitch)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!FeatherScore = $04

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;GFX-Related:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!FeatherTile = $0E

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Other:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ItemBox:            		;item box contents for each player powerup
db $00,$01,$04,$02

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Initial checks and settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Print "INIT ",pc
LDA !extra_byte_1,x		;on extra byte set ignore original init
DEC				;
BEQ Raise			;
DEC				;
BEQ NoInit			;

INC !C2,x			;

NoInit:
RTL				;

Raise:
LDA #$2C			;slowdown timer
STA !154C,x			;

LDA #!InitialY			;Y-speed
STA !AA,x			;
RTL				;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Main Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Print "MAIN ",pc
PHB
PHK
PLB
JSR Feather
PLB
RTL

;Unlike other power-ups this one is mostly it's own thing.

Feather:
LDA $9D				;9D means
BNE .BeforeGFX2			;GFX only (and interaction?)

JSL $01801A|!BankB		;to not have 2 of this (Y gravity)

LDA !C2,x			;
BEQ .Move			;don't move when not supposed to

JSL $019138|!BankB		;if it's stationary, interact with objects.
LDA !1588,x			;if blocked from anywhere
BNE .NoReset			;reset C2 (though if you put it inside solid block, it WILL move, unlike star or mushrooms, and like fire flower)

STZ !C2,x			;reset movement flag

.NoReset
BRA .BeforeGFX			;

.Move
;LDA !14C8,x			;
;CMP #$0C			;
;BEQ .BeforeGFX2		;

LDA !154C,x			;
BEQ .NoMoveUp			;

;JSL $01801A|!BankB		;1

INC !AA,x			;when hit out of block, it moves upward a bit

.GFX
JMP .BeforeGFX			;

.NoMoveUp
LDA !1528,x			;this is direction
AND #$01			;
TAY				;
LDA !B6,x			;speed's based on "direction"
CLC : ADC HorizAccel,y		;accelerate
STA !B6,x			;
CMP MaxXSpeed,y			;if hit max speed
BNE .NoINC			;

INC !1528,x			;change direction

.NoINC
LDA !B6,x			;
BPL .NoINY			;
INY				;Smooth Y speed based on X-speed

.NoINY
LDA YSpeed,y			;
CLC : ADC #$06			;this sets Y speed
STA !AA,x			;

LDA #$00			;handle offscreen
%SubOffScreen()			;

JSL $018022|!BankB		;update position based on X-speed
;JSL $01801A|!BankB		;2

.BeforeGFX

JSR DetermieDirection		;based on speed

.BeforeGFX2
JSR .Interact			;run interaction
;JMP FinallyGFX			;hehe, we can just put GFX routine here.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;GFX Routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;FinallyGFX:
%GetDrawInfo()			;

;LDA $140F|!Base2		;I don't think this is usefull for regular user
;BNE .NotMode7			;I don't think you normally would put this sprite in Mode 7 rooms.
;LDA $0D9B|!Base2		;but if you know this IS going to be usefull (for some reason), uncomment these
;CMP #$C1			;those checks if sprite's in any mode 7 room.
;BEQ .NotMove7			;
;BIT $0D9B|!Base2		;
;BVC .NotMode7

;LDA #$D8			;set specific OAM slot for power-up
;STA !15EA,x			;
;TAY

.NotMode7
LDA $00				;
STA $0300|!Base2,y		;Sprite tile's X position

LDA $01				;
DEC				;Sprite tile's Y position - 1, so it looks better on ground
STA $0301|!Base2,y		;

LDA !157C,x			;
LSR				;
LDA #$00			;
BCS .NoFlip			;
ORA #$40			;

.NoFlip
ORA $64				;
ORA !15F6,x			;
STA $0303|!Base2,y		;

LDA #!FeatherTile		;Feather Tile
STA $0302|!Base2,y		;

LDY #$02			;
LDA #$00			;
JSL $01B7B3|!BankB		;
RTS				;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Handle Interaction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.Interact
JSR Interaction			;
BCC Return			;

LDA !154C,x			;if it can't interact
BNE Return			;don't

;LDA !1540,x			;we already have 154C
;CMP #$18			;
;BCS Return			;

STZ !14C8,x			;sprite begone

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Feather Interaction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LDY $19             		;if mario's small
BEQ .GivePower			;just give power

LDA ItemBox,y			;otherwise do item box shenanigans also
STA $0DC2|!Base2		;store itembox's item

LDA #!ItemBoxSound		;sound effect #1
STA !ItemBoxBank|!Base2		;

LDA #!ItemBoxSound2		;sound effect #2
STA !ItemBoxBank2|!Base2	;

.GivePower
LDA #$02			;mario status = cape
STA $19				;

LDA #!FeatherScore		;
JSL $02ACE5|!BankB		;

CPY #$02			;no smoke animation if already caped
BEQ Return			;

LDA #!PickPowerupSound		;sound effect when turning into cape mario.
STA !PickPowerupBank|!Base2	;

;JSL .PuffyAnimation		;JSL to 01C5AE. Why JSL? Maybe something else's using it? I dunno.

.PuffyAnimation
LDA #$03			;as you may know if you get feather in autoscroll area while offscreen, game freezes. I've fixed that for this sprite
STA $71				;animation

LDA #$18			;animation timer
STA $1496|!Base2		;

LDA $81				;If Mario's off screen
ORA $7F				;
BNE Return			;don't do anything

LDY #$03			;load all avaiable smoke sprite slots

Loop:
LDA $17C0|!Base2		;go through all sprite slots
BEQ .Spawn			;
DEY : BPL Loop			;loop untill we find empty one

DEC $1863|!Base2		;otherwise replace existing one?
BPL .Use1863

LDA #$03			;
STA $1863|!Base2		;

.Use1863
LDY $1863|!Base2		;

.Spawn
LDA #$81			;Smoke sprite number is... 81? Well, that works.
STA $17C0|!Base2,y		;

LDA #$1B			;timer for it's life to live
STA $17CC|!Base2,y		;

LDA $96				;Y position to Mario's + 8 pixels up
CLC : ADC #$08			;
STA $17C4|!Base2,y		;

LDA $94				;X position to Mario's
STA $17C8|!Base2,y		;

INC $9D				;set 9D

Return:
RTS				;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Subroutines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Interaction:
PHK				;btw my forth time using this jump method
PEA.w .Re-1			;I hope it doesn't sucks still
PEA.w $0180CA|!BankB-1		;
JML $01A80F|!BankB		;

.Re
RTS				;

DetermieDirection:
LDA #$00			;
LDY !B6,x			;
BEQ .Re2			;if no X speed, don't change direction
BPL .StoreDir			;if it's left speed, direcion = left
INC A				;otherwise direction = right

.StoreDir
STA !157C,x			;

.Re2
RTS				;