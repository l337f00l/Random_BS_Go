incsrc "asm/work/library.asm"
incsrc "../../OtherUberASMStuff/macro_library.asm"
!level_nmi	= 0
!overworld_nmi	= 0
!gamemode_nmi	= 1
!global_nmi	= 0

!sprite_RAM	= $7FAC80

autoclean $90A7A0
autoclean $A1A888
autoclean $A1A931
autoclean $A1A954
autoclean $A1A96C
autoclean $96EA0E
autoclean $96EF14
autoclean $A1A92C
autoclean $96F28B
autoclean $A1A93E
autoclean $96F9B5
autoclean $A1A94F
autoclean $A1A961
autoclean $96FC60
autoclean $A1A9AA
autoclean $96FEE1
autoclean $A1A99D
autoclean $A1A9D0
autoclean $A1AA02
autoclean $A1AA2A
autoclean $A1AA4C
autoclean $A1AA82
autoclean $A1AAC5
autoclean $A1AAE4
autoclean $A1AB59
autoclean $A1FC99
autoclean $A1FCB6
autoclean $9784E9
autoclean $A1FCFC
autoclean $A1A9BB
autoclean $A1A9ED
autoclean $A1AA1F
autoclean $A1AA47
autoclean $A1AAE3
autoclean $A1AB16
autoclean $A1FC7A
autoclean $A1FCD6
autoclean $A1FCEE
autoclean $A1AAF9
autoclean $A1FCD1
autoclean $A1FCE9
autoclean $A1A834
autoclean $A1A81C
autoclean $A1A7F4
autoclean $90D7F4
autoclean $A1A7AF
autoclean $ADF284
autoclean $90D78E
autoclean $90BE96
autoclean $90B720
autoclean $90B699
autoclean $90867F
autoclean $90B5CC
autoclean $90B575
autoclean $90B458
autoclean $90B42A
autoclean $90B3E5
autoclean $908660
autoclean $90B34B
autoclean $908652
autoclean $908640
autoclean $908112
autoclean $908106
autoclean $90B2AB
autoclean $9080F9
autoclean $9080F0
autoclean $9080D6

!previous_mode = !sprite_RAM+(!sprite_slots*3)

incsrc level.asm
incsrc overworld.asm
incsrc gamemode.asm
incsrc global.asm
incsrc sprites.asm
incsrc statusbar.asm


print freespaceuse
