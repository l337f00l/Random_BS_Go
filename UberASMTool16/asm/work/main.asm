incsrc "asm/work/library.asm"
incsrc "../../OtherUberASMStuff/macro_library.asm"
!level_nmi	= 0
!overworld_nmi	= 0
!gamemode_nmi	= 1
!global_nmi	= 0

!sprite_RAM	= $7FAC80

autoclean $90A792
autoclean $9DFE6D
autoclean $96D065
autoclean $96D088
autoclean $96D5F4
autoclean $96C924
autoclean $96CE0A
autoclean $96D060
autoclean $96CE17
autoclean $96D072
autoclean $96CFB8
autoclean $96D083
autoclean $96D5E9
autoclean $96D095
autoclean $96D0A2
autoclean $96D0FD
autoclean $96D625
autoclean $96D683
autoclean $96EED1
autoclean $96E9DD
autoclean $96FE9D
autoclean $96FF78
autoclean $96D156
autoclean $96DF69
autoclean $9DFF68
autoclean $9784BB
autoclean $96F254
autoclean $9AFF00
autoclean $A1BDBC
autoclean $96DB99
autoclean $96FC20
autoclean $96D66E
autoclean $96EEBC
autoclean $96E9D2
autoclean $96FE98
autoclean $96DF68
autoclean $9DFF25
autoclean $97849C
autoclean $9AFEFA
autoclean $A1BD57
autoclean $96F977
autoclean $96F98F
autoclean $96DF7E
autoclean $96F972
autoclean $96F98A
autoclean $96C90C
autoclean $96C8E4
autoclean $95FF42
autoclean $96C89F
autoclean $A3AD8F
autoclean $9FFC45
autoclean $A393B5
autoclean $96C887
autoclean $96C800
autoclean $96C719
autoclean $95FF99
autoclean $A1BB25
autoclean $96C6E1
autoclean $96C5C4
autoclean $96C596
autoclean $95FF2E
autoclean $93FFDF
autoclean $96C4F6
autoclean $92FFEF
autoclean $92FFDD
autoclean $92FFBB
autoclean $92FFAF
autoclean $96C456
autoclean $90D827
autoclean $90D647
autoclean $95FEF4

!previous_mode = !sprite_RAM+(!sprite_slots*3)

incsrc level.asm
incsrc overworld.asm
incsrc gamemode.asm
incsrc global.asm
incsrc sprites.asm
incsrc statusbar.asm


print freespaceuse
