; Make sure we don't have any settings that are *guaranteed* to break something,
; or are logically incorrect in a way that indicates a misunderstanding on the
; part of the user

macro boolsetting(name)
	!<name> #= !<name>
	if !<name> != 0 && !<name> != 1
		error "\!<name> must be either 0 or 1 (it's currently !<name>)"
	endif
endmacro

; numerically evaluate all the settings so hopefully any weirdness a user
; might throw at us gets resolved
%boolsetting(OVERWORLD)
%boolsetting(HAS_STATUS_BAR)
%boolsetting(OW_REMOVE_MARIO)
!OVERWORLD       #= !OVERWORLD
!LVL_FONT        #= !LVL_FONT
!OW_FONT         #= !OW_FONT
!LVL_WIDTH       #= !LVL_WIDTH
!OW_WIDTH        #= !OW_WIDTH
!LVL_LINES       #= !LVL_LINES
!OW_LINES        #= !OW_LINES
!PADDING         #= !PADDING
!LVL_POS_Y       #= !LVL_POS_Y
!OW_POS_X        #= !OW_POS_X
!OW_POS_Y        #= !OW_POS_Y
!LINE_SPACING    #= !LINE_SPACING
!SPACING_CHANNEL #= !SPACING_CHANNEL
!GROW_SPEED      #= !GROW_SPEED
!LVL_PALETTE     #= !LVL_PALETTE
!OW_PALETTE      #= !OW_PALETTE
!LVL_VRAM        #= !LVL_VRAM
!OW_VRAM         #= !OW_VRAM
!DYNAMIC_PALETTE #= !DYNAMIC_PALETTE

if !LVL_POS_Y < 2 || !LVL_POS_Y >= 224
	error "!", "LVL_POS_Y must be in the at least 2 and less than 224"
endif

if !LVL_WIDTH > 256 || !OW_WIDTH > 256
	error "line width can't be above 256; the screen isn't wide enough"
endif

if (!LVL_VRAM&$3f)|(!OW_VRAM&$3f)
	error "VRAM targets must be divisible by $40 (64)"
endif

if !LVL_PALETTE&$e3 != $60
	error "!", "LVL_PALETTE must be one of the following values: $60, $64, $68, $6c, $70, $74, $78, $7c"
endif

; this is a really hacky check,
; but ive had multiple people forget to do this and get confused,
; so i feel like the check is important
if read1($0ff9f7) == $ff || read1($0ff9f7) == $60
	print "This patch requires Lunar Magic's layer 3 graphics reload to avoid graphical corruption."
	print "Please enable Layer 3 GFX/Tilemap Bypass (the green poison mushroom) in at least one level"
	print "before applying this patch."
	print ""
	error "Missing LM Hijack"
endif

if !OVERWORLD && read1($03bb20) == $ff
	print "You have enabled !","OVERWORLD, but are missing the LM level names hijack this patch requires. "
	print "Please edit a level name in Lunar Magic before applying this patch."
	print ""
	error "Missing LM Hijack"
endif
