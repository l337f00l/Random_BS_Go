;; Button Ammo limits button presses.
;;
;; By Abdu
;; Make sure ascii-28.txt is in the same folder as this file.
;; something to note is that it sets the layer 3 position to 0
;; so if your layer 3 is not showing up that could be the case.
;;
;; Credit: Thanks to KevinM for giving me the stripe layer 3 macros and saving me time instead of having to write them on my own.
; Freeram make sure there are no conflicts with other inserted patches, uberasm sprites, blocks etc.
; Freeram only 6 bytes of freeram is used.
!AAmmo      = $18C5|!addr ; ammo for A button
!BAmmo      = !AAmmo+1    ; ammo for B button
!XYAmmo     = !AAmmo+2    ; ammo for X/Y
!BackUpA    = !AAmmo+3   ;\ Backups used so I don't need to keep drawing the value if the counter doesn't change. Only used when !DrawCounters = 1
!BackUpB    = !AAmmo+4   ;|
!BackUpXY   = !AAmmo+5   ;/

!DrawCounters       = 1         ; Draws the counters to layer 3 using stripe image.
!DecreaseABInAir    = 0         ; If set it will decrease the A and B counter even if the player is in the air. Pretty much allows you to regrab if set to 0.
!DecreaseXYInAir    = 0         ; If set it will decrease the X/Y counter even if the player is in the air.
!DecreaseXYHeldDown = 1         ; If set to 1 it will decrease X/Y counter based on some frequency, if not it will decrease X/Y counter whenever the button is pressed.
!Frequency          = $3F       ; Frequency for decreasing !XYAmmo, must be a (power of 2)-1, so values like $00, $01, $03, $07, etc work fine.
!InitAmmo           = $05       ; becareful if you use anything above $63

!XPos           = $01
!YPos           = $01
!OffsetValue    = $03
!OffsetCounters = $06

table "ascii-28.txt"

; feel free to change the entries in here, just make sure they aren't that long.
DataTable:
    .A
        dw "A: "
    .B
        dw "B: "
    .XY
        dw "XY: "
    .end

; macros by KevinM
macro BeginStripe()
    rep #$30
    lda $7F837B
    tax
endmacro

macro WriteLine(Layer, XPos, YPos, Table, Length)
    ldy #$0000
    lda.w #(($800*<Layer>*(<Layer>-1))+$2000)|((<YPos>)<<5)|(<XPos>)
    xba
    sta $7F837D,x
    inx #2
    lda.w #(<Length>)-1
    xba
    sta $7F837D,x
    inx #2
?-  lda.w <Table>,y
    sta $7F837D,x
    inx #2
    iny #2
    cpy.w #<Length>
    bne ?-
endmacro

macro EndStripe()
    txa
    sta $7F837B
    lda #$FFFF
    sta $7F837D,x
    sep #$30
endmacro


init:
    LDA #!InitAmmo
    STA !AAmmo
    STA !BAmmo
    STA !XYAmmo

    if !DrawCounters
        STZ $22                 ;\ Set layer 3 position to 0
        STZ $24                 ;/

        STZ !BackUpA        ;\ backup ram is only used for whenever we are drawing the counters.
        STZ !BackUpB        ;|
        STZ !BackUpXY       ;/
        JSR DrawLabels
        JMP main_checkDraw
    endif
RTL
DrawLabels:
    %BeginStripe()
    %WriteLine(3, !XPos, !YPos, DataTable_A, DataTable_B-DataTable_A)
    %WriteLine(3, !XPos+!OffsetCounters, !YPos, DataTable_B, DataTable_XY-DataTable_B)
    %WriteLine(3, !XPos+(!OffsetCounters*2), !YPos, DataTable_XY, DataTable_end-DataTable_XY)
    %EndStripe()
RTS

