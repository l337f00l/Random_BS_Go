;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Priority Fixes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

org $00E2B9|!bank
    db $E0,$10,$20,$30                    ;Mario Priority

org $018E83|!bank
    LDA #$20                            ;Classic Piranha Priority

org $01C18D|!bank
    LDA #$20                            ;Growing Vine Priority

org $01C39C|!bank
    LDA #$20                            ;Power Up Priority

org $01C4A1|!bank
    LDA #$20                            ;Appearing Power Up Priority

org $01C6C1|!bank
    LDA #$20                            ;Power-Up Priority

org $01C6C5|!bank
    ORA #$60                            ;Power-Up Priority (Flipped)

org $01DB9E|!bank
    db $23,$63,$A3,$E3                    ;Grinder Priority

org $01EBA9|!bank
    LDA #$20                            ;On Yoshi Priority

org $029E73|!bank
    ORA #$23                            ;Torpedo Ted's Arm Priority

org $02B892|!bank
    LDA #$20                            ;Torpedo Ted Priority

org $02E0D4|!bank
    LDA #$20                            ;Jumping Piranha Priority

org $02E7C5|!bank
    LDA #$20                            ;Chuck's Rock Priority

org $02EA1A|!bank
    EOR #$6B                            ;Pipe Lakitu Priority

org $02F4B6|!bank
    LDA #$25                            ;Smoke Priority

org $0394C5|!bank
    db $81,$81,$81,$81,$81                ;Wooden Spike
    db $01,$01,$01,$01,$01                ;Priority

org $039784|!bank
    db $6D,$DD,$2D,$AD                     ;Fishbone Priority

org $03A09B|!bank
    db $45,$25                            ;Blargg Priority

org $04FDAC|!bank
    LDA #$74                            ;Bowser Sign Priority