;==============================================================================
; Simple customizations for messages in levels
;==============================================================================
; Font number of the default font.
; Look in "font.asm" for info on which font numbers map to which fonts,
; as well as how to add your own fonts.
!LVL_FONT = $00

; Set to 0 if your hack has a patch to remove the status bar
; not guaranteed to work with all patches that remove the status bar,
; but known to work with `nuke_statusbar.asm`
!HAS_STATUS_BAR = 0

; How wide a line is, in pixels.
; Wider lines take up more VRAM.
; Going wider than 224 is not recommended because some displays don't show
; the edges of the screen, so text right at the edge will be cut off.
; (that includes the display used by this patch's author to play SNES games...)
!LVL_WIDTH = 224

; Number of lines of text in the message box.
; More lines take up more VRAM.
; Note that this is only the default; you can make individual messages
; smaller or larger if you wish.
; (although if you make them larger you may run into problems)
; Technical note: one line is 64 + !LVL_WIDTH * 16 bytes.
!LVL_LINES = 4

; How many pixels of black space go above and below the message box.
!PADDING = 4

; Where the top of the message box should be on the screen, in pixels,
; 0 = top of screen.
!LVL_POS_Y = 64

; If you set this to a number other than 0,
; the patch will use the !SPACING_CHANNEL as an hdma
; channel to put a !LINE_SPACING-pixel gap between lines in message boxes.
; This doesn't use any extra VRAM, but it does use an HDMA channel.
; The HDMA channel is only used in levels with message boxes.
; The main reason you'd use this is so you can make taller fonts look nice,
; since !LINE_SPACING >= 1 will always put a gap between letters
; above and below one another even if they are both 8px tall.
; Default is 0 to avoid wasting an HDMA channel for those who don't want it.
!LINE_SPACING = 0
!SPACING_CHANNEL = 6

; How fast the message box expands.
; $ff makes it expand instantly; $01 takes about two seconds.
; $00 causes a crash, and isn't recommended.
!GROW_SPEED = $20

; Color number where the palette for message boxes goes.
; Valid values: $60, $64, $68, $6c, $70, $74, $78, $7c
; The message box uses 4 colors starting here;
; $60 is not recommended because of the glowing color.
!LVL_PALETTE = $7c

;==============================================================================
; Simple customizations for overworld level names
;==============================================================================
; vwf level names on the overworld. 0: disable, 1: enable
!OVERWORLD = 1

!OW_FONT = $01

; Number of lines of text in level names.
!OW_LINES = 2
; How wide a line is, in pixels.
; Wider lines take up more VRAM.
!OW_WIDTH = 256

; Where the top and left of the level name should be on the screen, in pixels,
; (0, 0) = left edge, top of screen.
; Default is one row above SMW's space for level names.
!OW_POS_X = 16
!OW_POS_Y = 14

; Set this to 1 to remove the walking Mario from the overworld.
; If you do this, you will probably want to change !OW_WIDTH
; and !OW_POS_X to take advantage of the new space
; (recommended: !OW_WIDTH = 28, !OW_POS_X = 16)
!OW_REMOVE_MARIO = 1

; Color number where the palette for message boxes goes.
; Valid values: $00, $04, $08, $0c, $10, $14, $18, $1c
; The level name text uses 4 colors starting here.
!OW_PALETTE = $18

;==============================================================================
; Technical customizations
;------------------------------------------------------------------------------
; Most of these are probably within your reach if you put your mind to it,
; but if you don't put your mind to it they may break some things.
;==============================================================================

; A 256 byte block of free RAM.
; This setting is commented because the default is chosen automatically based
; on whether your hack is SA-1.
; Uncomment this setting to override the default and set it yourself;
; make sure to use a bank $40 or $41 address on SA-1 ROMs.
; S-CPU default is $7fb600
; SA-1 default is $40c400

; !freeram = $7fb600

; Where in VRAM to put the message box in levels.
; A message box with default settings needs 2KiB = $800 bytes = 1 L3 gfx file.
; This should be divisible by $40 (64).
; Wherever you put this, you won't be able to use whatever's there
; in the same level as a message box.
; The default is LG3, which original SMW only uses for message boxes,
; some stuff on the title screen, and the graphics for the layer 3 water
; Some VRAM locations for your consideration:
; $8000: LG1
; $8800: LG2
; $9000: LG3
; $9800: LG4
; $a000: BG3 tilemap, upper left quadrant (with the status bar)
; $a800: BG3 tilemap, upper right quadrant
; $b000: BG3 tilemap, lower left quadrant
; $b800: BG3 tilemap, lower right quadrant
; If you know ASM, you can use $2109 to make the BG3 tilemap smaller,
; and then some space will be free even in levels that do use layer 3 BGs,
; although (obviously) the BGs will need to be smaller.
!LVL_VRAM = $9000

; Where in VRAM to put the level names on the overworld.
; Level names with default settings need 1KiB = $400 bytes = 0.5 L3 gfx file.
; Default is part of the layer 3 tilemap which is never shown on the overworld
; in vanilla SMW.
!OW_VRAM = $b800

; Set to 1 to use a dynamic palette for the message box; set to 0 to
; use the level's palette.
; If you set this to 0, make sure to add colors to the level's palette;
; the default text color is 7F, which is black in the vanilla palettes
; resulting in black text on a black background.
; When using a dynamic palette, the message box colors effectively take up
; 0 space in the level's palette.
; However, you may need to use "Palette + Working" for your exanimations
; instead of just "Palette", and some custom stuff might break.
; To change the palette itself, use Lunar Magic to edit
; colors $7c-$7f in "palette.mw3".
!DYNAMIC_PALETTE = 1
