; Note that this patch won't actually affect the behavior of the 
; non- x-position-dependent p-switches included with the baserom.
; I'm working on fixing those, too.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;no pressed P-Switch Carry
;made by Deflaktor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

if read1($00FFD5) == $23
  sa1rom
  !addr = $6000
  !163E = $33FA
else
  lorom
  !addr = $0000
  !163E = $163E
endif

org $01AA5E
;LDA $1470		;\ replaced code
;ORA $187A		;/

autoclean JSL Main	;hijack the routine which checks if you can carry the sprite
;NOP #2
BRA LessCycles
LessCycles:
;there will be a branch

freedata

Main:	LDA $1470|!addr	;\ restore replaced piece of code
	ORA $187A|!addr	;/
	ORA !163E,x	;OR it with the timer the smashed pow remains
	RTL