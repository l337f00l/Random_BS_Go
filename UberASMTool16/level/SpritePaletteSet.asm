!Shell = $06				   ; Sets the shell variable to 06 (blue koopa/shell)

main:
  LDA $14AF
  BNE Transparent

  Normal:
  LDX #!sprite_slots-1          
  .loop:
  LDA $14C8,x
  BEQ .next

  LDA $009E,x                   ; Ignore sprites except number 06 (blue koopa/shell)
  CMP #!Shell
  BNE .next
  
  ;LDA $009E,x                   ; Ignore sprite number 07 (yellow koopa/shell)
  ;CMP #$07
  ;BEQ .next

  LDA $15F6,x                   ; Load sprite properties
  AND #%11110001                ; Mask out palette bits
  ORA #%01000110              
  ;ORA #%00001100                ; Add palette bits (sprite palette E)
  STA $15F6,x                   ; Store new sprite properties
  .next:
  DEX
  BPL .loop
  RTL

  Transparent:
  LDX #!sprite_slots-1          
  .loop:
  LDA $14C8,x
  BEQ .next

  LDA $009E,x                   ; Ignore sprites except number 06 (blue koopa/shell)
  CMP #!Shell
  BNE .next
  
  ;LDA $009E,x                   ; Ignore sprite number 07 (yellow koopa/shell)
  ;CMP #$07
  ;BEQ .next

  LDA $15F6,x                   ; Load sprite properties
  AND #%11110001                ; Mask out palette bits
  ORA #%00001110                ; Add palette bits (sprite palette F)
  STA $15F6,x                   ; Store new sprite properties
  .next:
  DEX
  BPL .loop
  RTL