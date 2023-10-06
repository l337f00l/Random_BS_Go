;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Growing Vine Disassembly, by imamelia
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; init routine
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!9CTile = $03  ; 03 is normal vine. 02 is just 25 tile. 

print "INIT ",pc
RTL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; main routine
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print "MAIN ",pc
PHB
PHK
PLB
JSR GrowingVineMain
PLB
RTL

GrowingVineMain:
LDA #$03
%SubOffScreen()

LDA $64			; level priority bits
PHA			; save for later
LDA !1540,x		;
CMP #$20		; if this counter is less than 20...
BCC DontChangePriority	; don't change the sprite's priority
LDA #$10		;
STA $64			; set new priority bits
DontChangePriority:
JSR SubVineGFX		; the original graphics routine was so screwy that I had to rewrite part of it
PLA			;
STA $64			; restore original priority bits from before
LDA $9D			; if sprites are locked...
BNE ReturnMain		; return
LDA #$FA		; normal speed F0
STA !AA,x		; set the sprite's Y speed
JSL $01801A|!BankB	; update sprite Y position without gravity      
LDA !1540,x		; load the counter
CMP #$20		; this time, branch if it is greater than or equal to #$20
BCS SkipStuff		;
JSL $019138|!BankB	; interact with objects
LDA !1588,x		; load sprite blocked status
BNE SkipStuff		; branch if the sprite is touching anything  
LDA !14D4,x		; sprite Y position (high byte)
BPL DontEraseSprite	; don't erase the sprite if it hasn't gone offscreen

SkipStuff:
LDA !14C8,x		; if the sprite isn't in its normal status...
CMP #$08			; (more like, if the status is *less* than 08)
BCC SpriteDisappears	; then make it disappear
LDA !161A,x		; load sprite index to level table
CMP #$FF			; if FF...
BEQ SpriteDisappears	; then make the sprite disappear
TAX
LDA #$00
STA !1938,x		; mark the sprite to be loaded based on its index stored in $161A,x
LDX $15E9|!Base2	; Restore sprite slot
SpriteDisappears:	;
STZ !14C8,x		;
RTS

DontEraseSprite:	;

LDA !D8,x		; sprite Y position (low byte)
AND #$0F		; we only want the lower 4 bits
;CMP #$00		; pointless line, but I'll leave it in anyway
BNE ReturnMain		; if this is 00, then return
LDA !E4,x		; sprite X position (low byte)
STA $9A			; this will be the low byte of the vine tile's X position
LDA !14E0,x		; sprite X position (high byte)
STA $9B			; this will be the high byte of the vine tile's X position
LDA !D8,x		; sprite Y position (low byte)
STA $98			; block Y position (low byte)
LDA !14D4,x		; sprite Y position (high byte)
STA $99			; block Y position (high byte)
LDA #!9CTile		; block to generate:
STA $9C			; vine tile
JSL $00BEB0|!BankB	; generate common Map16 tile routine
ReturnMain:		;
RTS

SubVineGFX:
%GetDrawInfo()		; set up variables for OAM
LDA $00			; sprite X displacement
STA $0300|!Base2,y	; first OAM slot
LDA $01			; sprite Y displacement
STA $0301|!Base2,y		; second OAM slot
LDA $14			; take the sprite frame counter
LSR
LSR
LSR
LSR			; and shift right 4 times
LDA #$AC		; tile used if bit 4 of the frame counter was clear
BCC StoreTile		;
LDA #$AE		; tile used if bit 4 of the frame counter was set
StoreTile:		;
STA $0302|!Base2,y	; store the tile number      
LDA !157C,x	;
LSR		;
LDA !15F6,x	; load sprite palette and GFX page info
BCS NoFlip	; if the sprite's direction was right ($157C,x and $02=01),
ORA #$40		; flip the tile
NoFlip:
ORA $64		; add in priority bits
STA $0303|!Base2,y	; store tile properties
LDY #$02		; the tiles are 16x16
LDA #$00		; and we drew one tile...
JSL $01B7B3|!BankB	; finish OAM write
RTS