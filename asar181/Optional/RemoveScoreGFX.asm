; By SJandCharlieTheCat
; Score from coin blocks, etc.

;;; 10
org $02AD4D : db $83        ; 83 is, like 69, another empty tile
org $02AD63 : db $69        ; Right


;;; 20
org $02AD4E : db $83          ; Left
org $02AD64 : db $69         ; Right


;;; 40
org $02AD4F : db $83         ; Left
org $02AD65 : db $69     ; Right


;;; 80
org $02AD50 : db $83        ; Left 
org $02AD66 : db $69          ; Right


;;; 100
org $02AD51 : db $69    ; Left
org $02AD67 : db $69   ; Right


; Score from enemies and normal coins, etc.

;;; 200
org $02AD52 : db $69               ; Left
org $02AD68 : db $69              ; Right


;;; 400
org $02AD53 : db $69                ; Left
org $02AD69 : db $69                ; Right


;;; 800
org $02AD54 : db $69          ; Left
org $02AD6A : db $69               ; Right


;;; 1000
org $02AD55 : db $69     ; Left
org $02AD6B : db $69              ; Right


;;; 2000
org $02AD56 : db $69      ; Left
org $02AD6C : db $69          ; Right


;;; 4000
org $02AD57 : db $69  ; Left
org $02AD6D : db $69   ; Right


;;; 8000
org $02AD58 : db $69   ; Left
org $02AD6E : db $69    ; Right



org $02AD59 : db $69 ; One-up
org $02AD6F : db $69

;;; 2UP
org $02AD5A : db $69 ; 2-up
org $02AD70 : db $69 

