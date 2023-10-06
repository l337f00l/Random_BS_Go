; This file contains all the data for your fonts.

; look for "WHEN ADDING FONTS" for a rough idea of how to add stuff

                  ; WHEN ADDING FONTS:
prot ktgLatin ; , myNewFontGfx, myNewFont2Latin, ...

fontPtrs:
	dw ktGothic               ; $00
	dw message                ; $01
	dw status                 ; $02
	; WHEN ADDING FONTS:
	; dw myNewFont            ; $03
	; dw myNewFont2           ; $04
	; ...

; offsets for data in a font header.
; a font consists of 4 header bytes,
; plus (!FONT_END/256)+1 pointers to graphics for each 256-character "page"
; note that the number of characters in !FONT_CHARS includes unsupported pages,
; so if you look at KT Gothic as an example you will see it claims $ffff chars
; but most of the pages are %pgofs(0) to mark them as unsupported
!FONT_FALLBACK = 0  ; header: font id to use for characters not in this font
!FONT_SPACING  = 1  ; header: number of pixels between letters
!FONT_CHARS    = 2  ; header: number of characters in this font
!FONT_PAGES    = 4  ; table of ptrs to page gfx: !FONT_CHARS*2 bytes

macro pgofs(pageloc)
	dw <pageloc>>>8
endmacro

macro asciifont(gfx, fallback, letterSpace)
	db <fallback>
	db <letterSpace>
	dw $0080
	%pgofs(<gfx>)
endmacro

macro latinfont(gfx, fallback, letterSpace)
	db <fallback>
	db <letterSpace>
	dw $0100
	%pgofs(<gfx>)
endmacro

