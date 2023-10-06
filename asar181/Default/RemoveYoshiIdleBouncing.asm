; When adult Yoshi is idling (when Mario isn't on him), 
; he bounces off the ground 3 frames up, and 3 frames back down.
; Not only can this be an issue in tight kaizo situations, 
; but it also prevents Yoshi from being moved by conveyor blocks.


; Note, however, that a ditched Yoshi will instantly come to a stop on the ground,
; with no traction. Revert to vanilla value if needed.


org $01ECFE    ; grown Yoshi hopping speed
db $00   ; vanilla $F0