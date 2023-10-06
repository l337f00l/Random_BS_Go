;=============================================================;
; Carryable sprites inventory, by Abdu
; Inventory like system where you can store carryable sprites
; Note that currently it does not support custom sprites.
; Insert as level asm.
;=============================================================;

;; !Max+1 is the total number of freeram bytes used.
;; !Freeram = number of sprites currently in the inventory
;; !Freeram + 1 = sprite number, !Freeram + 2 = sprite number, ... !Freeram + !Max = sprite number

;; So index 0 of Freeram is the total number of items in the inventory
;; Item 1 will be Freeram index 1, item 2 Freeram index 2,... last item will be at freeram index !Max
;; Using the stack method the value at index 0 in free ram which is just !Freeram can be used as index
;; to get the most recently added sprite and spawn it.
;; Old me didn't account for the P-Balloon and cloud so yeah.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Modes
; !Default = 1 ; this mode has a stack, queue and a selector mode.


!Freeram 	= $0F5E|!addr ; make sure you have !Max+1 bytes (current freeram is 20 bytes)
!Max 		= 8 				; Max number of sprites allowed in the inventory
!Selector 	= !Freeram+!Max+1 ; free ram which will contain an
							; index to our byte of freeram to get the sprite number,
 							; also could be used as the head of the queue 

!ButtonRAM 			= $18
!StoreSpawnButton 	= $10	; uses $18 Format axlr---- a = A; x = X; l = L; r = R; - = NULL/unused
!NextSprite 		= $20	; uses $18 Format axlr---- a = A; x = X; l = L; r = R; - = NULL/unused
; if !sprtDrawNum is more than 8 YOU MUST add/remove more values to sprtTileXPos and sprtTileXPos tables
!sprtDrawNum = 7 

; MAKE SURE THAT AT ONLY ONE OF THEM IS SET TO 1
!Queue 	= 0 	; Will dequeue things from the item inventory like a queue so First In First Out (FIFO).
!Stack 	= 0 	; Will pop things from the item inventory like a stack so Last In First Out (LIFO).
!Select = 1 	; Loop through all items in the inventory and spawn whatever you want. 

!storeSFX 	= $0B
!spawnSFX 	= $0C
!wrongSFX 	= $2A
!fireSpit 	= $06
!port 		= $1DFC


