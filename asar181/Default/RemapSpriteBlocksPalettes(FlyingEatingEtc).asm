; Along with the turblock bridge tile edit,
; this basically allowed me to harmonize the colors of things in palette row 6
; with the different palette of their corresponding sprite versions


org $07F481    ; flying left block
db $24   ; Palette A. vanilla 20, palette 8


org $07F482    ; flying back and forth block
db $24

;;; Creating/eating block

org $07F4AF
db $34  ;   palette B is 36. 34 is palette A. vanilla $30, 00110000 

; org $039293 : db $2E
; org $0392A0 : db $02


;;; Directional coins
org $01C653 : db $E8 : org $07F443 : db $34                                       ; Frame 1, default $30 for all
org $01C66D : db $EA : org $07F443 : db $34                                       ; Frame 2
org $01C66E : db $FA : org $07F443 : db $34                                       ; Frame 3
org $01C66F : db $EA : org $07F443 : db $34                                       ; Frame 4