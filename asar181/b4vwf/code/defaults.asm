!vitorSA1 = 0
if read1($00ffd5) == $23
	!vitorSA1 = 1
endif

if !vitorSA1 == 0
	lorom
	!freeram = $7fb600
	!WB = $0000
	!DP = $0000
	!FR = $800000
else
	sa1rom
	!freeram = $40c400
	!WB = $6000
	!DP = $3000
	!FR = $000000
	!sa1irqctl = $001d02
	!sa1irqptr = $001d04
endif
