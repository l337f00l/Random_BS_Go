; You'll need to find the part of this file which says "levels:" (right after "freedata"). 
; Each level number corresponds to a Map16 number in the "ActAs:" table right below. (Default act-as is 5, normal water) 
; You can add as many levels as you want.


        lorom
        !base   = $0000
        !bank   = $800000
        !bank_b = $7E0000
if read1($00ffd5) == $23
        sa1rom
        !base   = $6000
        !bank   = $000000
        !bank_b = $400000
endif

org $00A045
        autoclean JML tide

if read1($05D8B7) != $80

org $05D8B7
        BRA +
        NOP #3		;the levelnum patch goes here in many ROMs, just skip over it
+       REP #$30
        LDA $0E
        STA $010B|!base
        ASL
        CLC
        ADC $0E
        TAY
        LDA.w $E000,Y
        STA $65
        LDA.w $E001,Y
        STA $66
        LDA.w $E600,Y
        STA $68
        LDA.w $E601,Y
        STA $69
        BRA +
org $05D8E0
        +

endif

freedata

levels:
        dw $0102,$0105,$0112
.end

ActAs:
        dw $0005,$0005,$0005

tide:
        REP #$30
        LDX.w #levels_end-levels-2
.level_check
        LDA $010B|!base
        CMP.l levels,x
        BEQ .custom
        DEX #2
        BPL .level_check
        LDX #$0100
        JML $00A04A|!bank

.custom
        PEI ($00)
        LDA.l ActAs,x
        STA $00
        LDX #$0100
..set_loop
        LDY #$0058
        SEP #$20
..loop
        LDA $00
        STA $00E300|!bank_b,x
        STA $00E301|!bank_b,x
        LDA $01
        STA $01E300|!bank_b,x
        STA $01E301|!bank_b,x
        INX
        INX
        DEY
        BNE ..loop
        REP #$21
        TXA
        ADC #$0100
        TAX
        CPX #$1B00
        BCC ..set_loop
        PLA
        STA $00
        JML $00A064|!bank