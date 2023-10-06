; By SJandCharlieTheCat and binavik

org $008C89      ; MARIO name GFX
db $FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC  ; vanilla $30,$28,$31,$28,$32,$28,$33,$28,$34,$28 I think

; Also LUIGI name

org $008CC1    ; This only gets rid of X symbol by itself, until used with the next 
dw $38FC,$38FC,$38FC   ; vanilla db $26,$38,$FC,$38,$00,$38

org $008F55    ; Gets rids of functionality life counter, necessary to actually remove GFX
BRA $04        ; vanilla db $8E,$16

org $008FED  
db $FC  ; coin GFX used for Yoshi coin, vanilla 2E

org $008F9D
	LDA #$FC
	STA $0F03   ; top left tile of bonus point numbers
	STA $0F04   ; top right tile of bonus point numbers
	STA $0F1B   ; Red bonus star symbol in status bar
	STA $0F1C   ; X symbol next to red star
	STA $0F1E   ; bottom left of bonus point numbers
	STA $0F1F   ; bottom right of bonus point numbers
	BRA $12
	NOP #18

; To unpatch the above,
; org $008F9D
; db $BD,$1E,$0F,$D0,$0D,$A9,$FC,$9D,$1E,$0F,$9D,$03,$0F,$E8,$E0,$01,$D0,$EE,$BD,$1E,$0F,$0A,$A8,$B9,$06,$8E,$9D,$03,$0F,$B9,$07,
; $8E,$9D,$1E,$0F,$E8,$E0,$02,$D0,$EA

org $008E95    ; remove score counter, vanilla 8E95 starts A2
JMP.w $008F1D  ; vanilla db $A2,$03,$BD

org $008CF5	;\remove the last 0 of score that isn't controlled by routine.
db $FC		;/  vanilla 00

; Also need to remove for Luigi?

org $008CAB   ; disable TIME word itself
db $FC,$FC,$FC,$FC,$FC   ; vanilla db $3D,$3C,$3E,$3C,$3F

!Hundreds = $0F12    ;  location to draw timer, 0F2D for where score was. Normally score 1000s spot
!Tens = !Hundreds+1
!Ones = !Tens+1

org $008E6F ; routine that handles time counter, puts in location. 
            ; Note, however, that this may mess with Status Bar Editor's display itself.

LDA $0F31   ; time counter itself
STA !Hundreds
LDA $0F32
STA !Tens
LDA $0F33
STA !Ones

org $008CE1    ; removes leftover garbage GFX where actual time counter was before
db $FC,$FC,$FC,$FC,$FC,$FC   ; vanilla db $FE,$3C,$FE,$3C,$00,$3C

org $008CB7   ; make normal coin symbol (before coin counter, 0F10) position GFX blank
db $FC        ; vanilla 2E

org $008CB9   ; make normal X symbol position (0F11) GFX blank
db $FC        ; vanilla 26

org $008F7E
STA $0F2F               ; \ Write coins to new location, down a tile. Normal 0F13 and 0F14 
STX $0F2E               ;

org $008F7A   ; The big code that follows remaps the coin counter to use a different GFX spot in LG1
	autoclean JSL remap
	
freecode
print "Code is located at: $", pc

;change these values to where you want the new number tiles to be. Order matters.
;			    0,   1,   2,   3,   4,   5,   6,   7,   8,   9
loc_table: db $30, $31, $32, $33, $34, $40, $41, $42, $43, $44

remap:
	STA $01
	TXA
	BNE .actual_number
	LDA #$FC
	STA $00
	BRA .ones_digit
.actual_number
	TAX
	LDA.l loc_table,x
	STA $00
.ones_digit
	LDX $01
	LDA.l loc_table,x
	STA $01
.return
	LDX $00
	LDA $01
	RTL