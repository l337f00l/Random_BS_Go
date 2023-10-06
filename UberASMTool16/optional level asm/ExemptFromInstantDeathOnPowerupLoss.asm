; Refer to InstantDeathOnPowerupLoss.asm in /Library/. 
; You'd use this to *exempt* levels from Mario dying upon powerup loss.

!freeRAM = $13E6   ; same FreeRAM address as in main file

init:
    INC !freeRAM
    RTL