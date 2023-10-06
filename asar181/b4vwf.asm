;==============================================================================
; User settings & definitions
;==============================================================================
incsrc "b4vwf/code/defaults.asm"
incsrc "b4vwf/settings.asm"
incsrc "b4vwf/code/checksettings.asm"
incsrc "b4vwf/code/msgmacros.asm"

;==============================================================================
; Derived definitions
;==============================================================================

; detects the windowing hdma channel change on newer versions of the sa-1 pack
; this particular address was chosen for read1 bc it's message code, so there
; probably won't be much touching it other than sa-1 and this patch
!WINDOW_BYTE #= read1($05b295)
!WINDOW_CHANNEL #= 0
while !WINDOW_BYTE&1 != 1
	!WINDOW_BYTE #= !WINDOW_BYTE>>1
	!WINDOW_CHANNEL #= !WINDOW_CHANNEL+1
endif

; IRQ takes a bit longer to get where we want in the sa-1 pack
if !vitorSA1 == 0
	!IRQ_OFS #= 0
else
	!IRQ_OFS #= -2
endif

!WINDOW_LEFT     #= 128-(!LVL_WIDTH/2)-1
!WINDOW_R_MAX    #= 128+(!LVL_WIDTH/2)
!BG4_TM          #= !LVL_VRAM&$f800
!BG4_GFX         #= !LVL_VRAM&$e000
!BG4_POS_X       #= -!WINDOW_LEFT
!BG4_PALETTE     #= (!LVL_PALETTE/4)&7

!DFLT_PROPS      #= $2000|(!BG4_PALETTE<<10)

