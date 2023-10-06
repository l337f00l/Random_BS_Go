; Translucent block (12C)

org $0291F5
    db $22    ; Tile number, normal EA

org $02878D
    db $00    ; first GFX page, 01 is second (GFX02 in SP4). Uses Mario palette row

; on/off bounce

org $0291F6     ; Tile number (16x16)
    db $0A      ; $C2 to overwrite cloud coin

org $02878E     ; YXPPCCCT properties
    db $06      ; $06 = first page, $07 = second page

;=================================;
; Note bounce sprite properties   ;
;=================================;
org $0291F2     ; Tile number (16x16)
    db $20      ; 6B is normal

org $02878A     ; YXPPCCCT properties
    db $02      ; $02 = first page, $03 = second page (normal)

;=================================;
; Yoshi's tongue properties       ;
;=================================;
org $01F488     ; Tile number (8x8) (middle of tongue)
    db $7E      ; Found in GFX 0D

org $01F48C     ; Tile number (8x8) (end of tongue)
    db $7F

org $01F494     ; YXPPCCCT properties
    db $08      ; $08 = first page, $09 = second page

;=================================;
; Yoshi's throat properties       ;
;=================================;
org $01F08B     ; Tile number (8x8)
    db $38      ; normally found in GFX13

org $01F097     ; YXPPCCCT properties
    db $00      ; $00 = first page, $01 = second page

;=================================;
; Lava splashes properties        ;
;=================================;
org $029E82     ; Tile numbers (8x8)
    db $5B      ; Found in GFX 03
    db $4B
    db $5A
    db $4A

org $029ED5     ; YXPPCCCT properties
    db $04      ; $04 = first page, $05 = second page


; Podoboo lava trail:

org $028F2B    
db $5B,$4B,$5A,$4A               ; tile, default (SP4) db $D7,$C7,$D6,$C6

org $028F76                     ;Lava trail YX
db $04               ; 05, change to 04 for first GFX page