main:
    
    LDA $9D                 ;\ Game is frozen.
    ORA $13D4|!addr         ;| check if the game is paused 
    BEQ +                   ;/
    RTL

    +
    LDA !AAmmo              ; check if there is no ammo
    BEQ .disableA           ; so disable button press

    if !DecreaseABInAir == 0
    LDA $72         ;\ Check if the player is in the air.
    BNE .checkXY    ;/ if they are then just go check for X/Y instead.
    endif

    LDA $18                 ;\ check if A is pressed
    BIT #$80                ;|
    BEQ .checkB             ;/ if not just skip



    
    DEC !AAmmo              ; decrease A jump ammo
    BRA .checkB

    .disableA
    LDA #$80                ; disable A button from being pressed this frame
    TRB $18                 ;


    .checkB
    LDA !BAmmo              ; check if there is no ammo
    BEQ .disableB           ; so disable button press

    if !DecreaseABInAir == 0
    LDA $72                 ;\ Check if the player is in the air.
    BNE .checkXY            ;/ if they are then just go check for X/Y instead.
    endif

    LDA $16                 ;\ check if B is pressed
    BIT #$80                ;|
    BEQ .checkXY            ;/ if not just skip
    
    DEC !BAmmo              ; decrease B jump ammo
    BRA .checkXY

    .disableB
    LDA #$80
    TRB $16


    .checkXY
    LDA !XYAmmo           ; check if there is no ammo
    BEQ .disableXY        ; so disable button press

    LDA $16                 ; check if XY is pressed
    if !DecreaseXYHeldDown
        LDA $15
        ORA $17
    endif

    BIT #$40 
    BEQ .checkDraw          ;/ if not return

    if !DecreaseXYInAir == 0
        LDA $72
        BNE .checkDraw
    endif

    if !DecreaseXYHeldDown
        LDA $14
        AND #!Frequency
        BNE .checkDraw
    endif
    DEC !XYAmmo             ; decrease XY jump ammo
    BRA .checkDraw

    .disableXY
    LDA #$40                ; disable XY button from being held down
    TRB $15
    TRB $16
    TRB $18
    TRB $17
    
    .checkDraw
        if !DrawCounters
            LDA !AAmmo        ;\ Only update the counter when it changes.
            CMP !BackUpA      ;| 
            BEQ .checkBCount  ;/
            STA !BackUpA      ; and update the ammo backup.
            
            JSR SetupTable
            %BeginStripe()
            %WriteLine(3, !XPos+!OffsetValue, !YPos, $00|!dp, 2*2)
            %EndStripe()
            .checkBCount
            LDA !BAmmo        ;\ Only update the counter when it changes.
            CMP !BackUpB      ;| 
            BEQ .checkXYCount ;/
            STA !BackUpB         ; and update the ammo backup.
            JSR SetupTable
            
            %BeginStripe()
            %WriteLine(3, !XPos+!OffsetCounters+!OffsetValue, !YPos, $00|!dp, 2*2)
            %EndStripe()
            
            .checkXYCount
            LDA !XYAmmo        ;\ Only update the counter when it changes.
            CMP !BackUpXY      ;|
            BEQ .Ret           ;/
            STA !BackUpXY      ; and update the ammo backup.
            JSR SetupTable
            %BeginStripe()
            %WriteLine(3, !XPos+(!OffsetCounters*2)+!OffsetValue, !YPos, $00|!dp, 2*2)
            %EndStripe()
        endif



.Ret
RTL

; Thanks to KevinM for giving me this.
; A = counter to be drawn.
SetupTable:
    
    sta $4204           ;|
    stz $4205           ;| Divide counter by 10 to find the digits.
    lda #10             ;|
    sta $4206           ;/
    
    lda #$38            ;\
    sta $01             ;| Store properties for the digits.
    sta $03             ;/

    nop #4              ; Need to waste 8 more cycles...

    lda $4214           ;\
    bne +               ;|
    lda #$FC            ;| Store digits in the table.
+   sta $00             ;| (if tens are 0, store the empty tile).
    lda $4216           ;|
    sta $02             ;/
    rts
