main:
  ; load in powerup status
  LDA $19
  ; if it's anything other than zero, we kill mario.
  BNE .kill

  ; load up the star timer
  LDA $1490
  ; if it's anything other than zero, we kill mario.
  BNE .kill


  BRA .return
.kill
  ; otherwise, we kill the mario :O
  JSL $00F606

.return
  RTL


;main:
  ; load in powerup status
;  LDA $19
  ; if it's zero, then we're small and we'll kick out.
;  BEQ .return

;main:
 ; LDA #$02
 ; STA $19


;.return
;  RTL

  ; otherwise, we kill the mario :O
;  JSL $00F606

;.return
;  RTL