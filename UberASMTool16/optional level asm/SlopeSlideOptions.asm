; by SJandCharlieTheCat, inspired By Thomas, reorganized by SJandCharlieTheCat


!autoslide = 1
!disableLR = 0    ; 1 to disable left and right
!disableJump = 0

main:
	LDA $13EE	; if not on a slope, return
	BEQ .ret

if !autoslide
	LDA #$1C	; mario's on a slope, so make him slide
	STA $13ED
endif

if !disableLR
	LDA #$03
	TRB $15
endif

if !disableJump
	LDA #$80
	TRB $16
	TRB $18
endif

.ret
	RTL