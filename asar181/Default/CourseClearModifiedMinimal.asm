; The text that this disabled is longer needed, as the score and bonus game themselves are disabled. 
; Compiled by SJandCharlieTheCat


; COURSE CLEAR text uses palette colors 19 and 1B, 
; which for some reason normally faded during the fade-out at level end, 
; and don't come back until it's over.
; So I made a couple other patches to address that 



org $05CC66   ; No one-up after goal tape
db $80,$1C


org $05CC42	;\ Remove all numbers and symbols
NOP #31		;/


;org $05CC46   ; No multiplication symbol
;db $FC,$FC

;org $05CC4E
;db $FC,$FC    No multiplication symbol 
;db $FC,$FC
;db $FC,$FC
;db $FC,$FC    No = sign

org $05CC1A 					;\ Remove MARIO tiles
db $FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC	;/

org $05CD51   ; Remove more BONUS stuff?
db $FC,$FC
db $FC,$FC
db $FC,$FC

org $05CD79   ; Stops calculation and drum-roll
db $80

org $05CDD8   ; Stops calculation and drum-roll
db $80