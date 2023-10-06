;; UberASM which simply allows you to start a level with any Yoshi color
;;
;;
;; by Abdu

!Yellow     = $04
!Blue       = $06
!Red        = $08
!Green      = $0A
!ColorToUse = !Green

!MidwaySpawnYoshi = 0 ; if set will spawn yoshi when the midway is grabbed, otherwise will not spawn yoshi.

init:   ; if you aren't using the retry patch or you don't have counter break for yoshi then you can change the "init" to "load"
    if !MidwaySpawnYoshi == 0
        LDA $13CE|!addr
        BNE .Ret
    endif
    LDA #!ColorToUse
    STA $13C7|!addr
    JSL $00FC7A|!bank
    .Ret
RTL

