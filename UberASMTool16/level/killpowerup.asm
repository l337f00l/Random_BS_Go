main:
  LDA $19            ; powerup state
  BNE .kill          ; kill if not small mario

  LDA $1490|!addr    ; star timer
  BNE +
  RTL
+
  STZ $1490|!addr    ; reset timer so this isn't continually triggered

.kill:
  JSL $00F606|!bank
  RTL