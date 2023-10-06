;~@sa1
	LDA $0A				; Tells the game which block to destroy. Load contents of scratch memory 0A into A.
	AND #$F0			; Set the four highest bits in the value.
	STA $9A				; Save the results into 9A (X position of collision point between Mario and blocks, low byte)
	LDA $0B				; Load contents of scratch memory 0B into A.
	STA $9B				; Save the results into 9B (X position of collision point between Mario and blocks, high byte)
	LDA $0C				; Load contents of scratch memory 0C into A.
	AND #$F0			; Set the four highest bits in the value.
	STA $98				; Save the results into 98 (Y position of collision point between Mario and blocks, low byte)
	LDA $0D				; Load contents of scratch memory 0D into A.
	STA $99				; Save the results into 99 (Y position of collision point between Mario and blocks, high byte)
	RTL	
	