!msgPtr          #= !freeram
!msgWaiting      #= !freeram+3
!drawPos         #= !freeram+4
!maskPos         #= !freeram+6
!tmVAddr         #= !freeram+8
!charId          #= !freeram+10
!textProps       #= !freeram+12
!charVAddr       #= !freeram+14
!lineNumber      #= !freeram+16
!maxLines        #= !freeram+17
!fontDataPtr     #= !freeram+18
!lineWidth       #= !freeram+20
!exitType        #= !freeram+22
!exitScreen      #= !freeram+23
!spacingIdx      #= !freeram+24
!isOw            #= !freeram+25
!bg4ofs          #= !freeram+26
!irqTop          #= !freeram+28 ; sometimes accessed 16-bit
!irqBtm          #= !freeram+30 ; never accessed 16-bit
!chBuf           #= !freeram+32
; second biggest user of freeram in the patch: the HDMA table used for
; !LINE_SPACING (if it is enabled), which can take up about 80 bytes in
; the worst case of a 24-line message box and !LINE_SPACING = 1
!spacingHdma     #= !freeram+32+32
; this is used when loading the overworld to draw the name of the first level,
; so it doesn't have to be drawn one letter at a time after the map loads
; (which isn't like, wrong, but looks super tacky)
; it needs to be able to fit a whole line at once instead of just two tiles
; !chBuf and is actually the biggest use of freeram by this patch;
; the long a line can be is 32 tiles * 16 bytes/tile = 512 bytes, but the
; longest a line *should* be is 28 tiles * 16 bytes/tile = 480 bytes
!owLineBuf       #= !chBuf



; smh @ stripe images' big endian nonsense
function xb(x) = (((x)&$ff)<<8)|(((x)>>8)&$ff)

!mask      #= !WB|$04a0
!stimIdx   = $7f837b
!stimTable = $7f837d

;==============================================================================
; Hijacks
;==============================================================================
org !FR|$05b10d
	autoclean jml LvlDispatch
	autoclean jml MsgPtrs

org !FR|$05b11b
MsgEndRetp:
	phk : plb
	; ...

org !FR|$05b16e
	plb : rtl

; don't ruin HDMA
org !FR|$05b129
	bra + : nop : +

org !FR|$05b296
	tsb !WB|$0d9f

if !OVERWORLD
	org $03bb20
		phb
		jsl InitLevelName
		jmp $bb6e

	org $0485ca
		jsl OwDispatch
		nop
		if !OW_REMOVE_MARIO
			bra + : nop #2 : +
		endif
endif

;==============================================================================
; Text data
;==============================================================================
freedata
prot TEXT_LVL, TEXT_OW

MsgPtrs:
	dl lvl000_1, lvl000_2, lvl001_1, lvl001_2, lvl002_1, lvl002_2, lvl003_1, lvl003_2
	dl lvl004_1, lvl004_2, lvl005_1, lvl005_2, lvl006_1, lvl006_2, lvl007_1, lvl007_2
	dl lvl008_1, lvl008_2, lvl009_1, lvl009_2, lvl00a_1, lvl00a_2, lvl00b_1, lvl00b_2
	dl lvl00c_1, lvl00c_2, lvl00d_1, lvl00d_2, lvl00e_1, lvl00e_2, lvl00f_1, lvl00f_2
	dl lvl010_1, lvl010_2, lvl011_1, lvl011_2, lvl012_1, lvl012_2, lvl013_1, lvl013_2
	dl lvl014_1, lvl014_2, lvl015_1, lvl015_2, lvl016_1, lvl016_2, lvl017_1, lvl017_2
	dl lvl018_1, lvl018_2, lvl019_1, lvl019_2, lvl01a_1, lvl01a_2, lvl01b_1, lvl01b_2
	dl lvl01c_1, lvl01c_2, lvl01d_1, lvl01d_2, lvl01e_1, lvl01e_2, lvl01f_1, lvl01f_2
	dl lvl020_1, lvl020_2, lvl021_1, lvl021_2, lvl022_1, lvl022_2, lvl023_1, lvl023_2
	dl lvl024_1, lvl024_2
	dl                     lvl101_1, lvl101_2, lvl102_1, lvl102_2, lvl103_1, lvl103_2
	dl lvl104_1, lvl104_2, lvl105_1, lvl105_2, lvl106_1, lvl106_2, lvl107_1, lvl107_2
	dl lvl108_1, lvl108_2, lvl109_1, lvl109_2, lvl10a_1, lvl10a_2, lvl10b_1, lvl10b_2
	dl lvl10c_1, lvl10c_2, lvl10d_1, lvl10d_2, lvl10e_1, lvl10e_2, lvl10f_1, lvl10f_2
	dl lvl110_1, lvl110_2, lvl111_1, lvl111_2, lvl112_1, lvl112_2, lvl113_1, lvl113_2
	dl lvl114_1, lvl114_2, lvl115_1, lvl115_2, lvl116_1, lvl116_2, lvl117_1, lvl117_2
	dl lvl118_1, lvl118_2, lvl119_1, lvl119_2, lvl11a_1, lvl11a_2, lvl11b_1, lvl11b_2
	dl lvl11c_1, lvl11c_2, lvl11d_1, lvl11d_2, lvl11e_1, lvl11e_2, lvl11f_1, lvl11f_2
	dl lvl120_1, lvl120_2, lvl121_1, lvl121_2, lvl122_1, lvl122_2, lvl123_1, lvl123_2
	dl lvl124_1, lvl124_2, lvl125_1, lvl125_2, lvl126_1, lvl126_2, lvl127_1, lvl127_2
	dl lvl128_1, lvl128_2, lvl129_1, lvl129_2, lvl12a_1, lvl12a_2, lvl12b_1, lvl12b_2
	dl lvl12c_1, lvl12c_2, lvl12d_1, lvl12d_2, lvl12e_1, lvl12e_2, lvl12f_1, lvl12f_2
	dl lvl130_1, lvl130_2, lvl131_1, lvl131_2, lvl132_1, lvl132_2, lvl133_1, lvl133_2
	dl lvl134_1, lvl134_2, lvl135_1, lvl135_2, lvl136_1, lvl136_2, lvl137_1, lvl137_2
	dl lvl138_1, lvl138_2, lvl139_1, lvl139_2, lvl13a_1, lvl13a_2, lvl13b_1, lvl13b_2
.upper:
	dl         msg001, msg002, msg003, msg004, msg005, msg006, msg007
	dl msg008, msg009, msg00a, msg00b, msg00c, msg00d, msg00e, msg00f
	dl msg010, msg011, msg012, msg013, msg014, msg015, msg016, msg017
	dl msg018, msg019, msg01a, msg01b, msg01c, msg01d, msg01e, msg01f
	dl msg020, msg021, msg022, msg023, msg024, msg025, msg026, msg027
	dl msg028, msg029, msg02a, msg02b, msg02c, msg02d, msg02e, msg02f
	dl msg030, msg031, msg032, msg033, msg034, msg035, msg036, msg037
	dl msg038, msg039, msg03a, msg03b, msg03c, msg03d, msg03e, msg03f
	dl msg040, msg041, msg042, msg043, msg044, msg045, msg046, msg047
	dl msg048, msg049, msg04a, msg04b, msg04c, msg04d, msg04e, msg04f
	dl msg050, msg051, msg052, msg053, msg054, msg055, msg056, msg057
	dl msg058, msg059, msg05a, msg05b, msg05c, msg05d, msg05e, msg05f
	dl msg060, msg061, msg062, msg063, msg064, msg065, msg066, msg067
	dl msg068, msg069, msg06a, msg06b, msg06c, msg06d, msg06e, msg06f
	dl msg070, msg071, msg072, msg073, msg074, msg075, msg076, msg077
	dl msg078, msg079, msg07a, msg07b, msg07c, msg07d, msg07e, msg07f
	dl msg080, msg081, msg082, msg083, msg084, msg085, msg086, msg087
	dl msg088, msg089, msg08a, msg08b, msg08c, msg08d, msg08e, msg08f
	dl msg090, msg091, msg092, msg093, msg094, msg095, msg096, msg097
	dl msg098, msg099, msg09a, msg09b, msg09c, msg09d, msg09e, msg09f
	dl msg0a0, msg0a1, msg0a2, msg0a3, msg0a4, msg0a5, msg0a6, msg0a7
	dl msg0a8, msg0a9, msg0aa, msg0ab, msg0ac, msg0ad, msg0ae, msg0af
	dl msg0b0, msg0b1, msg0b2, msg0b3, msg0b4, msg0b5, msg0b6, msg0b7
	dl msg0b8, msg0b9, msg0ba, msg0bb, msg0bc, msg0bd, msg0be, msg0bf
	dl msg0c0, msg0c1, msg0c2, msg0c3, msg0c4, msg0c5, msg0c6, msg0c7
	dl msg0c8, msg0c9, msg0ca, msg0cb, msg0cc, msg0cd, msg0ce, msg0cf
	dl msg0d0, msg0d1, msg0d2, msg0d3, msg0d4, msg0d5, msg0d6, msg0d7
	dl msg0d8, msg0d9, msg0da, msg0db, msg0dc, msg0dd, msg0de, msg0df
	dl msg0e0, msg0e1, msg0e2, msg0e3, msg0e4, msg0e5, msg0e6, msg0e7
	dl msg0e8, msg0e9, msg0ea, msg0eb, msg0ec, msg0ed, msg0ee, msg0ef
	dl msg0f0, msg0f1, msg0f2, msg0f3, msg0f4, msg0f5, msg0f6, msg0f7
	dl msg0f8, msg0f9, msg0fa, msg0fb, msg0fc, msg0fd, msg0fe, msg0ff


if !OVERWORLD
	levelNames:
		dl name000, name001, name002, name003, name004, name005, name006, name007
		dl name008, name009, name00a, name00b, name00c, name00d, name00e, name00f
		dl name010, name011, name012, name013, name014, name015, name016, name017
		dl name018, name019, name01a, name01b, name01c, name01d, name01e, name01f
		dl name020, name021, name022, name023, name024
		dl                                              name101, name102, name103
		dl name104, name105, name106, name107, name108, name109, name10a, name10b
		dl name10c, name10d, name10e, name10f, name110, name111, name112, name113
		dl name114, name115, name116, name117, name118, name119, name11a, name11b
		dl name11c, name11d, name11e, name11f, name120, name121, name122, name123
		dl name124, name125, name126, name127, name128, name129, name12a, name12b
		dl name12c, name12d, name12e, name12f, name130, name131, name132, name133
		dl name134, name135, name136, name137, name138, name139, name13a, name13b
endif

freedata
TEXT_LVL:
	incsrc "b4vwf/messages.asm"
TEXT_LVL_END:

freedata
TEXT_OW:
	if !OVERWORLD
		incsrc "b4vwf/levelnames.asm"
	endif
TEXT_OW_END:

;==============================================================================
; Patch code
;==============================================================================
freecode
CODE_START:
!codeK = (CODE_START&$ff0000)
incsrc "b4vwf/font.asm"

if !DYNAMIC_PALETTE
	paletteVals:
		incbin "b4vwf/palette.mw3":f8-100
endif

; these are like totally different, so rather than writing a confusing
; tangle of code littered with `if`s i have chosen to write two files
if !vitorSA1 == 0
	incsrc "b4vwf/code/irqnmi.asm"
else
	incsrc "b4vwf/code/irqnmi-sa1.asm"
endif
incsrc "b4vwf/code/draw-lvl.asm"

if !OVERWORLD
	incsrc "b4vwf/code/draw-ow.asm"
endif

incsrc "b4vwf/code/draw-shared.asm"

;==============================================================================
; Informative messages
;==============================================================================
; rounds up
function kib(n) = (((n)+1023)/1024)

print "Size of text data: ", dec(kib(TEXT_LVL_END-TEXT_LVL+(TEXT_OW_END-TEXT_OW))), "KiB"
