; Makes the status bar completely empty by default, but allows you to re-enable parts of it in levels
; if used in conjunction with the RetainStaturBar UberASM. 
; Use also in conjunction with the different layer 3 component files



!flag = $87

if read1($00FFD5) == $23
    sa1rom
    !addr = $6000
    !bank = $000000
else
    lorom
    !addr = $0000
    !bank = $800000
endif

org $008DAC
    autoclean jml check_flag_1

org $008294
    autoclean jml check_flag_2

org $008CFF
    autoclean jml check_flag_3

freecode

check_flag_1:
    lda !flag : bne .enable
.disable:
    jml $008DE6|!bank
.enable:
    stz $2115
    lda #$42
    jml $008DB1|!bank

check_flag_2:
    lda !flag : bne .enable
.disable:
    lda #$81 : sta $4200
    lda $22 : sta $2111
    lda $23 : sta $2111
    lda $24 : sta $2112
    lda $25 : sta $2112
    lda $3E : sta $2105
    lda $40 : sta $2131
    jml $0082B0|!bank
.enable:
    lda $4211
    sty $4209
    jml $00829A|!bank

check_flag_3:
    lda !flag : bne .enable
.disable:
    jml $008D8F|!bank
.enable:
    lda #$80 : sta $2115
    jml $008D04|!bank
