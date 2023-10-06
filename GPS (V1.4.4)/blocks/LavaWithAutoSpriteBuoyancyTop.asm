;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Sprite Buoyancy Lava Blocks - by dtothefourth
;
; Acts like lava for sprites even if sprite
; buoyancy is disabled in the sprite header
;
; Use act as 25 to be lava for sprites only
; Or act as 5 to also be lava for Mario
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


db $37

JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH
JMP Cape : JMP Fireball
JMP MarioCorner : JMP MarioBody : JMP MarioHead
JMP WallFeet : JMP WallBody

MarioBelow:
MarioAbove:
MarioSide:
MarioCorner:
MarioBody:
MarioHead:
WallFeet:
WallBody:
JSL $00F606   ; Kill instead of hurt
Cape:
Fireball:
RTL

SpriteV:
SpriteH:
	LDA #$80
	STA !164A,x

	LDA !14C8,X
	CMP #$08
	BNE ++
	LDA !9E,X				  ; \ Branch if sprite == Yoshi 
	CMP.B #$35				  ;  | 
	BEQ +					  ; / 
	LDA.W !167A,X   ; \ Branch if lava immune 
	AND.B #$02                ;  | is set 
	BNE ++                    ; / 
	+
	LDA.B #$05                ; \ dying in lava 
	STA.W !14C8,X             ; / 
	LDA.B #$40                
	STA.W !1558,X    
	++
	RTL

print "This is like the normal lava, except Mario can't swim in the top of it, and it automatically has buoyancy for sprites, without having to enable this in Lunar Magic."