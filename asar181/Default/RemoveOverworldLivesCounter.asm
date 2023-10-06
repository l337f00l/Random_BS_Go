org $05DBF2
db $6B     ; vanilla 8B

org $04A530        ; Remove little X mark
db $FE     ; vanilla db $8F

; Formerly also this, which only removes for Mario, not Luigi too:

;org $00A15A  , Number of lives itself
;BRA $02   , vanilla db $80,$02

