!FreeRAM = $1F48                ; Byte to store previous on/off state

init:
  STZ !FreeRAM
  RTL

main:
  LDA $14AF                     ; Only execute if on/off state changed this frame
  CMP !FreeRAM
  BEQ Return
  STA !FreeRAM

  ; DO STUFF

  LDA $14AF
  BEQ Interact

  LDA #%00110000                ; Make sprites render with add blend mode (fake transparency)
  STA $40
  LDA #$02                      ; Set mario to not interact with sprites
  STA $13F9

  LDX #!sprite_slots-1
  SpriteLoop:
  LDA $14C8,x                   ; Make mario drop any carried sprites
  CMP #$0B
  BNE .next
  LDA #$0A
  STA $14C8,x
  .next
  DEX
  BPL SpriteLoop
  BRA Return

  Interact:
  LDA #$24                      ; Restore default CG mode
  STA $40
  STZ $13F9                     ; Set mario to interact with sprites as normal

  Return:
  RTL