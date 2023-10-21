incsrc "asm/work/library.asm"
incsrc "../../OtherUberASMStuff/macro_library.asm"
!level_nmi	= 0
!overworld_nmi	= 0
!gamemode_nmi	= 1
!global_nmi	= 0

!sprite_RAM	= $7FAC80

autoclean $90A792
autoclean $9EFF23
autoclean $96D104
autoclean $96D67C
autoclean $9CFEEA
autoclean $96CFBA
autoclean $96D060
autoclean $96D0FF
autoclean $96D0A8
autoclean $96D15E
autoclean $96D621
autoclean $96D677
autoclean $9CFEDF
autoclean $96D689
autoclean $96DF89
autoclean $96DF10
autoclean $9CFF1B
autoclean $96FEB3
autoclean $98FFC6
autoclean $96F26B
autoclean $9EF96B
autoclean $9FFC22
autoclean $99FFA9
autoclean $9AFF5A
autoclean $A1A67C
autoclean $9EFFE6
autoclean $9EF9A1
autoclean $9FFC6B
autoclean $96E409
autoclean $9FFCB9
autoclean $96FE9E
autoclean $98FFB1
autoclean $96F260
autoclean $9EF966
autoclean $9AFF59
autoclean $A1A639
autoclean $9EFFC7
autoclean $9FFC65
autoclean $96FFF1
autoclean $96E5B8
autoclean $9AFF6F
autoclean $96FFEC
autoclean $96E5B3
autoclean $9DFF65
autoclean $96E9F0
autoclean $96CE15
autoclean $93FFF2
autoclean $97FF87
autoclean $A5DDAA
autoclean $A5DA61
autoclean $AEA826
autoclean $95FF9F
autoclean $9FFBA0
autoclean $96FC29
autoclean $96F996
autoclean $A5D638
autoclean $9784AC
autoclean $9EF854
autoclean $9AFF3A
autoclean $96FFA5
autoclean $95FF7B
autoclean $9DFEF6
autoclean $92FFF1
autoclean $92FFDF
autoclean $90FFF3
autoclean $90FFC0
autoclean $9CFE6E
autoclean $90D827
autoclean $90FFB7
autoclean $96EEF1

!previous_mode = !sprite_RAM+(!sprite_slots*3)

incsrc level.asm
incsrc overworld.asm
incsrc gamemode.asm
incsrc global.asm
incsrc sprites.asm
incsrc statusbar.asm


print freespaceuse
