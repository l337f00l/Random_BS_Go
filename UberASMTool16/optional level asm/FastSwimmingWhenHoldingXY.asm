; This patch will make Mario swim (or walk underwater) faster when holding X/Y.
; He will get the same X speed as if he were holding an item, which is basically double the normal speed.
; It also works with tides.

if read1($00FFD5) == $23
    sa1rom
    !addr = $6000
    !bank = $000000
else
    lorom
    !addr = $0000
    !bank = $800000
endif

org $00DA42
    autoclean jml CheckXY

freecode

CheckXY:
    bit #$03
    beq .skip
    ldy #$78
    bit #$40
    beq .normal
.fast
    ldy #$80
.normal
    jml $00DA48|!bank
.skip
    jml $00DA69|!bank
