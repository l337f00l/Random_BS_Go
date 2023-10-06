; When the corresponding patch is used,
; this will make left-facing goal posts/tape in whatever level it's used in.
; Uses $18E6 as FreeRAM by default 


init: lda #$01 : sta $18E6 : rtl