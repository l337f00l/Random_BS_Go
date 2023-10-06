; By default, when you enable this for a level, it will only display the timer.
; See general instructions of ExGraphics note for more options.


load: lda #$01 : sta $87 : rtl



!statusbarcoin_ram = $0F2B   ; coin counter icon, new location 0F2B-C, down a tile from 0F10-11 

init:
LDA #$2E
STA !statusbarcoin_ram
LDA #$26
STA !statusbarcoin_ram+1
RTL