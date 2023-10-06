; Note that one major effect of this is that when baby Yoshi is thrown
; he won't slide on the ground a bit before coming to a stop.
; He'll just instantly come to a stop right where he's thrown.

; The baby Yoshi disassembly actually gets around this, though. You can
; disable the idle bouncing by filling out the Extension bytes as 00 00 00 FF.


org $01A26A   ; baby Yoshi hopping speed
db $00   ; vanilla $F0 