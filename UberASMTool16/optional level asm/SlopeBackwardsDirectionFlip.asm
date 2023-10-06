; Mainly by JamesD28, adapted by SJandCharlieTheCat
; If facing backwards while sliding on a right slope, flips your direction to match

; Note that this is broken for left-facing slopes.

main:
        LDA $13ED	; check if sliding backwards down right-facing slope     
	CMP #$1C        ; sliding
        BNE +
        ASL
        LDA #$00
        ROL
        CMP $76         ; CMP, direction facing
        BNE +
        EOR #$01         ; face opposite direction,
        AND #$01     ; right or left, after slide
        STA $76      ; direction
        +
        RTL