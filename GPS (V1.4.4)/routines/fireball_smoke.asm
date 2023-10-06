;Usage: %fireball_smoke()

	PHY
	PHP
	SEP #$30
	
	LDY #$03
.loop   LDA $17C0,y
	BEQ .found
	
	DEY
	BPL .loop
	BRA +

.found	LDA #$01
	STA $17C0,y
	
	LDA $1715,x
	STA $17C4,y
	
	LDA $171F,x
	STA $17C8,y
	
	LDA #$18
	STA $17CC,y
	
+	PLP
	PLY
	RTL