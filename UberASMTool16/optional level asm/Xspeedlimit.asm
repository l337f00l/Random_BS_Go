; Horizontal speed limit
; This code makes it so player can only run at certain speed.
; by RussianMan, credit is unecessary.

!MaxLeft = $xx			;\self explanatory. DE is equivalent to 21, walking
!MaxRight = $xx			;/maximum speeds for left and right. 49/37/21 for sprinting, running, and walking 

main:
LDA $7B				;check speed
BPL .right			;if going right, check right

.left
CMP #!MaxLeft			;if it isn't max yet
BPL .re				;return
LDA #!MaxLeft			;otherwise it has hit max, no running
BRA .set			;

.right
CMP #!MaxRight			;if it's not max
BMI .re				;return

.nomore
LDA #!MaxRight			;no more than this

.set
STA $7B				;no run

.re
RTL				;