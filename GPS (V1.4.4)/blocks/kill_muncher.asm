;Block by JackTheSpades
;
;Kills the player instantly regardless of powerup, unless he has a star or is riding Yoshi and touches the block from the top
;Pretty much like an instant kill muncher.
;
;Credit? For 14 lines of code? I don't care.

db $42
JMP Mario : JMP MarioAbove : JMP Mario
JMP Return : JMP Return
JMP Return : JMP Return
JMP MarioAbove : JMP Mario : JMP Mario

MarioAbove:
	LDA $187A|!addr	;Is player riding yoshi? \  
	BNE Return	;If yes, skip		 / 
Mario:
	LDA $1490|!addr	;is the star timer set?  \ 
	BNE Return	;if yes, skip		 / 
	JSL $00F606|!bank	;if no,...KILL!!!
Return:
	RTL

print "Kills player, even if you're big Mario or have a powerup"