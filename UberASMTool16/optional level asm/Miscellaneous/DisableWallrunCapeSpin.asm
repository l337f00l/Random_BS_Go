main:
LDA $13E3|!addr 		;\ If Player is wall-running
BEQ +					;/
LDA #$40				;\ Disable pressing X/Y
TRB $16	
RTL