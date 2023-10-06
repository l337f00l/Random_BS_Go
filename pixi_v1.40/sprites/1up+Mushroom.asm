;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Mushoom + 1-Up disassembly
;
;This is a disassembly of sprites 74 and 78 in SMW - Mushroom and 1-Up
;
;By RussianMan. Credit is optional.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Extra Byte 1 - YES
;1  - It'll initially blink-fall
;2  - it'll initially start rising (as if it was rising out of block)
;3+ - It'll initially start moving no matter if it was initially on ground.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Extra Property Byte 1 - YES
;If 0 it'll act like sprite 74 Mushroom
;If Set to anything else it'll act like mushroom
;(and why I didn't use extra bit is because of necessary stuff needed in CFG files to make this work)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Defines and options

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Sound Effects:
;check https://www.smwcentral.net/?p=viewthread&t=6665 for more info on sound effects and banks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!ItemBoxSound = $0B		;sound that is supposed to play when you pick it in your item box
!ItemBoxBank = $1DFC		;

!PickPowerupSound = $0A		;sound effect that always plays
!PickPowerupBank = $1DF9	;

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

!Score1UP = $08

!ScoreMushroom = $04

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Speed Defines:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!BlinkFallSpeed = $10		;Y-Speed for dropped power-up

!RisingSpeed = $FC		;Y-Speed for "rising out of ?-block"

!RightXSpeed = $00		;X-speed for right
!LeftXSpeed = $80		;and left directions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;GFX-Related:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!MushroomTile = $24

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Misc Options:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!MushroomPriorityFix = 0	;this fixes mushroom priority, like Alcaro's "Item Box Mushroom Priority Fix".
				;Makes it so mushroom can't replace other power-ups in your item box
				;Do NOTE that this doesn't fixes mushroom replacing item box item when eaten by yoshi, you'll have to use patch for that.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Initial checks and settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Print "INIT ",pc
Init:
LDA !extra_byte_1,x		;"pointers"
BEQ .Original			;if extra byte isn't set, use vanilla init.
DEC				;
BEQ .BlinkFall			;otherwise if it's 1, make it blink-fall
DEC				;
BEQ .Rising			;on 2 it'll be raising.
RTL				;on 3 and more do nothing (it'll instantly move normally)

.Rising
LDA #$3E			;raising timer.
STA !1540,x			;
RTL

.Original
INC !C2,x			;initially don't move
RTL

.BlinkFall
INC !1534,x			;
RTL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Main Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Print "MAIN ",pc
PHB : PHK : PLB
JSR Mushroom
PLB : RTL

Mushroom:
;LDA !160E,x			;check if it should act like berry
;BEQ .Continue			;nope...

;...

.Continue
LDA $64				;
PHA				;
JSR .Interact			;
LDA !1534,x			;check if it's blink-falling
BEQ .NoBlinkFall		;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Code for Blink-Fall state
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LDA $9D				;yeah, second 9D check in this whole code.
BNE .NoMove			;I know. It's no_good.
LDA #!BlinkFallSpeed		;
STA !AA,x			;Y-speed
JSL $01801A|!BankB		;

.NoMove
LDA $14				;show GFX
AND #$0C			;every 13 frames
BNE .GFX			;
PLA				;
RTS				;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.NoBlinkFall
LDA $9D				;don't do things on 9D
BNE .GFX			;moved this here so we don't have multiple 9D checks

LDA !1540,x			;check if it's rising out of block
BEQ .NotRising			;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Code for Rising Out Of Block state
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;JSL $019138|!BankB		;it's rising. interact with objects, even though IDK why it's needed. It doesn't use any interaction code.

LDA !1528,x			;
BNE .NotBehind			;

LDA #$10			;low priority
STA $64				;

.NotBehind
LDA #!RisingSpeed		;
STA !AA,x			;
JSL $01801A|!BankB		;

.GFX
JMP .NoSide			;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Code for when Mushroom is in normal state
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.NotRising
;LDA $9D			;wait, WHAT?
;BNE .GFX			;wew, thank goodness we already have one 9D check.

;LDA !14C8,x			;if it act's like power-up from goal
;CMP #$0C			;which I don't think can happen with this sprite
;BEQ .GFX			;

;LDA !9E,x			;a very strange check
;CMP #$76			;
;BNE .NotStar			;which literally does nothing.
.NotStar

INC !1570,x			;must have for power-up. so when yoshi swallows sprite, it'll give bonus, depending on acts as setting.
JSR XSpeed			;handle X-speed

;LDA !9E,x			;if it isn't fire flower
;CMP #$75			;
;BNE .NoResetX			;CORRECT!!!

.NoResetX
;CMP #$76			;
;BEQ .NoASL			;
;CMP #$21			;
;BEQ .NoASL			;
;LDA !151C,x			;
;BNE .NoASL			;

ASL !B6,x			;shift X-speed value

.NoASL
LDA !C2,x			;if it should move
BEQ .Move			;move
;BMI .Label2			;if high byte is set, don't mess with C2 (set when spawned out of flying ?-block sprite)

JSL $019138|!BankB		;
LDA !1588,x			;if it isn't in contact with any object in any way
BNE .Label2			;
STZ !C2,x			;reset movement flag, so it can move

BRA .Label2			;

.Move
;LDA $0D9B|!Base2		;this checks for Mode 7
;CMP #$C1			;in bowser's battle use normal movement
;BEQ .UpdateThings		;
;BIT $0D9B|!Base2		;
;BVC .UpdateThings		;if not in Mode 7 room, use normal movement

;STZ !1588,x			;not sure this'll be usefull. but I'll leave this in here anyways, just commented all out
;STZ !B6,x			;Normally power-up doesn't get spawn in any Mode 7 room, with exception of bowser. but this code... exists

;LDA !14D4,x			;
;BNE .Gravity			;

;LDA !D8,x			;
;CMP #$A0			;
;BCC .Gravity			;
;AND #$F0			;
;STA !D8,x			;

;LDA !1588,x			;
;ORA #$04			;
;STA !1588,x			;

;JSR XSpeed			;

;.Gravity
;JSL $01801A|!BankB		;
;JSL $018022|!BankB		;if B6 is zero, this is pointless?
;INC !AA,x			;
;INC !AA,x			;
;INC !AA,x			;
;BRA .NoUpdateThings		;

.UpdateThings
JSL $01802A|!BankB		;

.NoUpdateThings
LDA $13				;
AND #$03			;every 3rd frame
BEQ .Label2			;
DEC !AA,x			;decrease Y speed

.Label2
LDA #$00			;handle Offscreen
%SubOffScreen()			;

LDA !1588,x			;check for ceiling
AND #$08			;
BEQ .NoYReset			;reset Y-speed when touching ceiling

;LDA #$00			;:angry:
;STA !AA,x			;

STZ !AA,x			;:smile:

.NoYReset

LDA !1588,x			;
AND #$04			;
BNE .AAA			;
BRA .Continue_checking		;

.AAA
;LDA !9E,x			;obviously it isn't
;CMP #$21			;
;BNE .NotCoin			;

.NotCoin
LDA !1588,x			;
BMI .Speed1			;
LDA #$00			;
LDY !15B8,x			;
BEQ .Speed2			;

.Speed1
LDA #$18			;

.Speed2
STA !AA,x			;

;LDA !151C,x
;BNE .IsRoulette

;LDA !9E,x			;make star bounce
;CMP #$76			;
;BNE .NoY			;our sprite isn't star. REJECTED.

.Continue_checking
;LDA !1558,x			;this is unused, supposed to disable interaction with walls
LDA !C2,x			;not sure if this one actually works but I'll leave it just in case.
BNE .NoSide			;

LDA !1588,x			;check if touching wall.
AND #$03			;
BEQ .NoSide			;

LDA !157C,x			;
EOR #$01			;flip direction when touching wall
STA !157C,x			;

.NoSide

LDA !1540,x			;if mushroom's rising out of block
CMP #$36			;
BCS .RestorePriority		;for a few frames don't mess with priority

LDA !C2,x			;if it moves, don't hide it
BEQ .NotStationary		;
;CMP #$FF			;check if all bits set
;BNE .SlightPriority		;it'll be checking for "behind scenery" flag (in our case it can't be FF)
BRA .SlightPriority

.NotStationary
LDA !1632,x			;
BEQ .JSR			;

.SlightPriority
LDA #$10			;
STA $64				;

.JSR
JSR .FinallyGFX			;finally, do GFX things!

.RestorePriority
PLA				;self-explanatory.
STA $64				;
RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Handle Interaction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.Interact
JSR .Interaction		;
BCC .Ret			;

;LDA !151C,x			;check if it's a roulette sprite
;BEQ .NoC2Check			;of course it's not.

.NoC2Check

LDA !154C,x			;if it can't interact
BNE .Ret			;don't

LDA !1540,x			;if rising out of block
CMP #$18			;don't interact
BCS .Ret			;this creates glitch where you can eat power-up and not recieve it.

STZ !14C8,x			;sprite begone

;LDA !9E,x			;check if this sprite is...
;CMP #$21			;...coin
;BNE .InteractWithPowerUp	;of course it's not, so we don't care.

.InteractWithPowerUp
;There's supposed to be power-up calculation, but we don't care about that
;it's a custom sprite. DO WHATEVER YOU WANT!

;LDA !extra_bits,x		;we'll use extra bit instead
;AND #$04			;
;BNE .1UP			;

LDA !extra_prop_1,x		;err, I mean first extra property byte.
BNE .1UP			;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Mushroom Interaction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LDY $19				;if mario's small
BEQ .GivePower			;grow big and strong

if !MushroomPriorityFix		;
  LDA $0DC2|!Base2		;
  BNE .Meh			;
endif				;

LDA #$01			;
STA $0DC2|!Base2		;Item Box Item = Mushroom

.Meh

LDA #!ItemBoxSound		;
STA !ItemBoxBank|!Base2		;

BRA .EndRoutine			;

.GivePower
LDA #$02			;animation stuff
STA $71				;
LDA #$2F			;
STA $1496|!Base2		;
STA $9D				;

;JMP .EndRoutine		;what is THIS NINTENDO??? Skip literally nothing.

.EndRoutine
LDA #!ScoreMushroom		;
LDY !1534,x			;If it blink-falls (as if you dropped it from itembox)
BNE .NoScore			;
JSL $02ACE5|!BankB		;

.NoScore
LDA #!PickPowerupSound		;
STA !PickPowerupBank|!Base2	;

.Ret
RTS				;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1-Up Interaction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.1UP
LDA #!Score1UP			;
;CLC : ADC !1594,x		;this is unused, it's supposed to give mario more lives depending on value, but it isn't modified anywhere in the code
JSL $02ACE5|!BankB		;give 1-up (by default)
RTS				;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;GFX Routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FinallyGFX
%GetDrawInfo()
;STZ $0A

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
;LDA !9E,x			;if it's coin, blah blah blah
;CMP #$21			;
;BNE .PowerUpGFX		;

;Coin GFX

.PowerUpGFX

;CMP #$76			;checks if it's star
;BNE .NoFlash			;if it's not, don't flash.

;...

.NoFlash
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
;EOR $0A			;0A is reset anyways, so...
STA $0303|!Base2,y		;

;LDA !9E,x			;we don't need this wild calculation
;SEC : SBC #$74			;
;TAX				;

LDA #!MushroomTile		;since it's just Mushroom and 1-Up disassembly, use one and same mushroom tile.
STA $0302|!Base2,y		;

;LDX $15E9|!Base2		;

LDY #$02			;
LDA #$00			;
JSL $01B7B3|!BankB		;
RTS				;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Subroutines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.Interaction
PHK				;btw my first time using this jump method
PEA.w .Re-1			;I hope it doesn't sucks
PEA.w $0180CA|!BankB-1		;I'm not an idiot, I'm just learning
JML $01A80F|!BankB		;and maybe I am an idiot.

.Re
RTS				;

XSpeed:
LDA #!RightXSpeed		;set X-speed depending on direction.
LDY !157C,x			;
BNE .Store			;
LDA #!LeftXSpeed		;

.Store
STA !B6,x			;
RTS				;