ktGothic:
	; header
	db -1     ; KT Gothic has no fallbacks
	db 1      ; 1px letter spacing
	dw $ffff  ; last supported page is FFxx
	; page pointers
	%pgofs(ktgLatin)       ; 00xx
	%pgofs(0)              ; 01xx
	%pgofs(0)              ; 02xx
	%pgofs(0)              ; 03xx
	%pgofs(0)              ; 04xx
	%pgofs(0)              ; 05xx
	%pgofs(0)              ; 06xx
	%pgofs(0)              ; 07xx
	%pgofs(0)              ; 08xx
	%pgofs(0)              ; 09xx
	%pgofs(0)              ; 0Axx
	%pgofs(0)              ; 0Bxx
	%pgofs(0)              ; 0Cxx
	%pgofs(0)              ; 0Dxx
	%pgofs(0)              ; 0Exx
	%pgofs(0)              ; 0Fxx
	%pgofs(0)              ; 10xx
	%pgofs(0)              ; 11xx
	%pgofs(0)              ; 12xx
	%pgofs(0)              ; 13xx
	%pgofs(0)              ; 14xx
	%pgofs(0)              ; 15xx
	%pgofs(0)              ; 16xx
	%pgofs(0)              ; 17xx
	%pgofs(0)              ; 18xx
	%pgofs(0)              ; 19xx
	%pgofs(0)              ; 1Axx
	%pgofs(0)              ; 1Bxx
	%pgofs(0)              ; 1Cxx
	%pgofs(0)              ; 1Dxx
	%pgofs(0)              ; 1Exx
	%pgofs(0)              ; 1Fxx
	%pgofs(ktgPunct)       ; 20xx
	%pgofs(0)              ; 21xx
	%pgofs(0)              ; 22xx
	%pgofs(0)              ; 23xx
	%pgofs(0)              ; 24xx
	%pgofs(0)              ; 25xx
	%pgofs(0)              ; 26xx
	%pgofs(0)              ; 27xx
	%pgofs(0)              ; 28xx
	%pgofs(0)              ; 29xx
	%pgofs(0)              ; 2Axx
	%pgofs(0)              ; 2Bxx
	%pgofs(0)              ; 2Cxx
	%pgofs(0)              ; 2Dxx
	%pgofs(0)              ; 2Exx
	%pgofs(0)              ; 2Fxx
	%pgofs(0)              ; 30xx
	%pgofs(0)              ; 31xx
	%pgofs(0)              ; 32xx
	%pgofs(0)              ; 33xx
	%pgofs(0)              ; 34xx
	%pgofs(0)              ; 35xx
	%pgofs(0)              ; 36xx
	%pgofs(0)              ; 37xx
	%pgofs(0)              ; 38xx
	%pgofs(0)              ; 39xx
	%pgofs(0)              ; 3Axx
	%pgofs(0)              ; 3Bxx
	%pgofs(0)              ; 3Cxx
	%pgofs(0)              ; 3Dxx
	%pgofs(0)              ; 3Exx
	%pgofs(0)              ; 3Fxx
	%pgofs(0)              ; 40xx
	%pgofs(0)              ; 41xx
	%pgofs(0)              ; 42xx
	%pgofs(0)              ; 43xx
	%pgofs(0)              ; 44xx
	%pgofs(0)              ; 45xx
	%pgofs(0)              ; 46xx
	%pgofs(0)              ; 47xx
	%pgofs(0)              ; 48xx
	%pgofs(0)              ; 49xx
	%pgofs(0)              ; 4Axx
	%pgofs(0)              ; 4Bxx
	%pgofs(0)              ; 4Cxx
	%pgofs(0)              ; 4Dxx
	%pgofs(0)              ; 4Exx
	%pgofs(0)              ; 4Fxx
	%pgofs(0)              ; 50xx
	%pgofs(0)              ; 51xx
	%pgofs(0)              ; 52xx
	%pgofs(0)              ; 53xx
	%pgofs(0)              ; 54xx
	%pgofs(0)              ; 55xx
	%pgofs(0)              ; 56xx
	%pgofs(0)              ; 57xx
	%pgofs(0)              ; 58xx
	%pgofs(0)              ; 59xx
	%pgofs(0)              ; 5Axx
	%pgofs(0)              ; 5Bxx
	%pgofs(0)              ; 5Cxx
	%pgofs(0)              ; 5Dxx
	%pgofs(0)              ; 5Exx
	%pgofs(0)              ; 5Fxx
	%pgofs(0)              ; 60xx
	%pgofs(0)              ; 61xx
	%pgofs(0)              ; 62xx
	%pgofs(0)              ; 63xx
	%pgofs(0)              ; 64xx
	%pgofs(0)              ; 65xx
	%pgofs(0)              ; 66xx
	%pgofs(0)              ; 67xx
	%pgofs(0)              ; 68xx
	%pgofs(0)              ; 69xx
	%pgofs(0)              ; 6Axx
	%pgofs(0)              ; 6Bxx
	%pgofs(0)              ; 6Cxx
	%pgofs(0)              ; 6Dxx
	%pgofs(0)              ; 6Exx
	%pgofs(0)              ; 6Fxx
	%pgofs(0)              ; 70xx
	%pgofs(0)              ; 71xx
	%pgofs(0)              ; 72xx
	%pgofs(0)              ; 73xx
	%pgofs(0)              ; 74xx
	%pgofs(0)              ; 75xx
	%pgofs(0)              ; 76xx
	%pgofs(0)              ; 77xx
	%pgofs(0)              ; 78xx
	%pgofs(0)              ; 79xx
	%pgofs(0)              ; 7Axx
	%pgofs(0)              ; 7Bxx
	%pgofs(0)              ; 7Cxx
	%pgofs(0)              ; 7Dxx
	%pgofs(0)              ; 7Exx
	%pgofs(0)              ; 7Fxx
	%pgofs(0)              ; 80xx
	%pgofs(0)              ; 81xx
	%pgofs(0)              ; 82xx
	%pgofs(0)              ; 83xx
	%pgofs(0)              ; 84xx
	%pgofs(0)              ; 85xx
	%pgofs(0)              ; 86xx
	%pgofs(0)              ; 87xx
	%pgofs(0)              ; 88xx
	%pgofs(0)              ; 89xx
	%pgofs(0)              ; 8Axx
	%pgofs(0)              ; 8Bxx
	%pgofs(0)              ; 8Cxx
	%pgofs(0)              ; 8Dxx
	%pgofs(0)              ; 8Exx
	%pgofs(0)              ; 8Fxx
	%pgofs(0)              ; 90xx
	%pgofs(0)              ; 91xx
	%pgofs(0)              ; 92xx
	%pgofs(0)              ; 93xx
	%pgofs(0)              ; 94xx
	%pgofs(0)              ; 95xx
	%pgofs(0)              ; 96xx
	%pgofs(0)              ; 97xx
	%pgofs(0)              ; 98xx
	%pgofs(0)              ; 99xx
	%pgofs(0)              ; 9Axx
	%pgofs(0)              ; 9Bxx
	%pgofs(0)              ; 9Cxx
	%pgofs(0)              ; 9Dxx
	%pgofs(0)              ; 9Exx
	%pgofs(0)              ; 9Fxx
	%pgofs(0)              ; A0xx
	%pgofs(0)              ; A1xx
	%pgofs(0)              ; A2xx
	%pgofs(0)              ; A3xx
	%pgofs(0)              ; A4xx
	%pgofs(0)              ; A5xx
	%pgofs(0)              ; A6xx
	%pgofs(0)              ; A7xx
	%pgofs(0)              ; A8xx
	%pgofs(0)              ; A9xx
	%pgofs(0)              ; AAxx
	%pgofs(0)              ; ABxx
	%pgofs(0)              ; ACxx
	%pgofs(0)              ; ADxx
	%pgofs(0)              ; AExx
	%pgofs(0)              ; AFxx
	%pgofs(0)              ; B0xx
	%pgofs(0)              ; B1xx
	%pgofs(0)              ; B2xx
	%pgofs(0)              ; B3xx
	%pgofs(0)              ; B4xx
	%pgofs(0)              ; B5xx
	%pgofs(0)              ; B6xx
	%pgofs(0)              ; B7xx
	%pgofs(0)              ; B8xx
	%pgofs(0)              ; B9xx
	%pgofs(0)              ; BAxx
	%pgofs(0)              ; BBxx
	%pgofs(0)              ; BCxx
	%pgofs(0)              ; BDxx
	%pgofs(0)              ; BExx
	%pgofs(0)              ; BFxx
	%pgofs(0)              ; C0xx
	%pgofs(0)              ; C1xx
	%pgofs(0)              ; C2xx
	%pgofs(0)              ; C3xx
	%pgofs(0)              ; C4xx
	%pgofs(0)              ; C5xx
	%pgofs(0)              ; C6xx
	%pgofs(0)              ; C7xx
	%pgofs(0)              ; C8xx
	%pgofs(0)              ; C9xx
	%pgofs(0)              ; CAxx
	%pgofs(0)              ; CBxx
	%pgofs(0)              ; CCxx
	%pgofs(0)              ; CDxx
	%pgofs(0)              ; CExx
	%pgofs(0)              ; CFxx
	%pgofs(0)              ; D0xx
	%pgofs(0)              ; D1xx
	%pgofs(0)              ; D2xx
	%pgofs(0)              ; D3xx
	%pgofs(0)              ; D4xx
	%pgofs(0)              ; D5xx
	%pgofs(0)              ; D6xx
	%pgofs(0)              ; D7xx
	%pgofs(ktgPriv)        ; E0xx
	%pgofs(0)              ; F9xx
	%pgofs(0)              ; FAxx
	%pgofs(0)              ; FBxx
	%pgofs(0)              ; FCxx
	%pgofs(0)              ; FDxx
	%pgofs(0)              ; FExx
	%pgofs(ktgXWidth)      ; FFxx

message:
	%asciifont(messageGfx, $00, 1)

status:
	%asciifont(statusGfx, $00, 0)

; myNewFont:
;	%asciifont(myNewFontLatin, 1, $00)
; myNewFont2:
;	%latinfont(myNewFont2Latin, 1, $00)

pushpc
	freedata align
	ktgLatin:
		incbin "gfx/kt-gothic-latin.bin"
	ktgPunct:
		incbin "gfx/kt-gothic-punct.bin"
	ktgPriv:
		incbin "gfx/kt-gothic-private.bin"
	ktgXWidth:
		incbin "gfx/kt-gothic-x-width.bin"

	messageGfx:
		incbin "gfx/message-latin.bin"
	statusGfx:
		incbin "gfx/statusbar-latin.bin"

	; WHEN ADDING FONTS:
	; myNewFontGfx:
	;	incbin "mynewfont.bin"
	; myNewFont2Latin:
	;	incbin "mynewfont2-latin.bin"
	; ...
	; if you run out of space, throw in a "freedata align"
	; and make sure to add the next file to the `prot` up top
pullpc
