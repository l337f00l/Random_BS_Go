; Instead of having everything become pixelated whenever there's a fade (i.e. after dying and when respawning),
; this removes that, and just makes a clean, plain black fade.


org $009F67
db $00   ; 07 to restore to all mosaic for three layers, 0F to also include layer 4