if read1($00FFD5) == $23
	sa1rom
	!addr	= $6000
	!bank	= $000000
else
	lorom
	!addr	= $0000
	!bank	= $800000
endif

;------------------------------------------------------------------
; Settings, modify them if you like.
; (note that if you use AMK, you should edit AMK's tweaks.asm and
; re-run AMK, as the SFX define won't work by default)
;------------------------------------------------------------------

!GFX_FILE	= $BD		; GFX/ExGFX file to use for logo (00-FF)
!SFX		= $01		; Sound effect for logo
!SFX_BANK	= $1DFC		; Sound effect bank for logo
!PAL		= $06		; Palette/gfx page: 00 = default, next palette is 02,04,06 etc...
!TIME		= $40		; Time until fadeout

;------------------------------------------------------------------

org $00939A|!bank
	LDY #$3C
	LDX #$0F		; Amount of entries for properties below

LoadTiles:
	autoclean JML nintendologo

org $0093B4|!bank
	DEY #4
	DEX
	BPL LoadTiles
	autoclean JML oamfinish

org $00A9CD|!bank
	db !GFX_FILE

if read3($0E8001) != $4B4D41	;"AMK"
org $0093C0
	LDA #!SFX		; SFX
	STA !SFX_BANK|!addr
endif

;-------------------------;
;graphics routine for logo;
;-------------------------;

freedata

xlogo:
	db $60,$70,$80,$90
	db $60,$70,$80,$90
	db $60,$70,$80,$90
	db $60,$70,$80,$90

ylogo:
	db $50,$50,$50,$50
	db $60,$60,$60,$60
	db $70,$70,$70,$70
	db $80,$80,$80,$80

tlogo:
	db $02,$04,$06,$08
	db $22,$24,$26,$28
	db $42,$44,$46,$48
	db $62,$64,$66,$68

nintendologo:
	LDA.l xlogo,x		;\ Xpos
	STA $0200|!addr,y	;/
	LDA.l ylogo,x		;\ Ypos
	STA $0201|!addr,y	;/
	LDA.l tlogo,x		;\ Tile number
	STA $0202|!addr,y	;/

flip:
	LDA #$30		; Base properties
	ORA #!PAL		; Add palette settings
	STA $0203|!addr,y	; Store

	LDA #!TIME		; Time till fadeout
	STA $1DF5|!addr
	JML $0093B4|!bank	; Jump back

oamfinish:
	LDA #$AA		;\
	STA $0403|!addr		; |
	STA $0402|!addr		; | Tilesize (8x8 or 16x16) for tiles
	STA $0401|!addr		; |
	STA $0400|!addr		;/
	JML $0093C0|!bank	;Jump back
