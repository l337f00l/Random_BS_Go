; by TheBiob 


main:
	LDX #!sprite_slots-1
-	LDA !14C8,x
	BEQ +
	LDA !9E,x
	CMP #$0F ; goomba sprite number
	BNE +
	LDA !1540,x
	INC
	BNE +
	LDA #$30 ; stun timer length
	STA !1540,x
+	DEX : BPL -
	RTL