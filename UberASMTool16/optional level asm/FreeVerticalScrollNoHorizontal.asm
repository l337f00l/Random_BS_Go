; Makes the camera always follow Mario up, rather than waiting for him to land on something. 
; (Does a similar thing that the included Anti-BlindVerticalMovementCameraBlock.asm does, but on a level basis)

!FreeVertScroll = 1 ; 1 = free vertical scrolling (also set "Vertical Scroll at Will" in LM!)
!NoHorzScroll   = 0 ; 1 = no horizontal scrolling

if !NoHorzScroll
init:
    stz $1411|!addr
    rtl
endif

if !FreeVertScroll
main:
    lda #$01
    sta $1404|!addr
    rtl
endif