; Sprite numbers.
!ThrowBlock 	= $53
!Key 			= $80
!BluePOW 		= $3E
; yes ik it is 3E but here in freeram it stored as $3F (because I don't want waste any more freeram) 
; to know if a blue or silver pswitch is stored so I can load in the right properties 
!SilverPOW 		= $3F
!Goomba 		= $0F
!BabyYoshi 		= $2D
!Spring 		= $2F
!Bomb 			= $0D
!MechaKoopa 	= $A2
!GreenShell 	= $04
!RedShell 		= $05
!BlueShell 		= $06
!YellowShell 	= $07
!SpecialShell 	= $09
!BuzzyBeetle 	= $11



; Sprite graphic tile numbers and tile properties

; NOTE you could probably modify all of these but just make sure that they all 
; load the tiles from the correct page, so change these if you know what you are doing
; (basically make sure $0203,x(or y) loads the properties correctly, remember YXPPCCCT)
; YXPPCCCT (those are bits if you aren't fimilar)
; Y = vertical flip
; X = horizontal flip
; PP = Tile prority (basically going behind or above layers)
; CCC = Palette
; T = Tile index (ninth bit, basically detremines what page [basically the SP file] to load the tile from)

; Tile properties.
!Pal8 = $30 ; Same as flying blocked or brown for platform
!Pal9 = $32 ; Grey
!PalA = $34 ; Yellow
!PalB = $36 ; Purple
!PalC = $38	; Red
!PalD = $3A ; Green
!PalE = $3C ; Dark greyish
!PalF = $3E ; Dino color

;Sprite graphic tile.
; assuming you are using the default GFX files to load these tiles
; these get loaded to $0202,x(or y)
!TBTile 			= $40 	; SP1 = GFX00 
!PSwitchTile 		= $42 	; SP1 = GFX00

!KeyTile 			= $EC  	; SP2 = GFX01 
!GoombaTile 		= $A8 	; SP2 = GFX01 
!ShellTile	 		= $8C 	; SP2 = GFX01
!YoshiTile 			= $A6	; SP2 = ExGFX## (could modify this, currently replaces bullet bill) 
!SpringTile 		= $C2	; SP2 = ExGFX## (could modify this, currently cloud game coin)
!Cursor 			= $80 	; SP1

!MechaKoopaTile 	= $40 	; SP3 = GFX24
!BombTile 			= $CA 	; SP4 = GFX02
!BuzzyBeetleTile 	= $80



!NumSprites = 15 ;total number of sprites we have in these tables


spriteNumTable: db !ThrowBlock, !Key, !BluePOW, !SilverPOW
				db !Goomba, !BabyYoshi, !Spring, !Bomb, !MechaKoopa
				db !GreenShell, !RedShell, !BlueShell, !YellowShell
				db !SpecialShell, !BuzzyBeetle  

spritePropsTable: db !PalB, !Pal8, !PalB, !Pal9
				  db !PalA, !PalD, !PalD, !PalB+1, !PalD+1
				  db !PalD, !PalC, !PalB, !PalA
				  db !PalD, !PalE+1

spriteTileTable: db !TBTile, !KeyTile, !PSwitchTile, !PSwitchTile
				 db !GoombaTile, !YoshiTile, !SpringTile, !BombTile, !MechaKoopaTile
				 db !ShellTile, !ShellTile, !ShellTile, !ShellTile
				 db !ShellTile, !BuzzyBeetleTile




init:
	LDA #$00 : STA !Freeram : STA !Selector
	LDX #!Max
	.loop
	LDA #$FF
	STA !Freeram,x
	DEX
	BNE .loop
RTL


dropXOffsetLow: db -$0D, $0D ; how far off Mario will the sprite drop (format: right, left)
dropXOffsetHigh: db $FF, $00

POWPal: db $06, $02 ; format: blue silver
shellPal: db !PalD, !PalC, !PalB, !PalA

sprtTileXPos: db $10, $30, $50, $70, $90, $B0, $D0, $F0
sprtTileYPos: db $30, $30, $30, $30, $30, $30, $30, $30



; table that contains all the stunable sprites
; also having a table allows more customization
!numStunable = 4
!stunTimer = $FF
stunableSprites: db !Bomb, !Goomba, !BuzzyBeetle, !MechaKoopa

main:


	; if !Default == 1

		LDA $9D 	;\
		ORA $13D4 	;| game not pause or player not dying then don't return
		BEQ + 		;/
		RTL
	+
		JSR Draw 	; draw the tile
		
		LDA !ButtonRAM 			; 
		AND #!StoreSpawnButton 	; if R is pressed... then do stuff
		BNE + 					; if not pressing anyting then just return or if selector mode is set then do that
		if !Select == 1
			JSR SelectSprt
		endif

		RTL

	+	LDA $1470 				;\
		ORA $148F 				;| Check if currently carrying sprite
		BEQ + 					;/ if not then see if we can spawn something from the inventory	
		JSR  Store
		RTL

	+	JSR Spawn	
		; endif

Ret:
	RTL


	

; write/draw the sprite(s) to OAM
Draw:

	LDA !Freeram ;\ if the total number of items in the inventory 
	BNE +  		 ;/ is 0 then there is nothing to draw so just skip drawing
	RTS
 +	
 	
 	STA $01
 	STZ $02 ; will contain the number of tiles drawn so far, also used as index to the spritetileXpos table
 	
 	if !Stack == 1
 		LDA !Freeram : TAX ; use the number of items in our inventory as an index
 		STX $03

 	elseif !Select == 1 || !Queue == 1
 		LDA !Selector : TAX ; use the selector as an index
 		STX $03
 	endif

 	.next
	LDY #$00
	.OAMLoop

	LDA $0201|!addr,y ;\ 
	CMP #$F0 	;| Check if OAM slot is empty
	BEQ .draw 	;/ if it is then draw the tile

	INY #4 			; increment X 4 times to check the next slot
	CPY #$FC 		;\ check if X reached the final slot (0200+FC, 0201+FD, 0202+FE, 0202+FF) 
	BNE .OAMLoop 	;/ if it didnt keep searching for a slot
	RTS ; no slot found 
	
	.draw
	LDX $02 : LDA sprtTileXPos,x : STA $0200|!addr,y ; store X pos of tile to OAM
	LDA sprtTileYPos,x : STA $0201|!addr,y ; store Y pos of tile to OAM

	LDX $03 		; load index of the tile to draw
	


	.tileLoop
 	LDA !Freeram,x 	;\
 	CMP #$FF 		;| remember that #$FF means the slot is empty
 	BNE + 			;/ if it is nt #$FF then a sprite has been found 
 	if !Stack == 1
 		DEX
 		STX $03

 	elseif !Select == 1 || !Queue == 1
 		INX 				;\ increment X
 		STX $03 			;| store it for later use
 		CPX #!Max+1 		;| check if we reached the max+1
 		BNE .tileLoop 		;| if we didn't then reach the max then go to the next iteration
 		LDX #$01 			;| if we did then reset our index
 		STX $03 			;/ store it
 	endif


 	BRA .tileLoop 		; branch to the begining of the loop
 +	INC $02


	LDX #!NumSprites-1 
	.spriteLoop 				;loop through all the sprites in our table
		CMP spriteNumTable,x 	; check if the sprite in our freeram is 
		BEQ +					; found the sprite so branch to write tile and properties to OAM
		DEX 					; decrement our counter
		BPL .spriteLoop 		; go to next iteration if we still have sprites left
		RTS 					; sprite doesn't exist in our table

 	+ LDA spriteTileTable,x : STA $0202|!addr,y 
 	LDA spritePropsTable,x : STA $0203|!addr,y
	TYA : LSR #2 : TAY : LDA #$02 : STA $0420|!addr,y ; remember that the table at 0200-0300 is 4 indexes per slot so we need to divide by 4 to get the slot at $0420
 	

	if !Stack == 1 ; if we are in stack mode then 
		DEC $03

	elseif !Select == 1 || !Queue == 1 ; COULD have the queue as its own case and just increment it without having
		INC $03 		; if we already drew a tile then we need to increment our index
		LDX $03
		CPX #!Max+1 	; check if it is beyond the maximum if it is then  reset to 1
 		BNE .noReset 	; if not start looping
 		LDX #$01
 		STX $03
 	endif
 	

 .noReset 
 	LDA $02 ; check if we drew already reached the total number of 
 	CMP $01 ; sprites we have in our ineventory
 	BEQ +
 	CMP #!sprtDrawNum 	;\ or check if we reached the max num specified
 	BNE .next			;/ if we did then go to draw the next sprite
 


 + 	if !Select == 1 ; if in select mode we need to draw the cursor
 	LDY #$00
	.cursorLoop

	LDA $0201|!addr,y ;\ 
	CMP #$F0 	;| Check if OAM slot is empty
	BEQ .drawCursor 	;/ if it is then draw the tile

	INY #4 			; increment X 4 times to check the next slot
	CPY #$FC 		;\ check if X reached the final slot (0200+FC, 0201+FD, 0202+FE, 0202+FF) 
	BNE .cursorLoop ;/ if it didnt keep searching for a slot
	RTS 			; no slot found 
	.drawCursor
	LDA #$05 : STA $0200|!addr,y ; store X pos of tile to OAM
	LDA #$30 : STA $0201|!addr,y ; store Y pos of tile to OAM 
	LDA #$80 : STA $0202|!addr,y
	LDA #$38 : STA $0203|!addr,y
	TYA : LSR #2 : TAY : LDA #$00 : STA $0420|!addr,y
	endif

 RTS


; store the sprite to inventory

; $00 will contain the index to our inventory
; $01 will contain the sprite index
; $02 Contains sprite number

Store:
	LDX #!sprite_slots-1 	;\ number of sprite slots
	.spriteLoop  			;| Loop that goes through all the sprite slots
	LDA !14C8,x 			;| and checks which sprite is currently being carried.
	CMP #$0B 				;| check if sprite is in carried state
	BEQ .store 				;| if it is then we store the sprite
	DEX 					;| else we decrement Y
	BPL .spriteLoop 		;/ if Y is still postive (0 here is positive) then we keep looping through the sprites
	RTS


	.store
	LDA !Freeram 								 ;\ In stack mode this will be used as an index
	CMP #!Max 									 ;| if we already have Max items in the inventory
	BEQ .cantStore 								 ;/ then just make a "wrong" noise

	; if we are here then we can add an item to the inventory

	if !Select == 1 || !Queue == 1 ; Since both find the most recent empty spot to store the sprite we can do this
	LDA !Freeram
	BNE + 	; if the number of items we have is 0 then our seletcor will point to the first index in the inventory
	LDA #$01 : STA !Selector
	+
	endif
	
	
	STX $01 						;  load sprite index to $01
	LDA !9E,x 						;  get sprite number into A
	STA $02
	CMP #!BluePOW
	BNE .notPOW
	; since there are two types of P-Switches and I am lazy and I dont want to waste freeram I add 0 if its blue and 1 if its grey
	CLC : ADC !151C,x : STA $02						 ; get POW type so if it is still 3E then it is blue if it is 3F then its silver
	.notPOW

	if !Stack == 1
		LDA !Freeram : INC : STA $00 	 ; incrementing since the stack stores in the newest index
	elseif !Select == 1  	

	JSR FindInvSlot 		; will find an empty slot in the inv


	elseif !Queue == 1

	JSR FindInvSlotQueue 	; will find an empty slot in the inv

	endif


	LDA $02 : LDX $00 : STA !Freeram,x 		 	 ; store the sprite number in freeram index X
	LDA !Freeram : INC A : STA !Freeram 		 ; increment the number of items in the inventory
	LDX $01 : STZ !14C8,x
	LDA #!storeSFX
	STA !port
	RTS
	
	.cantStore
	wrongNoise:
	LDA #!wrongSFX
	STA !port

RTS



; spawning the sprite whenever a certain button is pressed

; $00 will contain curent index to our freeram which sprite got spawned
; $01 contains the current processing sprite index
; $02 conatins the sprite number to be spawned which is gotten from freeram

Spawn:	
	LDA $187A|!addr 	;\ if on yoshi dont allow player to spawn a sprite
	BNE wrongNoise		;/
	
	LDA !Freeram 		;\ Store the current total number of sprites in scratch ram
	STA $00 			;/ which is also used as an index to our inventory
	BEQ wrongNoise		; if we have nothing in our inventory then there is nothing to spawn and nothing to draw so return

	JSL $02A9DE|!bank 		;\ check if there is a free sprite slot
	BMI wrongNoise 		;/ if there isn't just branch
	
	TYX
	STX $01
	.emptySlot 		; if we are here then we found a empty sprite slot

	if !Stack == 1
		LDX $00 		;\ load our total number of items in the inventory
		LDA !Freeram,x 	;| index our Freeram (for now lets call it table) to get the sprite number to spawn
		STA $02 		;/ store the sprite num in scratch ram for possible later use.

	elseif !Select == 1 || !Queue == 1

		LDA !Selector	;\ load index of the current sprite the selector is pointing to
		TAX 			;| store in X to index Freeram
		LDA !Freeram,x 	;| index our Freeram (for now lets call it table) to get the sprite number to spawn
		STX $00 		;| store the spawned sprite index 
		STA $02 		;/ store the sprite num in scratch ram for possible later use.
	endif

	; now whenever we are here A will already have the sprite number
	CMP #!SilverPOW 				;\ if the sprite number is #$3F then we need to load in #$3E
	BNE + 					;| if not we just load in what we already have in A
	LDA #!BluePOW 				;/ 

 +				 
 	LDX $01 			; get sprite index from scratch RAM
	STA !9E,x 			; store sprite number
	
	LDA #$01 			;\ make the state to be init so reset sprite tables routines can load in proper values
	STA !14C8,x 		;/
	JSL $07F7D2|!bank		; reset most sprite tables and set some tables
	
	LDA #$0B  			; make the sprite in carried state (will be changed to carryable if not holding Y currently)
	STA !14C8,x 
	
	LDA $02  			; remeber that $02 contains the value we got from our freeram table
	LDY #!numStunable-1
	
	.stunAbleLoop
	CMP stunableSprites,y
	BEQ .setTimers
	DEY
	BPL .stunAbleLoop

	SEC : SBC #!BluePOW ;\
	CMP #$02 			;| if the sprite num is 3E or 3F, remember if 3F then it is a silver pow else it is a blue one
	BCS ++				;/

	STA !151C,x
	TAY
	LDA POWPal,y
	STA !15F6,x
	LDA #!BluePOW : STA !9E,x
	BRA ++


	.setTimers
	LDA #!stunTimer
	STA !1540,x
	STA !C2,x


 ++	LDA $76 : EOR #$01 : STA  !157C,x ; make sprite face the direction the player is facing


	; if the player isnt holding Y the sprite will end up spawning at a random location so this is needed
	LDA $15
	AND #$40 		; byetUDLR format
	BNE .holdingXY ; if player is holding Y or X then no need to set sprite position (maybe)

	LDY $76
	LDA $D1 					; Player's X Pos (low byte) in the level in the current frame
	CLC : ADC dropXOffsetLow,y 	; add X offset for the low byte
	STA !E4,x 					; store X pos low byte

	LDA $D2 					; Player's X Pos (high byte) in the level in the current frame
	ADC dropXOffsetHigh,y 		; add X offset for the high byte
	STA !14E0,x 		  		; store X pos high byte

	LDA $D3 : STA $D8,x ; store Player's Y Pos (low byte) in the level in the current frame to sprite Y pos low byte
	LDA $D4 : STA !14D4,x ; store Player's Y Pos (high byte) in the level in the current frame to sprite Y pos high byte
	
	LDA #$09 	;\ set sprite to be carryable
	STA !14C8,x ;/

	LDA #$0F : STA !154C,x ; don't interact with the player for a certain ammount of frames (useful if he sprite is getting kicked?
	
	.holdingXY
	LDX $00 : LDA #$FF : STA !Freeram,x ; set the sprite number at the index of where it was stored in freeram to be to indicate there is nothing there 
	LDA !Freeram : DEC A : STA !Freeram ; decrement the number of items in our inventory
	
	LDA #!spawnSFX
	STA !port

 ; will change our selector to the next sprite avaliable
 if !Select == 1 || !Queue == 1
	LDA !Freeram 		;\ if there is no sprites left
	BEQ + 				;| in the inventory then no need to set the selector
	LDA !Selector 		;| if not then we increase the index by 1 and loop to find the next
	INC A  				;| availible sprite in our ineventory.
	TAX 				;| store the selector index+1 in X
	BRA selectorLoop 	;/ branch to the loop that gets us the selector
	+
 endif
RTS


; Routine that will change the selector to point
; to the next sprite in our inventory
;
SelectSprt:
	LDA !ButtonRAM 			;
	AND #!NextSprite 		; check if L is pressed 
	BNE +
	RTS
 + 	LDA !Selector
 	INC A
 	TAX

 	LDA !Freeram 	;\ need to check some edge cases first
 	BEQ rets 		;| if we have no items then we just return
 	CMP #$01 		;| one item we also just return
 	BEQ rets 		;/ 


	LDA #!fireSpit
 	STA !port
 	
 	selectorLoop:
 	CPX #!Max+1
 	BCC +
 	LDX #$01
 
 +	LDA !Freeram,x
 	CMP #$FF
 	BNE +
 
 	INX
 	BRA selectorLoop
 
 +	TXA : STA !Selector
 	

 rets: 

 RTS


; Routine that will find us an empty slot in our inventory 
; uses $02

; the index to the inventory will be stored

; which will be used to index our freeram to store the item
 

; should never ever JSR to this while our inventory is full 
; because it will infinite loop but added a check just incase and
; Results: CLC = found slot, SEC = didn't find slot
; scratch ram $00 and X will also be the index
; $02 cotnains the number of sprites 
FindInvSlot:
 	STZ $00
 	LDX #$00
 	.loop
 	
 	LDA $00
 	CMP #!Max
 	BEQ +

 	INX
 	LDA !Freeram,x
 	CMP #$FF
 	BNE .loop
 	STX $00
 	CLC
 	RTS
 + SEC 
RTS 



FindInvSlotQueue:
 LDA !Freeram
 BEQ ++
 LDA !Selector : TAX

 .loop
 LDA !Freeram,x
 CMP #$FF
 BEQ +
 INX
 CPX #!Max+1
 BNE +++
 LDX #$01
 +++ BRA .loop
 + STX $00
 RTS
 ++ LDA #$01 : STA $00
RTS 

clearInv:
	LDA #$00 : STA !Freeram : STA !Selector
	LDX #!Max
	.loop
	LDA #$FF
	STA !Freeram,x
	DEX
	BNE .loop
RTS