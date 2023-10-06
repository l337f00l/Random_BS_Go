; Replace -- with two digit value
; Remove semi-colons when needed

; Note that a number of sprites have hardcoded palettes, 
; and thus can't be changed using this.
; Pokey (sprite 70, palette A)

main:
LDX #!sprite_slots-1
.loop
LDA !14C8,x
BEQ .next
LDA !9E,x
CMP #$--                ; Sprite hex number
BEQ ChangeToPalette1    ; You'll assign the palette change value in the matching label section
; CMP #$--              ; More sprites that you want to be changed to the same palette
; BEQ ChangeToPalette1
; CMP #$--              ; Different sprites given different palette change
; BEQ ChangeToPalette2
.next
DEX
BPL .loop
RTL

ChangeToPalette1:
LDA !15F6,x
AND #$F1
ORA #$--     ; YXPPCCCT value in hex, but bits only set for CCC, so palette 8 = 00, palette 9 = 02 
             ;                                                   palette A = 04, B = 06; C = 08 
             ;                                                   palette D = 0A, E = 0C, F = 0E
STA !15F6,x
BRA main_next

;ChangeToPalette2:
;LDA !15F6,x
;AND #$F1
;ORA #$--      ; CCC in hex
;STA !15F6,x
;BRA main_next

;ChangeToPalette3:
;LDA !15F6,x
;AND #$F1
;ORA #$--      ; CCC in hex
;STA !15F6,x
;BRA main_next