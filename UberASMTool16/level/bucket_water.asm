;Settings

    !sprnum_L = $53        ;Sprite # to spawn when pressing L
    !custom_L = 0        ;0 = not a custom sprite, 1 = custom sprite.
    
    !sprnum_R = $07        ;Sprite # to spawn when pressing R
    !custom_R = 0        ;0 = not a custom sprite, 1 = custom sprite.
    
    !cape = 0            ;0 = cannot spawn item while flying, 1 = can spawn item while flying.

;The code is actually in the library file. This allows for the possibility of using it with
;different settings in different levels without repeated code being inserted.

main:


    LDA $13D4|!addr        ; Is level paused ?
    ORA $1426|!addr        ; Is a message box active ?
    ORA $9D                ; Are sprites and animations locked ?
    BNE .aftershittywatercodelol            ; Cuz' if yes, return.
    LDA $75        ; Is Mario in water ?
    BEQ .aftershittywatercodelol    ; Cuz' if not, return.
    LDA $77        ; \ Is Mario touching the ground ?
    AND #$04    ; /
    BNE .aftershittywatercodelol    ; Cuz' if he is, return.
    LDA #$80        ; \ Disable any first frame input B.
    TRB $16            ; /
    LDA $187A|!addr    ; Is Mario riding Yoshi ?
    BNE .aftershittywatercodelol        ; Cuz' if yes, that's all.
    LDA #$80        ; \ Otherwise, also disable first frame input A.
    TRB $18            ; /





.aftershittywatercodelol
    LDA #!sprnum_L
    STA $00
    LDA #!sprnum_R
    STA $01
    LDA #!custom_L
    STA $02
    LDA #!custom_R
    STA $03
if !cape
        SEC
else
        CLC
endif
    JSL LRSpawnCarried_main
    RTL 