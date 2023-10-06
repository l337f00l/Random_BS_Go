main: 
lda #$0C   ; change this to #$0F to enable constraint for left and right, too.
           ; I don't fully understand how that works, but you can read more here:
           ; https://www.smwcentral.net/?p=section&a=details&id=24700
sta $18D8
rtl