macro call_library(i)
	PHB
	LDA.b #<i>>>16
	PHA
	PLB
	JSL <i>
	PLB
endmacro

init:
;%call_library(_init)      
RTL

main:
%call_library(AltFloatDelayAndContinuousYoshiFlight_main)
%call_library(LevelConstrainEnable_main)
RTL

load:
;%call_library(_load)
RTL