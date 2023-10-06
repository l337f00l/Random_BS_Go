; These tables determine which sprite tile and palette to use for the sprite status bar.
; Each element of the status bar needs one 16x16 tile reserved for it, but you can choose
; a different one for each level (for example, picking a tile that's unused in that level)
; if you don't want to reserve sprite space for the entire game.
; You can also disable each element individually (or all of them) by using a value of $0000 for the specific level.
; Note that these tables are ignored if !sprite_status_bar = 0 in "settings.asm".
; If you do want to enable one or more elements, specify the tile number to use as a 4 digit number:
; pick the tile in the Lunar Magic 8x8 editor, then subtract 0x400 from it (for example, tile 0x480 -> use $0080,
; tile 0x560 -> use $0160). And yes, any tile in SP1/2/3/4 can be used here.
;
; Additionally, the first digit in the number specifies the palette that will be used:
; 0 = palette 8, 1 = palette 9, etc. For example, $1080 means "use tile $80 (in SP2) with palette 9".
; It's suggested to use palette 8 for coins and timer (i.e., use 0 as the first digit) and palette B for
; the item box (i.e., use 3 as the first digit). Note that using palettes C-F will make the tiles affected
; by color math effects such as translucency and screen darkening effects.
; The default settings replace the berry, flopping fish and smiling coin tiles.
;
; NOTE: enabling the coin counter also enables the display of the Yoshi Coins collected.
; By default the Yoshi Coins are displayed with the same coin tile as the coin counter, but you can
; edit it to a different tile by editing the "gfx/coin.bin" file (the first tile is used for the coin counter,
; the second for the Yoshi Coins display).

item_box:
    ;    0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 000-00F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 010-01F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 020-02F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 030-03F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 040-04F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 050-05F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 060-06F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 070-07F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 080-08F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 090-09F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 0A0-0AF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 0B0-0BF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$0000,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 0C0-0CF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 0D0-0DF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 0E0-0EF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 0F0-0FF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 100-10F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 110-11F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 120-12F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 130-13F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 140-14F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 150-15F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 160-16F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 170-17F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 180-18F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 190-19F
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 1A0-1AF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 1B0-1BF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 1C0-1CF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 1D0-1DF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 1E0-1EF
    dw $3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080,$3080 ; 1F0-1FF

timer:
    ;    0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 000-00F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 010-01F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 020-02F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 030-03F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 040-04F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 050-05F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 060-06F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 070-07F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 080-08F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 090-09F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 0A0-0AF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 0B0-0BF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0000,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 0C0-0CF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 0D0-0DF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 0E0-0EF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 0F0-0FF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 100-10F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 110-11F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 120-12F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 130-13F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 140-14F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 150-15F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 160-16F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 170-17F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 180-18F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 190-19F
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 1A0-1AF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 1B0-1BF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 1C0-1CF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 1D0-1DF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 1E0-1EF
    dw $0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088,$0088 ; 1F0-1FF

coins:
    ;    0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 000-00F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 010-01F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 020-02F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 030-03F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 040-04F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 050-05F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 060-06F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 070-07F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 080-08F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 090-09F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 0A0-0AF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 0B0-0BF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$0000,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 0C0-0CF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 0D0-0DF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 0E0-0EF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 0F0-0FF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 100-10F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 110-11F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 120-12F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 130-13F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 140-14F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 150-15F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 160-16F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 170-17F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 180-18F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 190-19F
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 1A0-1AF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 1B0-1BF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 1C0-1CF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 1D0-1DF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 1E0-1EF
    dw $00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2,$00C2 ; 1F0-1FF