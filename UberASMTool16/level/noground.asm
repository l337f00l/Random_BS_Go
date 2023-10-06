;init:
   ; set the PEE timer to some default
;   LDA #$B0
;   STA $14AD
;   RTL

main:

   ; Check the PEE timer
   LDA $14AD
   BEQ .nointeract
   ; if it's not zero, we'll make sure mario can interact with the ground.
   LDA #$00
   BRA .setstatus
.nointeract
   ; if it's zero, we set mario's "interact with ground" flag to 1.
   LDA #$01
.setstatus
   ; store the value into the mario-block-interaction flag
   STA $185C
   
.return
   RTL