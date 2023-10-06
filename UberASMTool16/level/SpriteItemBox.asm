; This gives you a sprite-drawn blue item box, as an alternative to the white one.
; Requires ExGFX101 in SP2, and then several different options for file in LG1 (ExGFX334 is default item box only)
; Uses FreeRAM $1908


load: lda #$01 : sta $87 : rtl     ; re-enable status bar in general
init: lda #$01 : sta $1908 : rtl   ; enable sprite item box


; The code below this also allows you to use the coin counter with this, too,
; as long as you use the right ExGFX file in LG1


;!statusbarcoin_ram = $0F2B   ; coin counter icon, new location 0F2B-C, down a tile from 0F10-11 

;init:
;LDA #$2E
;STA !statusbarcoin_ram
;LDA #$26
;STA !statusbarcoin_ram+1
;RTL