arch spc700-raw

org $000000
incsrc "asm/main.asm"
base $23E7

org $008000


	!volume = $BF		
	!timer = $10		
	
	mov $58, #!timer	
	mov $59, #!volume	

	ret
