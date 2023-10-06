;; Flip ON/OFF using L/R and  display ON/OFF using stripe image
;; by Abdu
;; something to note is that it sets the layer 3 position to 0
;; so if your layer 3 is not showing up that could be the case.
;; Put the ascii-28.txt in the same folder as this file.
;;

!XPos = $001D
!YPos = $0203
!Switch = $14AF|!addr

table "ascii-28.txt"
macro Line(XPos, YPos, Table, length)
    LDY #$0000
    LDA #$5000|((<YPos>)<<5)|<XPos>
    XBA
    STA $7F837D,x
    INX #2
    LDA #<length>-1
    XBA
    STA $7F837D,x
    INX #2
 ?- LDA <Table>,y
    STA $7F837D,x
    INX #2
    INY #2
    CPY #<length>
    BNE ?-
endmacro

DataTable:
    .ON
        dw "ON "
    .OFF
        dw "OFF"
    .end

init:
    STZ $22                 ;\ Set layer 3 position to 0
    STZ $24                 ;/
    JMP main_draw

main:

    LDA $9D             ;\ game if frozen
    ORA $13D4|!addr     ;| check if the game is paused 
    BNE .draw           ;/ so just draw

    LDA $18                 ;\ Check if L or R is pressed
    AND #$30                ;|
    BEQ .draw                   ;/ if not then go draw on/off
    
    LDA !Switch             ;\ Flip the switch
    EOR #$01                ;|
    STA !Switch             ;/
    
    LDA #$0B                ;\
    STA $1DF9|!addr         ;/

    .draw
    LDA !Switch             ;\
    STA $00                 ;| Doing this because if I load the switch status while being in 16-bit mode it might get the high byte
    STZ $01                 ;/
    

    REP #$30
    LDA $7F837B             ;\ get index
    TAX                     ;/
    LDA $00
    BNE +
    %Line(!XPos, !YPos, DataTable_ON, DataTable_OFF-DataTable_ON) ; draw ON
    BRA ++
    +
    %Line(!XPos, !YPos, DataTable_OFF, DataTable_end-DataTable_OFF) ; draw OFF
    
    ++
    TXA
    STA $7F837B
    LDA #$FFFF          ;\ End stripe image write.
    STA $7F837D,x       ;/
    SEP #$30
    .Ret     
    RTL		
