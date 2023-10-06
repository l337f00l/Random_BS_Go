; Jump-switching SFX have been disabled to avoid glitch 

!SpinJumpSound = $00		;sound effect for spinjump, 04 is default
!SpinJumpBank = $1DFC

!JumpSound = $00		;sound effect for normal jump, 01 default
!JumpSoundBank = $1DFA		;you must change those if using addmusic
				;by default those can be !JumpSound = $2B and !JumpSoundBank = $1DF9
				;Or !JumpSound = $35 and !JumpSoundBank = $1DFC

main:
    LDA $9D                ;don't do things when freeze flag is set
    ORA $75                ;can't perform change underwater
;   ORA $1470|!addr            ;\don't run when carrying item.
;   ORA $148F|!addr            ;/
    ORA $187A|!addr            ;and not when riding yoshi also don't run
    ORA $13D4|!addr            ;and not when game is paused
    BNE .return                ;return if any of above is true

    LDA $72                ;if not in air
    BEQ .return                ;don't run code
    LDA $18 : AND #$30
    BNE .change            ; flip if L/R
.return:
    RTL
.change
    LDA $140D|!addr            ;spinjump into jump or vice versa
    EOR #$01            ;
    STA $140D|!addr            ;
    BNE .spinjump
    LDA #!JumpSound            ;sound effect
    STA !JumpSoundBank|!addr    ;
    RTL
.spinjump:
    LDA #!SpinJumpSound        ;sound effect
    STA !SpinJumpBank|!addr        ;
    RTL