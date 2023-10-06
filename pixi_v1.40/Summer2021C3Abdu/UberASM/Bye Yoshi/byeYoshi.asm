;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UberASM that makes Yoshi explode after a certain amount of time the player is on Yoshi
;; or just explode yoshi after some period of time even if the player isn't on Yoshi.
;;
;; this can be inserted as gamemode 14 or level asm.
;;
;; by Abdu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!FreeRam            = $0DC3|!addr          ; NOTE: make sure to change this if you have any freeram conflicts.
!StayOnYoshiTimer   = $30                  ; Timer
!explosionTimer     = $40                  ; how long the explosion lasts, 64 frames so around 1 second
!Reset              = 1                    ; if set will reset the timer whenever the player isn't on yoshi.
!GiveWarning        = 1                    ; 0 no warning sound will be given, 1 warning sound will be given. 
!StartWarning       = $10                  ; you could do something like !explosionTimer/2
!WarningSound       = $2A
!port               = $1DFC|!addr
!Frequency          = $07                  ; frequency to decrease timermake sure this value is a (power of 2)-1, so values like $00, $01, $03, $07, etc work fine
!InstaHurt          = 0                    ; make the player die immediately

init:
    LDA #!StayOnYoshiTimer
    STA !FreeRam
RTL

main:
    LDA $9D                 ;\ Game is frozen.
    ORA $13D4|!addr         ;| check if the game is paused 
    BEQ +                   ;/
    RTL

    +
    LDX $18DF|!addr                   ;\
    BNE +                             ;/ if there is a yoshi then just branch

    LDA #!StayOnYoshiTimer            ;\ if there is no yoshi just set timer and return    
    STA !FreeRam                      ;/
    RTL
    +
    DEX                               ; need to decrement by 1 to access yoshi sprite slot
    if !Reset
        LDA $187A|!addr               ; If the player is on yoshi
        BNE +                         ; then decrease timer
        LDA #!StayOnYoshiTimer        ;\ Not on yoshi so just set the timer 
        STA !FreeRam                  ;/
        RTL
    endif
    
    +
    LDA $14
    AND #!Frequency
    BNE +
    DEC !FreeRam                      ; decrease the time on yoshi
    BEQ .boom                         ; if  the timer didnt hit 0 yet then 
    if !GiveWarning
        LDA !FreeRam                  ;\ Warn the player ahead of time 
        CMP #!StartWarning            ;| that Yoshi is about to explode
        BCS +                         ;|
        LDA $14                       ;|
        AND #$07                      ;| every 8 frames 
        BNE +                         ;|
        LDA #!WarningSound            ;| play a warning sound
        STA !port                     ;/
    endif
    +
    RTL

    .boom

    STZ $187A|!addr
    
    LDA #$0D                           ;\ make sprite a bob-omb
    STA !9E,x                          ;/

    JSL $07F7D2|!bank	               ;  Reset sprite tables
    INC !1534,x                        ; set state to be exploading 
    LDA #$0D                           ;\ Turn off Yoshi drum
    STA $1DFA|!addr                    ;/
    LDA #!explosionTimer               ;\ how long the explosion will last
    STA !1540,x                        ;/
    if !InstaHurt
        LDA $1497|!addr 	           ;\ check if invis frames
        ORA $1490|!addr	               ;| load star power timer
        BNE .Ret	                   ;/ don't hurt if mario has star power
        JSL $00F5B7|!bank              ; hurt Mario
    endif
    
.Ret
RTL
