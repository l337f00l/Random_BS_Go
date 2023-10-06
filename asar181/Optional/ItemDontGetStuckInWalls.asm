;Don't get stuck in walls fix
;This patch fixes a bug where carryable sprites cn get stuck inside and between two blocks. Now it'll zip to where it was thrown from after a short amount of time.
;Does not 100% fix (moving) layer 2. The sprite will attempt to escape but it may keep zipping untill it goes offscreen.

;this miscallaneous table is only used by a single sprite in vanilla SMW, so it's safe to use for carriable sprites.
;this is a timer for how long the sprite was colliding with walls (basically jittering between two blocks). bit 7 is also sprite's zip direction
!MiscRamStuckTimer = !1504

if read1($00FFD5) == $23
sa1rom
!bank = $000000
!E4 = $322C
!14E0 = $326E
!157C = $3334
!1686 = $762C
!15D0 = $754C
!1504 = $74F4
else
lorom
!bank = $800000
!E4 = $E4
!14E0 = $14E0
!157C = $157C
!1686 = $1686
!15D0 = $15D0
!1504 = $1504
endif

org $019FE3
autoclean JSL PlayerWay

org $01F2E4
autoclean JSL YoshiWay
NOP

org $0191C6
autoclean JML Unstuck			;fixed a bug where if horizontal layer 2 objects push carryable sprite it'll assume it's stuck inside it and after a few pushes will zip

freecode

;tables for zipping offsets. move X pixels. you probably don't want to mess with this.
UnstuckXDisp:
db $F0,$10			;zip left, zip right.

UnstuckXDispHi:
db $FF,$00

;Set player's thrown/dropped direction based on inverse of player's
PlayerWay:
LDA #$00			;make it unstuck towards player (facing right, zip left)
LDY $76				;
BNE .NotRight			;
LDA #$80			;(facing left, zip right)

.NotRight
STA !MiscRamStuckTimer,x	;

LDA $71				;restore
CMP #$01
RTL

;set sprite's thrown/spit direction to decide where to eject it in case it's stuck in a wall.
YoshiWay:
PHY				;yoshi is a little different
LDY #$80			;
LDA !157C,x			;
BNE .NotRight			;
LDY #$00			;

.NotRight
TYA				;
PLY				;
STA !MiscRamStuckTimer,y	;

;restore
LDA !1686,Y			;restore
AND #$40			;
RTL				;

;Check if the sprite was stuck for a few frames

Unstuck:
AND #$03			;
BEQ .IgnoreWReset		;when inside two blocks it'll have blocked from side every frame. if not actually inside, reset timer (to fix horizontal layer 2 interaction.
TAY				;

LDA !15D0,x			;restore. if currently on yoshi's tongue, don't care about collision.
BNE .Ignore			;

INC !MiscRamStuckTimer,x	;tick
LDA !MiscRamStuckTimer,x	;
AND #$7F			;don't count bit 7.
CMP #$0E			;wait for 13 frames. should be sufficient enough and w/o glitches
BCC .Ignore2			;

;enough is enough
LDY #$00			;
LDA !MiscRamStuckTimer,x	;
BPL .NotRight			;
INY				;

.NotRight
PHB				;doesn't know where the table is unless we retrieve current bank
PHK				;
PLB				;
LDA !E4,x			;add to current position
CLC : ADC UnstuckXDisp,y	;
STA !E4,x			;

LDA !14E0,x			;
ADC UnstuckXDispHi,y		;
STA !14E0,x			;

PLB				;

.IgnoreWReset
LDA !MiscRamStuckTimer,x	;reset timer but keep zip direction
AND #$80			;
STA !MiscRamStuckTimer,x	;

.Ignore
JML $0191ED|!bank

.Ignore2
JML $0191D0|!bank