!freeRAM = $0D9C|!addr	; FreeRAM to use for the number of shots. This should NOT be cleared on level load or overworld load, so you retain the shot count
						; when taking your Fire Power to other levels.
						; If freeRAM is $00-$FF, remove the |!addr.

!NoCape = 0				; If set, Mario won't gain a fire shot if he has a Cape.
!NoFlower = 1			; If set, Mario won't gain a fire shot if he already has standard unlimited fire power.

!PowerupSFX = $0A				; Sound effect to play when powering up. Set to $00 to disable.
!PowerupSFXBank = $1DF9|!addr	; SFX bank.

!RevertSFX = $04				; Sound effect to play when firing the final shot and reverting to big Mario. Set to $00 to disable.
!RevertSFXBank = $1DF9|!addr	; SFX bank.

; --------------------

db $42
JMP Shot : JMP Shot : JMP Shot
JMP Return : JMP Return : JMP Return : JMP Return
JMP Shot : JMP Shot : JMP Shot

Shot:
if !NoCape|!NoFlower
LDA $19
if !NoCape
CMP #$02
BEQ Erase
endif
if !NoFlower
CMP #$03
BNE +
LDA !freeRAM
BEQ Erase
endif
endif
+
LDA !freeRAM
CMP #$FF
BEQ +
INC A
+
STA !freeRAM
LDA $19
PHA
LDA #$03
STA $19
PLA
BNE +
LDA #$04
STA $71
LDA #$20
STA $149B|!addr
STA $9D
+
if !PowerupSFX
LDA #!PowerupSFX
STA !PowerupSFXBank
endif

Erase:
%glitter()
%erase_block()

Return:
RTL

if !NoCape && !NoFlower
print "A block that gives a one-shot Fire Flower, unless the player has a Cape or Fire Power."
elseif !NoCape
print "A block that gives a one-shot Fire Flower, unless the player has a Cape."
elseif !NoFlower
print "A block that gives a one-shot Fire Flower, unless the player has Fire Power."
else
print "A block that gives a one-shot Fire Flower."
endif

; --------------------

ORG $00FEB5
autoclean JML CheckShots		; Checks the number of shots left when shooting a fireball, and handles reverting.
NOP

ORG $00F5F9
autoclean dl ZeroShots			; Zero the number of shots when taking damage.

ORG $00F60A
autoclean JML ZeroShotsDeath	; Zero the number of shots when dying.
NOP

freecode

CheckShots:
LDA #$06
STA $1DFC|!addr		; Restore code.

LDA !freeRAM
BEQ End
DEC !freeRAM
BNE End
LDA #$01
STA $19
if !RevertSFX
LDA #!RevertSFX
STA !RevertSFXBank|!addr
endif

End:
JML $00FEBA|!bank

ZeroShots:
STZ !freeRAM
JML $028008|!bank		; Zero freeram then return to normal routine.

ZeroShotsDeath:
LDA #$09
STA $1DFB|!addr
STZ !freeRAM
JML $00F60F|!bank		; Zero freeram then restore original code.